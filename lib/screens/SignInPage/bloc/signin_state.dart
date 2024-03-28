part of 'signin_bloc.dart';

class SigninState {
  final String phoneNumber;
  final String otpNumber;
  const SigninState({this.phoneNumber = '', this.otpNumber = ''});

  SigninState copyWith({String? phoneNumber, String? otpNumber}) {
    return SigninState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        otpNumber: otpNumber ?? this.otpNumber);
  }
}

class SigninSuccess extends SigninState {
  SigninSuccess({super.phoneNumber});
}

class SigninLoading extends SigninState {
  SigninLoading({super.phoneNumber});
}

class SigninFailed extends SigninState {
  SigninFailed({super.phoneNumber});
}

class VerifySuccess extends SigninState {
  String message;
  VerifySuccess({required this.message});
}

class VerifyLoading extends SigninState {}

class VerifyFailed extends SigninState {
  String message;
  VerifyFailed({required this.message});
}
