class FirebaseAuthErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'The email address is badly formatted.':
        return "The email address is invalid";
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'too-many-requests':
        return 'Too many unsuccessful login attempts. Try again later.';
      case 'operation-not-allowed':
        return 'Signing in with email and password is not enabled.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';

      case 'email-not-verified':
        return 'Please verify your email before signing in.';

      default:
        return 'An unexpected error occurred.';
    }
  }
}
