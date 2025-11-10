import 'package:flutter/material.dart';
import '../services/AuthService.dart';
import '../utils/media_query_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  @override
  void initState() {
    super.initState();
    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward().whenComplete(() async {
            final token = await AuthService.getAccessToken();
            final role = await AuthService.getRole();
            if (token == null || token.isEmpty) {
              // context.pushReplacement('/dashboard');
            } else {
              // if (role == "Both") {
              //   context.pushReplacement('/selected_screen');
              // } else

              // context.pushReplacement('/dashboard');
            }
          });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8B5CF6), Color(0xFF2563EB)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/mentivisorlogo.png",
                      width: SizeConfig.screenWidth * 0.2,
                      height: SizeConfig.screenHeight * 0.085,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
