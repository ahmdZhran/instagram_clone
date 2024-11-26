import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/custom_chached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/helper/extensions.dart';
import '../cubit/explore_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SearchForUserWidget extends StatefulWidget {
  const SearchForUserWidget({super.key});

  @override
  State<SearchForUserWidget> createState() => _SearchForUserWidgetState();
}

class _SearchForUserWidgetState extends State<SearchForUserWidget> {
  final ExploreCubit _exploreCubit = ExploreCubit.getInstance();
  String? username;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      bloc: _exploreCubit,
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              CustomTextFormField(
                fillColor: context.isDart ? null : AppColors.moreLightGrey,
                onChanged: (value) {
                  username = value.trim();
                  if (username != null && username!.isNotEmpty) {
                    _exploreCubit.searchUsers(username!);
                  }
                },
                hintText: context.translate(AppStrings.searchForUser),
                prefixIcon: const Icon(
                  Iconsax.search_normal,
                  color: AppColors.greyColor,
                ),
              ),
              if (state is SearchUserLoading)
                Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                )
              else if (state is SearchUserSuccess)
                if (username == null || username!.isEmpty)
                  const SizedBox.shrink()
                else if (state.users.isEmpty)
                  Center(
                    child: Text(
                      context.translate(AppStrings.noUsersFound),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        var userData = state.users[index];
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              Routes.profileScreen,
                              arguments: userData.uid,
                            );
                            debugPrint('USER UiD ${userData.uid}');
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 5,
                            leading: ClipOval(
                                child: CustomCachedNetworkImage(
                              imageUrl: userData.profileImage,
                              placeholder: const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )),
                            title: Text(userData.username),
                          ),
                        );
                      },
                    ),
                  )
              else if (state is SearchUserFailure)
                const Center(
                  child: Text(
                    "Something went wrong. Please try again!",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
