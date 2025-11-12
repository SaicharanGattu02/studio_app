import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/presentation/splash_screen.dart' as _controller;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// Make notification bar black
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    /// Navigate after 2 seconds using GoRouter
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/second-splash');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// MediaQuery
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h=size.height;

    /// Responsive sizes
    final imageSize = w * 0.55; // 45% of width

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: h*0.12),
            /// FIRST IMAGE (Rotating)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: child,
                );
              },
              child: Image.asset(
                "assets/images/spash_first.png",
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -imageSize * 0.2),
              child: Image.asset(
                "assets/images/splash_studio.png",
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    /// Start animation after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.only(left: w * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Push main text center
                 SizedBox(height: h * 0.33),

                  Text(
                    "Get\nStarted\nwith",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.10,   // responsive
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    "Studio\nApp",
                    style: TextStyle(
                      color: primarycolor,
                      fontSize: w * 0.12,   // responsive
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  /// BUTTON AT BOTTOM
                  InkWell(
                    onTap: ()
                    {
                      context.go('/signin');
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(right: w * 0.07),
                      child: Container(
                        width: double.infinity,
                        height: h * 0.065,
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.2,
                          vertical: h * 0.013,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFEBE01),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.08),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Sign-In now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF222222),
                              fontSize: w * 0.045,  // responsive
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
