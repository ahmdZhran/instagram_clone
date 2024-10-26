import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/services/firebase_storage_service.dart';
import 'data/repositories/auth_repository.dart';

import '../../core/helper/image_service.dart';

final authDI = GetIt.instance;

class AuthDI {
  Future<void> init() async {
    authDI.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    authDI.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    authDI
        .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
    authDI
        .registerLazySingleton<ImagePickerService>(() => ImagePickerService());

    authDI.registerLazySingleton<AuthRepository>(() => AuthRepository(
          auth: authDI<FirebaseAuth>(),
          firestore: authDI<FirebaseFirestore>(),
          firebaseStorage: authDI<FirebaseStorage>(),
          firebaseStorageService: authDI<FirebaseStorageService>(),
        ));
  }
}
