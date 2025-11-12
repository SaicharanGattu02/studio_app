import 'package:flutter/material.dart';
import 'package:studio_app/Components/CustomAppButton.dart';
import 'package:studio_app/Components/CutomAppBar.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final Color bgColor = const Color(0xFF000000);
  final Color cardColor = const Color(0xFF1C1C1E);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color greyColor = const Color(0xFF9E9E9E);
  final Color goldColor = const Color(0xFFE0C06B);

  final _formKey = GlobalKey<FormState>();

  final holderController = TextEditingController();
  final accNameController = TextEditingController();
  final ifscController = TextEditingController();
  final upiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar1(title: "Bank Details", actions: []),
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
              _label("Account Holder Name"),
              _inputField(
                controller: holderController,
                hint: "Enter account holder name",
                validatorMsg: "Please enter account holder name",
              ),
              SizedBox(height: 18),

              _label("Account Number"),
              _inputField(
                controller: accNameController,
                hint: "Enter account number",
                validatorMsg: "Please enter account number",
              ),
              SizedBox(height: 18),

              _label("IFSC Code"),
              _inputField(
                controller: ifscController,
                hint: "Enter IFSC code",
                validatorMsg: "Please enter IFSC code",
              ),
              SizedBox(height: 18),

              _label("UPI ID"),
              _inputField(
                controller: upiController,
                hint: "Enter UPI ID",
                validatorMsg: "Please enter UPI ID",
              ),
              SizedBox(height: 280),
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
                // All inputs valid — future API call goes here
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _label(String text) =>
      Text(text, style: TextStyle(color: whiteColor, fontSize: 16));

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required String validatorMsg,
  }) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: controller,
      style: const TextStyle(color: Color.fromRGBO(190, 190, 190, 1)),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: greyColor.withOpacity(0.6)),
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
