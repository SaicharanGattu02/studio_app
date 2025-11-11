import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/Components/CutomAppBar.dart';

class Profile extends StatefulWidget {

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // colors (based on your confirmation)
  final Color bgColor =  Colors.black;
  final Color cardColor = const Color(0xFF1C1C1E);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color greyColor = const Color(0xFF9E9E9E);
  final Color goldColor = const Color(0xFFE0C06B);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar1(title: "Profile", actions: []),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.15 : 16, // responsive gap left right
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // studio banner (placeholder for now, you will replace with your widget)
            Image.asset("assets/images/profile_bg.png", fit: BoxFit.cover),

            const SizedBox(height: 16),
            Text(
              "Dphotowala Studio",
              style: TextStyle(color: Color(0xffFBFBFB), fontSize: width > 600 ? 26 : 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              "Shiva Raj",
              style: TextStyle(color: Color(0xffCCCCCC), fontSize: width > 600 ? 20 : 16),
            ),

            const SizedBox(height: 24),

            // Contact Info Card
            _cardItem(
              title: "Contact Info",
              onTap: () {
                context.push("/contact");
              },
            ),

            const SizedBox(height: 12),

            // Bank Details Card
            _cardItem(
              title: "Bank Details",
              onTap: () {
                context.push("/bankdetails");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500)),
            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: goldColor)
          ],
        ),
      ),
    );
  }
}
