import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';
import '../../features/splsh/presentatoin/view/splsh_view.dart';
import '../../features/auth/presentaion/view_model/auth_cubit/auth_cubit.dart';
import '../../features/auth/presentaion/views/sign_up.dart';
import '../../features/auth/presentaion/widgets/forgot_password_view.dart';
import '../../features/home/presentation/views/home.dart';

import '../../features/auth/presentaion/views/sign_in.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouteConstants.splashRoute,
      builder: (context, state) => const SplshView(),
    ),
    GoRoute(
      path: RouteConstants.signUpRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const SignUpView(),
      ),
    ),
    GoRoute(
      path: RouteConstants.signInRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const SignInView(),
      ),
    ),
    GoRoute(
      path: RouteConstants.homeRoute,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: RouteConstants.forgotPasswordRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const ForgotPasswordView(),
      ),
    ),
  ],
);
