import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());

  String getOtp() {
    return _otpControllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    double h = SizeConfig.screenHeight;
    double w = SizeConfig.screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                children: [
                  SizedBox(height: h * 0.15),


                  /// ✅ OTP Image
                  Image.asset(
                    "assets/images/otp.png",
                    width: w * 0.55,
                  ),
                  SizedBox(height: h * 0.05,),

                  otpSection(context, h, w),

                  SizedBox(height: h * 0.15,),



                  /// ✅ Submit OTP Button
                  GestureDetector(
                    onTap: () {
                      String otp = getOtp();
                      print("✅ OTP Entered: $otp");
                      context.push(
                        '/success',
                        extra: "Account Created Sucessfully",
                      );

                    },
                    child: Container(
                      width: double.infinity,
                      height: h * 0.06,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFEBE01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(h * 0.03),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Submit OTP",
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: h * 0.02,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ OTP SECTION
  Widget otpSection(BuildContext context, double h, double w) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Back Icon
          InkWell(
            onTap: ()
            {
              context.pop;
            },
            child: Container(
              width: h * 0.05,
              height: h * 0.05,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF848484),
                ),
                borderRadius: BorderRadius.circular(h * 0.04),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_left,
                  color: Color(0xFFFEBE01),
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.025),

          /// ✅ Enter OTP text
          Text(
            'Enter OTP',
            style: TextStyle(
              color: Colors.white,
              fontSize: h * 0.025,
              fontFamily: 'Segoe UI',
              fontWeight: FontWeight.w600,
              height: 1.20,
            ),
          ),

          SizedBox(height: h * 0.015),

          /// ✅ OTP Info
          Text(
            'OTP sent to the +91 81xxxxxx00',
            style: TextStyle(
              color: const Color(0xFFD2D2D2),
              fontSize: h * 0.020,
              fontFamily: 'Segoe UI',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          SizedBox(height: h * 0.025),

          /// ✅ OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return SizedBox(
                width: w * 0.12,
                height: h * 0.065,
                child: TextField(
                  cursorColor: Colors.white,
                  controller: _otpControllers[index],
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.018,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,

                    fillColor: Colors.white24,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(h * 0.01),
                      borderSide: const BorderSide(
                        color: Colors.white70,
                        width
                            : 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(h * 0.01),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: h * 0.02),

          /// ✅ Resend OTP
          Row(
            children: [
              const Spacer(),
              Text(
                'Resend OTP',
                style: TextStyle(
                  color: const Color(0xFFFEBE01),
                  fontSize: h * 0.02,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFFEBE01),
                  height: 1.50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




