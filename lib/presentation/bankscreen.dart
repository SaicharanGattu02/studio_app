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

  final holderController = TextEditingController(text: "Shiva Raj");
  final accNameController = TextEditingController(text: "123654123");
  final ifscController = TextEditingController(text: "123654");
  final upiController = TextEditingController(text: "Shivaraj@hdfcbank");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar1(title: "Bank Details", actions: []),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width > 600 ? width * 0.15 : 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Account Holder Name"),
            _inputField(controller: holderController),
            SizedBox(height: 18),

            _label("Account Name"),
            _inputField(controller: accNameController),
            SizedBox(height: 18),

            _label("IFSC Code"),
            _inputField(controller: ifscController),
            SizedBox(height: 18),

            _label("UPI ID"),
            _inputField(controller: upiController),
            SizedBox(height: 280),


          ],
        ),
      ),
        bottomNavigationBar: SafeArea(child: Padding(
          padding: const EdgeInsets.fromLTRB(16,0,16,20.0),
          child: CustomAppButton1(text: "Update", onPlusTap: (){

          }),
        ),
        )
    );
  }

  Widget _label(String text) => Text(text, style: TextStyle(color: whiteColor, fontSize: 16));

  Widget _inputField({required TextEditingController controller}) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Color.fromRGBO(190, 190, 190, 1)
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: InputBorder.none,    // <-- also no border on focus
        enabledBorder: InputBorder.none,

      ),
    );
  }



  Widget _updateButton(double width) {
    return Center(
      child: Container(
        width: width > 600 ? width * 0.3 : double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(254, 190, 1, 0.4), borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Text("Update", style: TextStyle(color: bgColor, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
