import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'app/instagram_app.dart';
import 'core/functions/current_user_stated.dart';

void main() async {
  runApp(const InstagramApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  currentUserStateCheck();
}
