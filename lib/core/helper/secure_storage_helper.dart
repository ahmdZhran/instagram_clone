import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // Singleton pattern for a single instance of SecureStorageHelper
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() => _instance;
  SecureStorageHelper._internal();

  // FlutterSecureStorage instance
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save a value with a specific key
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Retrieve a value by its key
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a value by its key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all stored values
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
