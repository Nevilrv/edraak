import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edraak/main.dart';
import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:edraak/view/diseases_screen/list_of_diseases_screen.dart';
import 'package:edraak/view/notification_screen/notification_screen.dart';
import 'package:edraak/view/predication_screen/predication_screen.dart';
import 'package:edraak/view/user_info_screen/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../pref_manager/pref_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// auto send notification
  // List<String> notificationTitleList = [
  //   'Influenza',
  //   'Dengue',
  //   'Bird Flu',
  //   'Pneumonia',
  // ];
  // Random random = Random();
  // setNotification() {
  //   int randomNumber = random.nextInt(notificationTitleList.length);
  //
  //   if (randomNumber == notificationTitleList.length) {
  //     randomNumber = 0;
  //   }
  //
  //   print('==randomNumber===>${randomNumber}');
  //   Future.delayed(
  //     const Duration(minutes: 2),
  //     () async {
  //       print('=======DURATION=====');
  //       const AndroidNotificationDetails androidNotificationDetails =
  //           AndroidNotificationDetails(
  //         'repeating channel id',
  //         'repeating channel name',
  //         icon: '@mipmap/ic_launcher',
  //         priority: Priority.high,
  //         importance: Importance.max,
  //         enableVibration: true,
  //         channelDescription: 'repeating description',
  //       );
  //       const NotificationDetails notificationDetails =
  //           NotificationDetails(android: androidNotificationDetails);
  //       await flutterLocalNotificationsPlugin.show(
  //         0,
  //         "ALERT",
  //         'Incoming Disease Spread. A new outbreak of ${notificationTitleList[randomNumber]} disease is expected next week. Please take necessary precautions to stay safe.',
  //         notificationDetails,
  //       );
  //       Map<String, dynamic> data = {
  //         'name': notificationTitleList[randomNumber],
  //         'description':
  //             'Incoming Disease Spread. A new outbreak of ${notificationTitleList[randomNumber]} disease is expected next week. Please take necessary precautions to stay safe.',
  //         'dateTime': DateTime.now(),
  //       };
  //       await FirebaseFirestore.instance.collection('notification').add(data);
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // setNotification();
  }

  var userName;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notification_important,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: h - 90,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hello ${PreferenceManager.getUserName() ?? "User"}!",
                          style: TextStyleHelper.kBlue90025W500,
                        ),
                      ),
                    ),
                    const Spacer(),

                    /// Select Predication
                    CommonButton().bSquareRoundBorderPrimaryBlueButton(
                      height: 80,
                      context,
                      title: 'Disease Forecast',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PredicationScreen(),
                          ),
                        );
                      },
                    ),
                    SizeBoxService.sH30,

                    ///List of Diseases

                    CommonButton().bSquareRoundBorderPrimaryBlueButton(
                      height: 80,
                      context,
                      title: 'List of Diseases',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListOfDiseasesScreen(),
                          ),
                        );
                      },
                    ),

                    SizeBoxService.sH30,

                    ///User Info

                    CommonButton().bSquareRoundBorderPrimaryBlueButton(
                      height: 80,
                      context,
                      title: 'User Information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserInfoScreen(),
                          ),
                        );
                      },
                    ),

                    SizeBoxService.sH20,
                    const Spacer(),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      height: h * 0.09,
                      child: Image.asset("assets/images/Screenshot.png"))),
            ],
          ),
        ),
      ),
    );
  }
}
