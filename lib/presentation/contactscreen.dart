import 'package:flutter/material.dart';
import 'package:studio_app/Components/CustomAppButton.dart';
import 'package:studio_app/Components/CutomAppBar.dart';
import 'package:studio_app/utils/media_query_helper.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final Color bgColor = const Color(0xFF000000);
  final Color cardColor = const Color(0xFF1C1C1E);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color greyColor = const Color(0xFF9E9E9E);
  final Color goldColor = const Color(0xFFE0C06B);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar1(title: "Contact Info", actions: []),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.15 : 16,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Phone no"),
              _inputField(
                controller: phoneController,
                hint: "Enter your mobile number",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: width > 600 ? 22 : 18),

              _label("Email"),
              _inputField(
                controller: emailController,
                hint: "Enter your email address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: width > 600 ? 40 : 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32.0),
          child: CustomAppButton1(
            text: "Update",
            onPlusTap: () {
              if (_formKey.currentState!.validate()) {

              }
            },
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: TextStyle(
      color: whiteColor,
      fontSize: 16,
      fontFamily: "Inter",
    ),
  );

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Color.fromRGBO(190, 190, 190, 1),
        fontFamily: "Inter",
      ),
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: greyColor,
          fontFamily: "Inter",
        ),
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
