import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../helper/image_picker_service.dart';

final sl = GetIt.instance;

class InjectionContainer {
  Future<void> init() async {
    sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    sl.registerLazySingleton<ImageService>(() => ImageService());

    sl.registerLazySingleton<AuthRepository>(() => AuthRepository(
          auth: sl<FirebaseAuth>(),
          firestore: sl<FirebaseFirestore>(),
          firebaseStorage: sl<FirebaseStorage>(),
        ));

    sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
  }
}
