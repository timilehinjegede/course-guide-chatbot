import 'package:chatbot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Response<T> {
  Response({
    this.data,
    this.message,
    this.hasError,
  });

  T data;
  String message;
  bool hasError;
}

class ServicesHelper {
  ServicesHelper._();

  static String catchFirebaseException(FirebaseException firebaseException) {
    switch (firebaseException.code) {
      case 'user-disabled':
        return 'Your account has been diabled. Contact support.';
      case 'user-not-found':
        return 'No user found with the provided credentials';
      case 'invalid-credential':
        return 'Credentials provided are incorrect';
      default:
        return Strings.defaultErrorMessage;
    }
  }
}
