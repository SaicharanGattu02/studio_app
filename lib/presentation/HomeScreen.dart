import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/Components/Shimmers.dart';
import 'package:studio_app/presentation/ScreenWidgets/EventCard.dart';
import 'package:studio_app/utils/color_constants.dart';
import 'package:studio_app/utils/media_query_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  // ✅ Sample banner data list
  final List<Map<String, String>> bannerData = [
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=60",
      "linkUrl": "https://unsplash.com",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=800&q=60",
      "linkUrl": "https://flutter.dev",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?auto=format&fit=crop&w=800&q=60",
      "linkUrl": "https://google.com",
    },
  ];

  final List<Map<String, String>> events = [
    {
      'title': 'Shiva & Deepthi',
      'type': 'Wedding Event',
      'date': '24 Jul 25',
      'status': 'Pending',
      'image': 'assets/images/Photoroom.png',
    },
    {
      'title': 'Rahul & Kavya',
      'type': 'Engagement Event',
      'date': '10 May 25',
      'status': 'Confirmed',
      'image': 'assets/images/Photoroom.png',
    },
    {
      'title': 'Rohit & Meera',
      'type': 'Reception Event',
      'date': '28 Aug 25',
      'status': 'Completed',
      'image': 'assets/images/Photoroom.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        toolbarHeight: SizeConfig.screenHeight * 0.07,
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0, // optional (for proper alignment)
        title: Padding(
          padding: EdgeInsets.only(left: 16, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Image.asset(
                'assets/images/Studio.png',
                width: SizeConfig.screenWidth * 0.15,
                height: SizeConfig.screenHeight * 0.05,
                fit: BoxFit.contain,
              ),
              const Text(
                "Dphotowala Studio",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton.outlined(
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                side: WidgetStateProperty.all(
                  const BorderSide(color: Color(0xffB3B8C0), width: 1),
                ),
                shape: WidgetStateProperty.all(const CircleBorder()),
                padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
              ),
              onPressed: () {
                context.push('/notifications');
              },
              icon: const Icon(Icons.notifications, color: Color(0xffB3B8C0)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
           // shimmerContainer(double.infinity,SizeConfig.screenHeight * 0.23 , context),
            //const SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: SizeConfig.screenHeight * 0.25,
                autoPlay: true,
                viewportFraction: 1,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() => currentIndex = index);
                },
              ),
              items: bannerData.map((banner) {
                final imageUrl = banner["image"] ?? "";
                final linkUrl = banner["linkUrl"] ?? "";
                return InkWell(
                  onTap: () async {
                    if (linkUrl.isNotEmpty &&
                        await canLaunchUrl(Uri.parse(linkUrl))) {
                      await launchUrl(
                        Uri.parse(linkUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Could not launch link")),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: SizeConfig.screenWidth,
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // 🔹 Banner Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                bannerData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentIndex == index ? 22 : 10,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blueAccent
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Onboarded",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    side: WidgetStateProperty.all(
                      BorderSide(color: primarycolor, width: 1),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.push('/create_client');
                  },
                  child: Text(
                    "Create Client",
                    style: TextStyle(
                      color: primarycolor,
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Events List — Use Expanded + ListView.builder ✅
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child:
                  //    EventCardShimmer()
                  EventCard(
                      title: event['title']!,
                      type: event['type']!,
                      date: event['date']!,
                      status: event['status']!,
                      image: event['image']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget EventCardShimmer()
  {
    return Container(width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color:  Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT SIDE CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerText(120, 13, context),
                const SizedBox(height: 6),
                shimmerText(75, 8, context),
                const SizedBox(height: 6),
                Row(
                  children: [
                    shimmerContainer(30, 8, context),
                    const SizedBox(width: 4),
                    shimmerText(30, 8, context),

                  ],
                ),
                const SizedBox(height: 12),
                shimmerContainer(80, 10, context)
              ],
            ),
          ),

          // RIGHT SIDE IMAGE
          const SizedBox(width: 16),
          shimmerContainer(50, 50, context)
        ],
      ),
    );
  }

}
