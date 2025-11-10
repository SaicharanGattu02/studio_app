import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            width: w,
            height: h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),   // ✅ main side padding
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h*0.1,),

                  /// IMAGE CENTER
                  Center(
                    child: Image.asset(
                      "assets/images/signin.png",
                      width: w * 0.6,
                      height: h * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: h *0.05),

                  Text(
                    'Hello!',
                    style: TextStyle(
                      color: Color(0xFFF5F5F5),
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),

                  SizedBox(height: h*0.02),

                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// USERNAME LABEL
        Text(
          "User Name",
          style: TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: w * 0.035,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.40,
          ),
        ),

        SizedBox(height: h * 0.01),

        /// USERNAME FIELD
        Container(
          width: double.infinity,
          height: h * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.08),
            border: Border.all(
              color: const Color(0xFF7C7C7C),
              width: 1,
            ),
          ),
          child: TextField(
            controller: usernameController,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.035,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
              border: InputBorder.none,
              hintText: "Enter User Name",
              hintStyle: TextStyle(
                color: Color(0xFFCFCFCF),
                fontSize: w * 0.035,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),

        /// ✅ EMAIL ERROR MESSAGE
        if (emailError != null)
          Padding(
            padding: EdgeInsets.only(top: h * 0.004),
            child: Text(
              emailError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: w * 0.032,
              ),
            ),
          ),


        SizedBox(height: h * 0.02),

        /// PASSWORD LABEL
        Text(
          "Password",
          style: TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: w * 0.035,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.40,
          ),
        ),

        SizedBox(height: h * 0.01),

        /// PASSWORD FIELD
        Container(
          width: double.infinity,
          height: h * 0.06,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(w * 0.08),
            border: Border.all(color: Color(0xFF7C7C7C), width: 1),
          ),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.035,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
              border: InputBorder.none,
              hintText: "Enter Password",
              hintStyle: TextStyle(
                color: Color(0xFFCFCFCF),
                fontSize: w * 0.035,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),

        /// ✅ PASSWORD ERROR
        if (passwordError != null)
          Padding(
            padding: EdgeInsets.only(top: h * 0.004),
            child: Text(
              passwordError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: w * 0.032,
              ),
            ),
          ),


        SizedBox(height: h * 0.04),

        /// SIGN IN BUTTON
        InkWell(
          onTap: () {
            String email = usernameController.text.trim();
            String pass = passwordController.text.trim();

            setState(() {
              emailError = null;
              passwordError = null;

              /// ✅ Email Validation
              if (!isValidEmail(email)) {
                emailError = "Enter a valid email";
              }

              /// ✅ Password Validation
              if (pass.length < 5) {
                passwordError = "Password must be at least 5 characters";
              }
            });

            /// If both valid → Navigate
            if (emailError == null && passwordError == null) {
              context.push('/logging');
            }
          },
          child: SizedBox(
            width: double.infinity,
            height: h * 0.065,
            child: Container(
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(w * 0.08),
              ),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: w * 0.045,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




