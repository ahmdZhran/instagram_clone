import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/instagram_app.dart';

void main() async {
  runApp(const InstagramApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
