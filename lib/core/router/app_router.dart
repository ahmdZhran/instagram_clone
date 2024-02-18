import 'package:go_router/go_router.dart';
import 'package:instagram_clone/features/auth/presentaion/views/sign_up.dart';

import '../../features/auth/presentaion/views/sign_in.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: '/signInView',
      builder: (context, state) => const SignInView(),
    ),
  ],
);
