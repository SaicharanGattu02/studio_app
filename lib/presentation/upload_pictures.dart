import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/media_query_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class UploadPictures extends StatelessWidget {
  const UploadPictures({super.key});

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    final coupleImages = [
      "assets/images/couple_1.png",
      "assets/images/couple_2.png",
      "assets/images/couple_3.png",
      "assets/images/couple_4.png",
    ];

    final repeatedImages =
    List.generate(3, (_) => coupleImages).expand((e) => e).toList();

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
          "Candid Pictures",
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.0225,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      /// ✅ Body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            SizedBox(height: h * 0.02),

            /// ✅ Staggered Grid
            Expanded(
              child: SingleChildScrollView(
                child: MasonryGridView.count(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: h * 0.015,
                  crossAxisSpacing: w * 0.03,
                  itemCount: repeatedImages.length,
                  itemBuilder: (context, index) {
                    final image = repeatedImages[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      /// ✅ Bottom Navigation
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: h * 0.01),
          child: Container(
            width: double.infinity,
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.04),

            child: InkWell(
              onTap: ()
              {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return ConfirmPopup(
                      onYes: () {
                       context.pop();
                       context.push(
                         '/success',
                         extra: "Assigned to Client",
                       );

                      },
                      onNo: () {
                        print("NO clicked");
                      },
                    );
                  },
                );

              },
              child: Container(
                height: h * 0.06,      // ✅ This works now
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEBE01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Assign to Client",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )

    );
  }


}
class ConfirmPopup extends StatelessWidget {
  final VoidCallback? onYes;
  final VoidCallback? onNo;

  const ConfirmPopup({
    super.key,
    this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: const ShapeDecoration(
        color: Color(0xFFF7F9FE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Title
          const Text(
            'Please Confirm',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.32,
            ),
          ),

          const SizedBox(height: 18),

          /// ✅ Buttons Row
          Row(
            children: [
              /// NO button
              Expanded(
                child: GestureDetector(
                  onTap: onNo ?? () => Navigator.pop(context),
                  child: Container(
                    height: 48,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE8E8E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 24),

              /// YES button
              Expanded(
                child: GestureDetector(
                  onTap: onYes ?? () => Navigator.pop(context),
                  child: Container(
                    height: 48,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFEBE01),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


