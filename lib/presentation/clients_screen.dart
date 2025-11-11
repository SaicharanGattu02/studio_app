import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';
class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  final List<Map<String, String>> dummyClients = const [
    {"name": "Abhi", "event": "Wedding Event", "date": "Joined on 24 Jul 25"},
    {"name": "Rahul", "event": "Birthday Party", "date": "Joined on 10 Jan 25"},
    {"name": "Sandhya", "event": "Corporate Meet", "date": "Joined on 05 May 25"},
    {"name": "Kiran", "event": "Baby Shower", "date": "Joined on 01 Oct 24"},
    {"name": "Nithin", "event": "House Warming", "date": "Joined on 18 Jun 24"},
    {"name": "Harsha", "event": "Engagement", "date": "Joined on 02 Aug 24"},
  ];

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;
    final shortest = MediaQuery.of(context).size.shortestSide;
    bool isTablet = shortest > 600;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "All Clients's",
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.022,    // ✅ responsive
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        child: Column(
          children: [
            searchBar(),
            SizedBox(height: h * 0.02),
            clientsHeader(),
            SizedBox(height: h * 0.02),
            PlanSelector(),
            SizedBox(height: h * 0.02),

            Expanded(
              child:  isTablet
                  ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                ),
                itemCount: dummyClients.length,
                itemBuilder: (context, index) {
                  final client = dummyClients[index];
                  return ClientTile(
                    name: client["name"] ?? "",
                    event: client["event"] ?? "",
                    date: client["date"] ?? "",
                  );
                },
              )
                  : ListView.builder(
                itemCount: dummyClients.length,
                itemBuilder: (context, index) {
                  final client = dummyClients[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: h * 0.015),
                    child: ClientTile(
                      name: client["name"] ?? "",
                      event: client["event"] ?? "",
                      date: client["date"] ?? "",
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Container(
      height: h * 0.06,
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),   // ✅ equal padding for text + icon
      decoration: ShapeDecoration(
        color: const Color(0xFF5C5C5C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.white,
              enableInteractiveSelection: false,        // ✅ prevent white highlight
              style: TextStyle(
                color: Colors.white,
                fontSize: h * 0.02,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
                letterSpacing: 0.50,
              ),
              decoration: InputDecoration(
                filled: false,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
                hintText: "Search Clients",
                hintStyle: TextStyle(
                  color: const Color(0xFFB1B1B1),
                  fontSize: h * 0.02,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.50,
                ),
                border: InputBorder.none,

                // ✅ remove focus/hover glow completely
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          /// ✅ Icon with same spacing
          SizedBox(
            height: h * 0.025,
            width: w * 0.05,
            child: SvgPicture.asset(
              "assets/icons/search_icon.svg",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }



  Widget clientsHeader() {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'List',
          style: TextStyle(
            color: const Color(0xFFF5F5F5),
            fontSize: h * 0.025,   // ✅ responsive
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.01,
          ),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFFFFEDC2),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Create Client',
            style: TextStyle(
              color: primarycolor,
              fontSize: h * 0.018,   // ✅ responsive
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}





class ClientTile extends StatelessWidget {
  final String name;
  final String event;
  final String date;

  const ClientTile({
    super.key,
    required this.name,
    required this.event,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return InkWell(
      onTap: ()
      {
        context.push('/client-details-screen');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(w * 0.04), // ~16px at 400dp width
        decoration: ShapeDecoration(
          color: const Color(0xFF222222),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          children: [
            /// ✅ Circle With Alphabet
            Container(
              width: h * 0.06,         // ~48px if h≈800
              height: h * 0.06,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(h * 0.04), // ~32px
              ),
              alignment: Alignment.center,
              child: Text(
                name.isNotEmpty ? name[0] : "?",
                style: TextStyle(
                  color: const Color(0xFF111111),
                  fontSize: h * 0.02,  // ~16px
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.26,
                ),
              ),
            ),

            SizedBox(width: w * 0.03), // ~12px at 400dp width

            /// ✅ Texts Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: const Color(0xFFF5F5F5),
                    fontSize: h * 0.02,   // ~16px
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.26,
                  ),
                ),
                SizedBox(height: h * 0.0075), // ~6px at 800dp height
                Text(
                  event,
                  style: TextStyle(
                    color: const Color(0xFFB1B1B1),
                    fontSize: h * 0.015,  // ~12px
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xFFB1B1B1),
                    fontSize: h * 0.015,  // ~12px
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/icons/right_arrow.svg",
                width: h * 0.03,   // ~24px
                height: h * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class PlanSelector extends StatefulWidget {
  const PlanSelector({super.key});

  @override
  State<PlanSelector> createState() => _PlanSelectorState();
}

class _PlanSelectorState extends State<PlanSelector> {
  final List<String> plans = [
    "Basic Plan",
    "Standard",
    "Advance",
    "Premium",
    "Elite",
  ];

  int selectedIndex = 0; // ✅ default selected

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(plans.length, (index) {
          final bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: w * 0.025),     // ~10px
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.03,                       // ~12px
                vertical: h * 0.0075,                        // ~6px
              ),
              decoration: ShapeDecoration(
                color: isSelected ? primarycolor : const Color(0xFF555555),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.04),  // ~16px
                ),
              ),
              child: Text(
                plans[index],
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF222222)
                      : const Color(0xFFD0D0D0),
                  fontSize: h * 0.015,            // ~12px
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.19,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


