import 'package:chatbot/data/services/services_helper.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<Response> signInWithGoogle() async {
    Response response = Response(hasError: false);
    UserCredential userCredential;
    GoogleSignInAccount googleSignInAccount;
    GoogleSignInAuthentication googleSignInAuthentication;
    GoogleAuthCredential googleAuthCredential;

    try {
      googleSignInAccount = await GoogleSignIn().signIn();

      googleSignInAuthentication = await googleSignInAccount.authentication;

      googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      userCredential = await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);

      response.data = userCredential;

      Logger.value('sign in with google', userCredential.user.toString());
    } on FirebaseException catch (e) {
      String errorMessage = ServicesHelper.catchFirebaseException(e);
      response.hasError = true;
      response.message = errorMessage;

      Logger.error('sign in with google', e.toString());
    } catch (e) {
      response.hasError = true;
      response.message = e.toString();

      Logger.error('sign in with google', e.toString());
    }

    return response;
  }

  Future<Response> signInWithApple() async => null;

  Future<Response> signInWithFacebook() async {
    Response response = Response(hasError: false);
    UserCredential userCredential;
    LoginResult loginResult;
    FacebookAuthCredential facebookAuthCredential;

    try {
      loginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.WEB_ONLY,
      );

      AccessToken accessToken = loginResult.accessToken;
      facebookAuthCredential = FacebookAuthProvider.credential(
        accessToken.token,
      );

      userCredential = await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );

      response.data = userCredential;
      Logger.value('sign in with facebook', userCredential.user.toString());
    } on FirebaseException catch (e) {
      String errorMessage = ServicesHelper.catchFirebaseException(e);
      response.hasError = true;
      response.message = errorMessage;

      Logger.error('sign in with facebook', e.toString());
    } on Exception catch (e) {
      response.hasError = true;
      response.message = e.toString();

      Logger.error('sign in with facebook', e.toString());
    }

    return response;
  }
}
