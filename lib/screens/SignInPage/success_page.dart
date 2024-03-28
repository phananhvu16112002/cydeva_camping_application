
import 'package:cydeva_application/common/Colors/app_colors.dart';
import 'package:cydeva_application/common/bases/custom_button.dart';
import 'package:cydeva_application/common/bases/custom_text.dart';
import 'package:cydeva_application/screens/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  String description = 'Wish you have wonderful expeditions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/Successmark.svg'),
              const SizedBox(
                height: 16,
              ),
              cusTomText('You have successfully', 32, FontWeight.w700,
                  AppColors.neutral09),
              cusTomText(
                  'registered', 32, FontWeight.w700, AppColors.neutral09),
              const SizedBox(
                height: 16,
              ),
              CustomText(
                  message: description,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.neutral07),
              const SizedBox(
                height: 170,
              ),
              CustomButton(
                  buttonName: 'Confirm',
                  backgroundColorButton: AppColors.primary3,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  function: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => HomePage()));
                  },
                  height: 52,
                  width: 342,
                  fontSize: 16,
                  colorShadow: Colors.transparent)
            ],
          ),
        ),
      ),
    );
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
