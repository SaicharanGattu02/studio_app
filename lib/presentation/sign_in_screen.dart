import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/Components/CustomAppButton.dart';
import 'package:studio_app/utils/color_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
  }

  void handleSignIn() {
    final email = usernameController.text.trim();
    final pass = passwordController.text.trim();

    setState(() {
      emailError = null;
      passwordError = null;

      if (!isValidEmail(email)) {
        emailError = "Enter a valid email";
      }
      if (pass.length < 5) {
        passwordError = "Password must be at least 5 characters";
      }
    });

    if (emailError == null && passwordError == null) {
      context.push('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.1),
                Center(
                  child: Image.asset(
                    "assets/images/signin.png",
                    width: w * 0.6,
                    height: h * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: h * 0.05),
                Text(
                  'Hello!',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: h * 0.02),
                Text(
                  "User Name",
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: w * 0.035,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: h * 0.01),
                TextField(
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(hintText: "Enter User Name"),
                ),

                if (emailError != null)
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.004),
                    child: Text(
                      emailError!,
                      style: TextStyle(color: Colors.red, fontSize: w * 0.032),
                    ),
                  ),

                SizedBox(height: h * 0.02),
                Text(
                  "Password",
                  style: TextStyle(
                    color: const Color(0xFFF5F5F5),
                    fontSize: w * 0.035,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: h * 0.01),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(hintText: "Enter Password"),
                ),

                if (passwordError != null)
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.004),
                    child: Text(
                      passwordError!,
                      style: TextStyle(color: Colors.red, fontSize: w * 0.032),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: CustomAppButton1(
            text: "Sign In",
            onPlusTap: () {
              handleSignIn();
            },
          ),
        ),
      ),
    );
  }
}
