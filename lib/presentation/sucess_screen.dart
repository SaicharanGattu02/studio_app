import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';

class SucessScreen extends StatelessWidget {
  final String text;

  const SucessScreen({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            /// ✅ Center content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ✅ Success Image
                    Image.asset(
                      "assets/images/success.png",   // your PNG path
                      width: w * 0.40,
                    ),

                    SizedBox(height: h * 0.02),

                    /// ✅ Dynamic text
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.022,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ Bottom Button
            Padding(
              padding: EdgeInsets.only(
                bottom: h * 0.03,
                left: w * 0.04,
                right: w * 0.04,
              ),
              child: GestureDetector(
                onTap: () {
                  context.go('/clients_screen');
                },
                child: Container(
                  width: double.infinity,
                  height: h *0.06,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEBE01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Okay",
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

