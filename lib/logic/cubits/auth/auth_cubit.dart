import 'package:bloc/bloc.dart';
import 'package:chatbot/data/models/models.dart' as models;
import 'package:chatbot/data/repositories/auth_repository.dart';
import 'package:chatbot/data/services/services_helper.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : _authRepository = AuthRepository(),
        super(AuthInitial());

  AuthRepository _authRepository;

  Future<void> signInWithGoogle() async {
    emit(
      AuthLoading(
        title: 'Signing you into chatbotname 😎.',
      ),
    );

    Response response = await _authRepository.signInWithGoogle();

    if (!response.hasError) {
      _computeSuccessulAuthProcess(response, Strings.googleLogin);
      emit(
        AuthSuccess(),
      );
    } else {
      emit(
        AuthFailed(
          errorMessage: response.message,
        ),
      );
    }
  }

  Future<void> signInWithApple() async {
    emit(
      AuthLoading(
        title: 'Signing you into chatbotname 😎.',
      ),
    );

    Response response = await _authRepository.signInWithApple();

    if (!response.hasError) {
      _computeSuccessulAuthProcess(response, Strings.appleLogin);
      emit(
        AuthSuccess(),
      );
    } else {
      emit(
        AuthFailed(
          errorMessage: response.message,
        ),
      );
    }
  }

  Future<void> signInWithFacebook() async {
    emit(
      AuthLoading(
        title: 'Signing you into chatbotname 😎.',
      ),
    );

    Response response = await _authRepository.signInWithFacebook();

    if (!response.hasError) {
      _computeSuccessulAuthProcess(response, Strings.facebookLogin);
      emit(
        AuthSuccess(),
      );
    } else {
      emit(
        AuthFailed(
          errorMessage: response.message,
        ),
      );
    }
  }

  Future<void> _computeSuccessulAuthProcess(Response response, String loginType) async {
    final responseData = response.data as UserCredential;
    String uid = responseData.user.uid;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot userDocument = await firebaseFirestore
          .collection(Strings.usersCollection)
          .doc(uid)
          .get();

      if (userDocument.exists) {
        models.User user = models.User.fromFirestore(userDocument.data());
        models.UserState userState = StorageService().getUserState();
        userState = userState.copyWith(
          isLoggedIn: true,
          loginType: loginType,
        );

        _cacheUserAndUserState(user, userState);
      } else {
        models.User user = models.User(
          id: responseData.user.uid,
          firstName: responseData.user.displayName.split(' ').first ?? responseData.user.displayName,
          lastName: responseData.user.displayName.split(' ').last ?? responseData.user.displayName,
          email: responseData.user.email,
          phoneNumber: responseData.user.phoneNumber,
          photoUrl: responseData.user.photoURL,
        );

        models.UserState userState = StorageService().getUserState();
        userState = userState.copyWith(
          isLoggedIn: true,
          loginType: loginType,
        );

        // create a new user
        await firebaseFirestore
            .collection(Strings.usersCollection)
            .doc(user.id)
            .set(user.toFirestore());
        _cacheUserAndUserState(user, userState);
      }
    } on Exception catch (e) {
      Logger.error('auth cubit saving to firestore', e.toString());
    }
  }

  void _cacheUserAndUserState(models.User user, models.UserState userState) {
    StorageService storageService = StorageService();
    storageService.saveUser(user: user);
    storageService.saveUserState(userState: userState);
  }
}
