import 'package:flutter/material.dart';

import '../view_model/auth_cubit/auth_cubit.dart';

void showErrorMessage(BuildContext context, CreateUserFailer state) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(state.errMessage)));
}
