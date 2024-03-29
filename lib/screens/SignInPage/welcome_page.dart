import 'package:cydeva_application/common/Colors/app_colors.dart';
import 'package:cydeva_application/screens/SignInPage/otp_page.dart';

import 'package:cydeva_application/common/bases/custom_button.dart';
import 'package:cydeva_application/common/bases/custom_text.dart';
import 'package:cydeva_application/common/bases/custom_text_field.dart';
import 'package:cydeva_application/screens/SignInPage/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String title = 'Welcome Back! Glad to see you, Again!';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: BlocBuilder<SigninBloc, SigninState>(
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        cusTomText(
                            title, 32, FontWeight.w700, AppColors.primaryText),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomText(
                            message: 'Enter your phone number',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText),
                        const SizedBox(
                          height: 4,
                        ),
                        // CustomTextField(
                        //   // filteringTextInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                        //   controller: phoneNumberController,
                        //   textInputType: TextInputType.phone,
                        //   obscureText: false,
                        //   suffixIcon: const IconButton(
                        //       onPressed: null, icon: Icon(null)),
                        //   hintText: 'Phone Number',
                        //   prefixIcon: const Icon(null),
                        //   readOnly: false,
                        //   width: double.infinity,
                        //   height: 56,
                        //   colorHintText: AppColors.neutral05,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Phone number is required';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     context
                        //         .read<SigninBloc>()
                        //         .add(PhoneNumberChanged(phoneNumber: value));
                        //   },
                        // ),
                        TextFormField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          // cursorColor: Colors.black,
                          readOnly: false,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                          obscureText: false,
                          decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: AppColors.neutral05, fontSize: 16),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.neutral05),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              contentPadding: const EdgeInsets.all(20),
                              suffixIcon: IconButton(
                                  onPressed: () {}, icon: const Icon(null)),
                              hintText: 'Phone number',
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.primary3),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone number is required';
                            } else if (value[0] != '0' || value.length < 10) {
                              return 'Phone number is not available';
                            } else {
                              return null;
                            }
                          },

                          onChanged: (value) {
                            context
                                .read<SigninBloc>()
                                .add(PhoneNumberChanged(phoneNumber: value));
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                            buttonName: 'Login',
                            backgroundColorButton: AppColors.primaryButton,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            function: () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            BlocProvider.value(
                                                value:
                                                    BlocProvider.of<SigninBloc>(
                                                        context),
                                                child: const OTPPage())));
                              }
                            },
                            height: 52,
                            width: double.infinity,
                            fontSize: 16,
                            colorShadow: Colors.transparent),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral04)),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const CustomText(
                                message: 'Or Login with',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral04)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            customThirdParty('facebook'),
                            const SizedBox(
                              width: 8,
                            ),
                            customThirdParty('Google'),
                            const SizedBox(
                              width: 8,
                            ),
                            customThirdParty('apple'),
                          ],
                        ),
                        const SizedBox(
                          height: 234,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                                message: "Don't have an account? ",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText),
                            InkWell(
                              onTap: () {},
                              child: const CustomText(
                                  message: 'Register Now',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryButton),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget customThirdParty(String imageName) {
    return Expanded(
        child: Container(
      height: 56,
      width: 108.49,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor)),
      child: Center(child: SvgPicture.asset('assets/icons/$imageName.svg')),
    ));
  }

  Widget cusTomText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(message,
        // overflow: TextOverflow.ellipsis,
        maxLines: null,
        style: GoogleFonts.inter(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
