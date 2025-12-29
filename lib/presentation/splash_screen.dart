import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _rotController;
  late final AnimationController _secondController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Timings (adjust as needed)
  final Duration firstDuration = const Duration(seconds: 2);
  final Duration secondAnimDuration = const Duration(milliseconds: 800);
  final Duration secondStartDelay = const Duration(seconds: 1);

  // State to switch between first and second view
  bool _showSecond = false;

  @override
  void initState() {
    super.initState();

    // Make status bar black
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Rotating controller for first splash
    _rotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Second screen animations
    _secondController = AnimationController(
      vsync: this,
      duration: secondAnimDuration,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _secondController, curve: Curves.easeIn));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _secondController, curve: Curves.easeOut),
        );

    // After firstDuration, switch to second splash and start second animation
    Future.delayed(firstDuration, () {
      if (!mounted) return;
      setState(() => _showSecond = true);

      // small delay before playing second animation (as original)
      Future.delayed(secondStartDelay, () {
        if (mounted) _secondController.forward();
      });
    });
  }

  @override
  void dispose() {
    _rotController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery sizes
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    // Image size for the rotating image
    final imageSize = w * 0.55;

    // If still in first splash stage
    if (!_showSecond) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: h * 0.12),
              AnimatedBuilder(
                animation: _rotController,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _rotController.value * 2 * pi,
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

    // Second splash view
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.33),
                    Text(
                      "Get\nStarted\nwith",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Studio\nApp",
                      style: TextStyle(
                        color: primarycolor,
                        fontSize: w * 0.12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        context.go('/sign_in');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: w * 0.07),
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
                                fontSize: w * 0.045,
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
      ),
    );
  }
}
