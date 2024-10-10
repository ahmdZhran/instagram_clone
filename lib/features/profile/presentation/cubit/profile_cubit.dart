import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.sharedPrefHelper) : super(ProfileInitial());

  static const _themeKey = "theme";
  final SharedPrefHelper sharedPrefHelper;

  void toggleTheme(bool isDarkMode)async{
    if(isDarkMode){

    }
  }
}
