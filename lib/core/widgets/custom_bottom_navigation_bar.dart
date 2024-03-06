import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/models/user_repositry.dart';
import 'package:instagram_clone/features/profile/presentatoin/view_model/profile_cubit/profile_cubit.dart';
import 'bottom_nav_bar.dart';
import '../../features/add_post/presentation/views/add_post.dart';
import '../../features/home/presentation/views/home.dart';
import '../../features/profile/presentatoin/views/profile.dart';
import '../../features/search/presentation/views/search_view.dart';
import '../../features/shorts/presentation/views/shorts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  UserRepositry userRepositry = UserRepositry();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const HomeView(),
          const SearchView(),
          const AddPost(),
          const ShortView(),
          BlocProvider(
            create: (context) => ProfileCubit(userRepositry),
            child: const ProfileView(),
          )
        ],
      ),
    );
  }
}
