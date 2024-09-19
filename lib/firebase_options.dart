// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoOYE52Nl9JRJwtNsqW5hVa0mzTxd3qdk',
    appId: '1:709058473936:web:f8e10ef7b5e9cf5ee593d5',
    messagingSenderId: '709058473936',
    projectId: 'instagram-clone-a6ff7',
    authDomain: 'instagram-clone-a6ff7.firebaseapp.com',
    storageBucket: 'instagram-clone-a6ff7.appspot.com',
    measurementId: 'G-3QVW0SK5VY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-wXOSaZi2SePra35ixA38STO6wOyAD7s',
    appId: '1:709058473936:android:124ddd02fdd7c3dde593d5',
    messagingSenderId: '709058473936',
    projectId: 'instagram-clone-a6ff7',
    storageBucket: 'instagram-clone-a6ff7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfs-TWDKzLgqCf3vLuVRrKCPj2FClcpnU',
    appId: '1:709058473936:ios:8594f0fbd16faf06e593d5',
    messagingSenderId: '709058473936',
    projectId: 'instagram-clone-a6ff7',
    storageBucket: 'instagram-clone-a6ff7.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfs-TWDKzLgqCf3vLuVRrKCPj2FClcpnU',
    appId: '1:709058473936:ios:8594f0fbd16faf06e593d5',
    messagingSenderId: '709058473936',
    projectId: 'instagram-clone-a6ff7',
    storageBucket: 'instagram-clone-a6ff7.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoOYE52Nl9JRJwtNsqW5hVa0mzTxd3qdk',
    appId: '1:709058473936:web:374417f1e1c55508e593d5',
    messagingSenderId: '709058473936',
    projectId: 'instagram-clone-a6ff7',
    authDomain: 'instagram-clone-a6ff7.firebaseapp.com',
    storageBucket: 'instagram-clone-a6ff7.appspot.com',
    measurementId: 'G-B85R70TT74',
  );
}