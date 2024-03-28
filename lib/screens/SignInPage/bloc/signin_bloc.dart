import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cydeva_application/services/API.dart';
import 'package:dio/dio.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(const SigninState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<OTPNumberChanged>(_onOTPNumberChanged);
    on<VerifySubmitted>(_onVerifySubmitted);
  }

  FutureOr<void> _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<SigninState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  FutureOr<void> _onOTPNumberChanged(
      OTPNumberChanged event, Emitter<SigninState> emit) {
    emit(state.copyWith(otpNumber: event.otpNumber));
  }

  FutureOr<void> _onVerifySubmitted(
      VerifySubmitted event, Emitter<SigninState> emit) async {
    try {
      final apiService = API(Dio(BaseOptions(contentType: 'application/json')));
      await apiService.verifyOTP({"code": event.otpNumber}).then((value) {
        if (value.statusCode == 200) {
          print('aloalo success');
          emit(VerifySuccess(message: value.message));
        } else if (value.statusCode == 406) {
          print('aloalo failed');
          emit(VerifyFailed(message: value.message));
        } else {
          emit(VerifyLoading());
        }
      }).catchError((error) {
        emit(VerifyFailed(message: error.toString()));
      });
    } catch (e) {}
  }
}
