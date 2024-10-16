// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/features/auth/presentation/screens/login_screen.dart';
// import 'package:instagram_clone/features/home/presentation/screens/home_screen.dart';

// class CheckUserAuthState extends StatelessWidget {
//   const CheckUserAuthState({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           UserE? user = FirebaseAuth.instance.currentUser;
//           if (user == null) {
//             return const LogInScreen();
//           }
//           return user.emailVerified ? const HomeScreen() : const LogInScreen();
//         },
//       ),
//     );
//   }
// }
