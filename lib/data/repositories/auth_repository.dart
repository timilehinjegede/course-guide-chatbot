import 'package:chatbot/data/services/auth/auth_service.dart';
import 'package:chatbot/data/services/services_helper.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  AuthRepository() : _authService = AuthService();

  AuthService _authService;

  Future<Response> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  Future<Response> signInWithApple() {
    return _authService.signInWithApple();
  }

  Future<Response> signInWithFacebook() async {
    return _authService.signInWithFacebook();
  }
}
