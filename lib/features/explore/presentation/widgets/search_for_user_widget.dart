import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/helper/extensions.dart';
import '../cubit/explore_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'dart:async';

class SearchForUserWidget extends StatefulWidget {
  const SearchForUserWidget({super.key});

  @override
  State<SearchForUserWidget> createState() => _SearchForUserWidgetState();
}

class _SearchForUserWidgetState extends State<SearchForUserWidget> {
  final ExploreCubit _exploreCubit = ExploreCubit.getInstance();
  String? username;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();

    username = value.trim();

    if (username == null || username!.isEmpty) {
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (username != null && username!.isNotEmpty) {
        _exploreCubit.searchUsers(username!);
      }
    });
  }

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
                onChanged: _onSearchChanged,
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
                if (state.users.isEmpty)
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
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25.r,
                              backgroundImage: CachedNetworkImageProvider(
                                userData.profileImage,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                              userData.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
