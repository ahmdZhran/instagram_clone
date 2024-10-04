class FirebaseAuthErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address you entered is not valid. Please check and try again.';
      case 'user-disabled':
        return 'Your account has been disabled. Please contact support for help.';
      case 'user-not-found':
        return 'No account found with that email. Please sign up or double-check your email.';
      case 'wrong-password':
        return 'The password you entered is incorrect. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a moment and try again.';
      case 'operation-not-allowed':
        return 'Signing in with email and password is not available. Please contact support.';
      case 'network-request-failed':
        return 'It seems there’s a problem with your internet connection. Please check and try again.';
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger password.';
      case 'email-already-in-use':
        return 'This email is already associated with another account. Try logging in instead.';
      case 'invalid-verification-code':
        return 'The verification code you entered is incorrect or expired. Please check and try again.';
      case 'invalid-verification-id':
        return 'There was a problem verifying your ID. Please try again later.';
      case 'credential-already-in-use':
        return 'This account is already linked to another method of signing in. Please use a different sign-in option.';
      case 'invalid-credential':
        return 'There was an issue with your sign-in credentials. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account with this email already exists but uses a different sign-in method. Try signing in with a different provider.';
      case 'requires-recent-login':
        return 'For security reasons, please log in again to proceed.';
      case 'captcha-check-failed':
        return 'Failed to verify CAPTCHA. Please try again.';
      case 'app-not-authorized':
        return 'This app is not authorized to connect with Firebase Authentication. Please contact support.';
      case 'expired-action-code':
        return 'This link or code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'This link or code is invalid. Please check and try again.';
      case 'session-cookie-expired':
        return 'Your session has expired. Please log in again.';
      case 'invalid-session-cookie':
        return 'There was an issue with your session. Please log in again.';
      case 'invalid-api-key':
        return 'There was a problem with the app configuration. Please contact support.';
      default:
        return 'Oops! Something went wrong. Please try again later.';
    }
  }
}
