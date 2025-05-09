import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  static Future<bool> hasInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

  static Future<void> checkInternetConnection() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      throw ('No internet connection. Please try again.');
    }
  }
}
