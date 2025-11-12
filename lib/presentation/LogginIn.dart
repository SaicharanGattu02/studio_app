import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';

class Logging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.15),

            /// ✅ First Image
            Image.asset(
              "assets/images/running.png",   // change
              width: w * 0.7,
              height: h * 0.33,
              fit: BoxFit.contain,
            ),

            SizedBox(height: h * 0.09),

            Text(
              'Logging in as',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.058,     // ✅ responsive
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.10,
              ),
            ),

            SizedBox(height: h * 0.02),

            Text(
              'Sri Ram Studio',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primarycolor,
                fontSize: w * 0.08,     // ✅ responsive
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

