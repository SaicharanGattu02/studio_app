import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final Color bgColor = const Color(0xFF000000);
  final Color cardColor = const Color(0xFF1C1C1E);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color greyColor = const Color(0xFF9E9E9E);
  final Color goldColor = const Color(0xFFE0C06B);
  final Color yellowColor = const Color(0xFFFFC107);
  final Color darkGrey = const Color(0xFF222222);

  bool showEarnings = true;

  Widget _statsCard(String title, String value, {bool showBorder = true}) {
    bool isThirdLine = title == "Pending Withdrawals";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
            title,
            style:   TextStyle(
              color: isThirdLine ? Colors.white : const Color(0xffFEBE01),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style:  TextStyle(
              color: isThirdLine ? const Color(0xffFEBE01) : Colors.white,
              fontSize: 15,
            ),
          ),
            ],
          ),
        ),
        if (showBorder)
          DottedBorder(
            color: const Color(0xff656565),
            strokeWidth: 1.2,
            dashPattern: const [3, 3],
            padding: EdgeInsets.zero,
            borderType: BorderType.RRect,
            radius: const Radius.circular(0),
            child: const SizedBox(width: double.infinity, height: 0),
          ),
      ],
    );
  }

  Widget _clientBox(String title, String value,
      {required String path, bool isYellow = false}) {
    return Container(height: SizeConfig.screenHeight*0.11,
      color: isYellow ? primarycolor : whiteColor,
      padding:  EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(path),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              color: isYellow ? Colors.black : const Color(0xffCB9801),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _earningItem(
      String name, String event, String date, String tag, Color tagColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: Text(
              name[0],
              style:  const TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),

            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,  style:const TextStyle(fontSize: 15,color: Colors.white)),
                Text("$event\nJoined on $date",
                    style: TextStyle(
                        color: greyColor, fontSize: 12, height: 1.3,),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xff594300),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================== Withdrawal Item (New Design) ==================
  Widget _withdrawalItem(String month, String date, String upi, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: Text(
              month.substring(0, 1),
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Credit on $date\n in UPI ID $upi",
                  style:const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "₹",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              Text(
                amount,
                style:const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================== MAIN BUILD ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "Stats",
          style: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Stats Card ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: darkGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statsCard("Total Earnings", "5,00,000"),
                  _statsCard("Commission Received", "3,00,000"),
                  _statsCard("Pending Withdrawals", "2,00,000"),
                  _statsCard("This Month Earnings", "50,000",
                      showBorder: false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---------- Client Statistics ----------
            const Text(
              "Client Statistics",
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              width:SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),border: Border.all(color:Colors.transparent)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _clientBox("Base Plan", "20000",
                            path: 'assets/icons/Database.svg',
                            isYellow: false),
                      ),
                      Expanded(
                        child: _clientBox("Standard", "50000",
                            path: 'assets/icons/moon.svg',
                            isYellow: true),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _clientBox("Advance", "11000",
                            path: 'assets/icons/CrownSimple.svg', isYellow: true),
                      ),
                      Expanded(
                        child: _clientBox("Premium", "15486",
                            path: 'assets/icons/Crown.svg', isYellow: false),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _clientBox("Elite", "15000",
                            path: 'assets/icons/CrownCross.svg',
                            isYellow: false),
                      ),
                      Expanded(
                        child: _clientBox("Total Client", "25",
                            path: 'assets/icons/Users.svg', isYellow: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ---------- Earning / Withdrawal Tabs ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => setState(() => showEarnings = true),
                  child: Column(
                    children: [
                      Text(
                        "Earning History",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color:whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (showEarnings)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          height: 2,
                          width: 80,
                          color: goldColor,
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => showEarnings = false),
                  child: Column(
                    children: [
                      Text(
                        "Withdrawal History",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color:whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!showEarnings)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          height: 2,
                          width: 120,
                          color: goldColor,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ---------- Conditional List ----------
            if (showEarnings) ...[
              _earningItem("Abhi", "Wedding Event", "24 Jul 25", "Premium",
                  Color(0xff6BE40E)),
              _earningItem(
                  "Sai", "Birthday Event", "12 Aug 25", "Basic", Color(0xff00DEB2)),
              _earningItem("Raju", "Corporate Event", "09 Sep 25", "Standard",
                  Color(0xffEFB805)),
              _earningItem("Kumar", "Wedding Event", "24 Oct 25", "Advance",
                  Color(0xffC3FE01)),
            ] else ...[
              _withdrawalItem("January", "25 Jan 25", "9123654@hdfcbank", "50000"),
              _withdrawalItem("February", "25 Feb 25", "9123654@hdfcbank", "54645"),
              _withdrawalItem("March", "25 Mar 25", "9123654@hdfcbank", "354682"),
              _withdrawalItem("April", "25 Apr 25", "9123654@hdfcbank", "854684"),
              _withdrawalItem("May", "25 May 25", "9123654@hdfcbank", "6516545"),
            ],
          ],
        ),
      ),
    );
  }
}
