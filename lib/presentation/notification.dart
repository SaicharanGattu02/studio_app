import 'package:flutter/material.dart';
import 'package:studio_app/Components/CutomAppBar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Sample notification data
  final List<Map<String, dynamic>> notifications = [
    {
      "date": "12 Jun 25",
      "icon": Icons.person,
      "message": "Shiva Client is Onboarded.",
    },
    {
      "date": "13 Jun 25",
      "icon": Icons.upload,
      "message": "Shiva Wedding footage is Uploaded.",
    },
    {
      "date": "13 Jun 25",
      "icon": Icons.star,
      "message": "Shiva bought the premium plan.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: '', actions: const []),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Notification Heading (below app bar, slightly right)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "Notification",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ✅ Notification list
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  final showDate = index == 0 ||
                      notifications[index - 1]['date'] != item['date'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDate) ...[
                        const SizedBox(height: 10),
                        Text(
                          item['date'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff2C2C2C),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffCB9801),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                item['icon'],
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item['message'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
