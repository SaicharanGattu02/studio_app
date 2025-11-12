import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/Components/Shimmers.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  bool pendingSelected = false;

  bool completedSelected = false;

  final List<Map<String, String>> events = [
    {"title": "Engagement", "status": "pending", "icon": "assets/icons/engagement.svg"},
    {"title": "Haldi", "status": "pending", "icon": "assets/icons/haldi.svg"},
    {"title": "Wedding", "status": "pending", "icon": "assets/images/wedding.png"},
    {"title": "Reception", "status": "sent", "icon": "assets/images/reception.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: h * 0.030),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          "Client Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.0225, // ~18
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            SizedBox(height: h * 0.03),
            premiumPlanCircle(h, w),
            SizedBox(height: h * 0.05),
            clientTopInfo(h, w),
          //  clientTopInfoShimmer(h, w),
            SizedBox(height: h * 0.02),
            eventsHeader(h, w,context),
            SizedBox(height: h * 0.02),

            /// ✅ List of events MUST SCROLL
            Expanded(child: eventCards(h, w)),
          ],
        ),
      ),
    );
  }

  Widget filterBottomSheet(double w, double h) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: h * 0.02,
            left: w * 0.06,
            right: w * 0.06,
            bottom: h * 0.03,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7F9FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(h * 0.03),
                topRight: Radius.circular(h * 0.03),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ Title
              Text(
                'Filter',
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: h * 0.025,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.32,
                ),
              ),

              SizedBox(height: h * 0.01),

              /// ✅ STATUS TITLE
              Text(
                'Status',
                style: TextStyle(
                  color: const Color(0xFF444444),
                  fontSize: h * 0.02,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.26,
                ),
              ),

              SizedBox(height: h * 0.01),

              /// ✅ STATUS OPTIONS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ✅ Pending
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pendingSelected = !pendingSelected;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: h * 0.025,
                          height: h * 0.025,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 1),
                            color: Colors.white,
                          ),
                          child: pendingSelected
                              ? Icon(Icons.check,
                              size: h * 0.018, color: Colors.black)
                              : null,
                        ),
                        SizedBox(width: w * 0.03),
                        Text(
                          'Pending',
                          style: TextStyle(
                            color: const Color(0xFF666666),
                            fontSize: h * 0.0175,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.008),

                  /// ✅ Completed
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        completedSelected = !completedSelected;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: h * 0.025,
                          height: h * 0.025,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 1),
                            color: Colors.white,
                          ),
                          child: completedSelected
                              ? Icon(Icons.check,
                              size: h * 0.018, color: Colors.black)
                              : null,
                        ),
                        SizedBox(width: w * 0.03),
                        Text(
                          'Completed',
                          style: TextStyle(
                            color: const Color(0xFF666666),
                            fontSize: h * 0.0175,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 0.03),

              /// ✅ APPLY BUTTON
              InkWell(
                onTap: ()
                {
                  context.pop();
                },
                child: Container(
                  width: double.infinity,
                  height: h * 0.06,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEBE01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(h * 0.03),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: h * 0.02,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget premiumPlanCircle(double h, double w) {
    return Center(
      child: Container(
        width: h * 0.25,
        // 200
        height: h * 0.25,
        padding: EdgeInsets.all(h * 0.01),
        decoration: ShapeDecoration(
          color: const Color(0xFF01EDFE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(h * 0.125),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          'Premium Plan',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: h * 0.025,
            // 20
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.32,
          ),
        ),
      ),
    );
  }

  Widget clientTopInfo(double h, double w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Satya Narayana Murthy ',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: h * 0.02,
                // 16
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.26,
              ),
            ),
            SizedBox(height: h * 0.0075),
            Text(
              '9191949191',
              style: TextStyle(
                color: Color(0xFFD4D4D4),
                fontSize: h * 0.02,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.26,
              ),
            ),
            SizedBox(height: h * 0.0075),
            Text(
              'Joined on 25 jul 25',
              style: TextStyle(
                color: Color(0xFFDDDDDD),
                fontSize: h * 0.0175,
                // 14
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.22,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Container(
              width: h * 0.05,
              height: h * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h * 0.04),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/call_icon.svg",
                width: h * 0.022,
                height: h * 0.022,
              ),
            ),
            SizedBox(width: w * 0.06),
            Container(
              width: h * 0.05,
              height: h * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h * 0.04),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/whatsapp_icon.svg",
                width: h * 0.022,
                height: h * 0.022,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget clientTopInfoShimmer(var h,var w)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerText(113, 11, context),

            SizedBox(height: h * 0.0075),
            shimmerText(60, 8, context),
            SizedBox(height: h * 0.0075),
            shimmerText(70, 8, context),
          ],
        ),

        Row(
          children: [
            Container(
              width: h * 0.05,
              height: h * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h * 0.04),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/call_icon.svg",
                width: h * 0.022,
                height: h * 0.022,
              ),
            ),
            SizedBox(width: w * 0.06),
            Container(
              width: h * 0.05,
              height: h * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h * 0.04),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/whatsapp_icon.svg",
                width: h * 0.022,
                height: h * 0.022,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget eventsHeader(double h, double w,var context) {
    return Row(
      children: [
        Text(
          'List of Events',
          style: TextStyle(
            color: primarycolor,
            fontSize: h * 0.02,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.26,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: ()
          {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => filterBottomSheet(w,h),
            );

          },
          child: Container(
            width: h * 0.04,
            height: h * 0.04,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF403103)),
                borderRadius: BorderRadius.circular(h * 0.02),
              ),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/filters_icon.svg",
              width: h * 0.02,
              height: h * 0.02,
            ),
          ),
        ),
      ],
    );
  }

  Widget eventCards(double h, double w) {
    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (context, _) => SizedBox(height: h * 0.015),
      itemBuilder: (context, index) {
        final event = events[index];
        return //eventCardShimmer(h, w);
         eventCard(
          h,
          w,
          title: event["title"]!,
          status: event["status"]!,
          icon: event["icon"]!,
        );
      },
    );
  }


  Widget eventCardShimmer(var h , var w)
  {


    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.03),
      decoration: ShapeDecoration(
        color: Color(0xFF222222),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(h * 0.005),
        ),
      ),
      child: Row(
        children: [
          shimmerContainer(h * 0.04, h *0.04, context),
          SizedBox(width: w * 0.03),

          shimmerText(70, 8, context),
          Spacer(),
          shimmerContainer(75, 20, context)
        ],
      ),
    );
  }
  Widget eventCard(double h,
      double w, {
        required String title,
        required String status,
        required String icon,
      })
  {
    final bool isPending = status.toLowerCase() == "pending";

    return InkWell(
      onTap: ()
      {
         context.push('/upload-pictures');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(w * 0.03),
        decoration: ShapeDecoration(
          color: Color(0xFF222222),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(h * 0.005),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: h * 0.04,
              height: h * 0.04,
              child: icon.toLowerCase().endsWith(".svg")
                  ? SvgPicture.asset(icon)
                  : Image.asset(icon),
            ),
            SizedBox(width: w * 0.02),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFD2D2D2),
                fontSize: h * 0.018,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.03,
                vertical: h * 0.008,
              ),
              decoration: ShapeDecoration(
                color: isPending ? Color(0xFFFF8383) : Color(0xFF7CFF83),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(h * 0.02),
                ),
              ),
              child: Text(
                isPending ? "Pending" : "Sent",
                style: TextStyle(
                  color: isPending ? Color(0xFF570505) : Color(0xFF054E05),
                  fontSize: h * 0.016,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

