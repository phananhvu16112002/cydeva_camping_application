part of 'signin_bloc.dart';

class SigninEvent {}

class PhoneNumberChanged extends SigninEvent {
  final String phoneNumber;
  PhoneNumberChanged({required this.phoneNumber});
}

class SignInSubmiited extends SigninEvent {
  SignInSubmiited();
}

class VerifySubmitted extends SigninEvent {
  String otpNumber = '';
  VerifySubmitted({required this.otpNumber});
}

class OTPNumberChanged extends SigninEvent {
  String otpNumber = '';
  OTPNumberChanged({required this.otpNumber});
}
