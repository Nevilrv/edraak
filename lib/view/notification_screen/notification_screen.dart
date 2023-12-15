import 'package:edraak/utils/color_picker.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:edraak/view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationViewModel notificationViewModel =
      Get.put(NotificationViewModel());

  @override
  void initState() {
    super.initState();
    notificationViewModel.getNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationViewModel>(
        builder: (controller) {
          if (controller.isLoader) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notificationList.isEmpty) {
            return Center(
                child: Text('No Data Found', style: TextStyleHelper.kGreyW600));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notificationList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    left: 20, right: 20, top: index == 0 ? 10 : 0, bottom: 10),
                decoration: BoxDecoration(
                  color: ColorPicker.kGrey200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    controller.notificationList[index].name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    controller.notificationList[index].description ?? "",
                  ),
                  trailing: Text(
                    controller.timeAgo(
                      controller.notificationList[index].dateTime ??
                          DateTime.now(),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorPicker.kGrey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
