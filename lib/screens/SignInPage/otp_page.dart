import 'dart:async';

import 'package:cydeva_application/common/Colors/app_colors.dart';
import 'package:cydeva_application/screens/HomePage/home_page.dart';

import 'package:cydeva_application/common/bases/custom_button.dart';
import 'package:cydeva_application/common/bases/custom_text.dart';
import 'package:cydeva_application/screens/SignInPage/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String description =
      'Enter the verification code we just sent on your email address.';
  String otpField = '';
  OtpFieldController otpFieldController = OtpFieldController();
  int secondsRemaining = 59; // Initial value for 1 minute
  int minutesRemaining = 2;
  bool canResend = false;
  late Timer _timer;
  late ProgressDialog _progressDialog;

  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
  //     if (secondsRemaining > 0) {
  //       setState(() {
  //         secondsRemaining--;
  //       });
  //     } else {
  //       setState(() {
  //         canResend = true;
  //       });
  //       timer.cancel();
  //     }
  //   });
  // }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutesRemaining == 0 && secondsRemaining == 0) {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      } else if (secondsRemaining == 0) {
        setState(() {
          minutesRemaining--;
          secondsRemaining = 59;
        });
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  void restartTimer() {
    setState(() {
      secondsRemaining = 59;
      minutesRemaining = 2;
      canResend = false;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _progressDialog = ProgressDialog(context,
        customBody: Container(
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryButton,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        shadowColor: Colors.transparent,
        leading: Container(
            width: 5,
            height: 5,
            child: Container(
                width: 20,
                height: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black),
                ))),
        titleSpacing: 0,
        title: const CustomText(
            message: 'Back',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) async {
          if (state is VerifySuccess) {
            await _progressDialog.hide();
            if (mounted) {
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => const HomePage()));
            }
            // await _progressDialog.hide();
          }
          if (state is VerifyFailed) {
            await _progressDialog.hide();
            failedDialog(context, state);
          }
        },
        child: BlocBuilder<SigninBloc, SigninState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(
                        //   height: 44,
                        // ),
                        // appBar(),
                        const SizedBox(
                          height: 56,
                        ),
                        const CustomText(
                            message: 'OTP Verification',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutral09),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomText(
                            message: description,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.neutral07),
                        const SizedBox(
                          height: 56,
                        ),
                        OTPTextField(
                          controller: otpFieldController,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: AppColors.primary3,
                            borderColor: AppColors.neutral06,
                          ),
                          outlineBorderRadius: 8,
                          keyboardType: TextInputType.phone,
                          fieldWidth: 50,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary3),
                          fieldStyle: FieldStyle.box,
                          onChanged: (pin) {
                            otpField = pin;
                            context
                                .read<SigninBloc>()
                                .add(OTPNumberChanged(otpNumber: pin));
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Resend the code after 0$minutesRemaining:${secondsRemaining.toString().padLeft(2, '0')} ')
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: CustomButton(
                              buttonName: 'Verify',
                              backgroundColorButton: AppColors.primary3,
                              borderColor: Colors.transparent,
                              textColor: Colors.white,
                              function: () async {
                                if (otpField.length == 6) {
                                  _progressDialog.show();
                                  BlocProvider.of<SigninBloc>(context).add(
                                      VerifySubmitted(otpNumber: otpField));
                                } else {
                                  _showMyDialog();
                                }
                              },
                              height: 52,
                              width: 342,
                              fontSize: 16,
                              colorShadow: Colors.transparent),
                        ),
                        const SizedBox(
                          height: 321,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                                message: "Didn't recived code ? ",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryText),
                            InkWell(
                              onTap: canResend
                                  ? () {
                                      restartTimer();
                                    }
                                  : null,
                              child: canResend
                                  ? const CustomText(
                                      message: "Resend ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary3)
                                  : Container(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> failedDialog(BuildContext context, VerifyFailed state) {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Failed OTP'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(state.message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Failed'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check your OTP'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Widget appBar() {
  //   return Container(
  //     width: 342,
  //     height: 32,
  //     color: AppColors.backGroundColor,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: SvgPicture.asset('assets/icons/back.svg')),
  //         const SizedBox(width: 5),
  //         const Text('Back')
  //       ],
  //     ),
  //   );
  // }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        // overflow: TextOverflow.ellipsis,
        maxLines: null,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
