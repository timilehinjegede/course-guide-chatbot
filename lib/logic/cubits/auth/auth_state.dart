part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  AuthLoading({
    this.title,
  });

  final String title;

  @override
  List<Object> get props => [title];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState {
  AuthFailed({
    this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [];
}
