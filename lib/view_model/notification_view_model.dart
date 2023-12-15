import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edraak/model/notification_model.dart';
import 'package:edraak/pref_manager/pref_manager.dart';
import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  List<NotificationModel> notificationList = [];

  bool isLoader = true;

  Future<void> getNotificationData() async {
    isLoader = true;
    update();

    if (notificationList.isNotEmpty) {
      notificationList.clear();
    }

    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('notification')
          .orderBy("dateTime", descending: true)
          .get();

      for (var element in data.docs) {
        if (element
            .data()["userList"]
            .contains("${PreferenceManager.getUID()}")) {
          NotificationModel model = NotificationModel();
          model.name = element.data()['name'];
          model.description = element.data()['description'];
          model.dateTime = element.data()['dateTime'].toDate();
          notificationList.add(model);
        }
      }
    } catch (e) {
      print('===e=====>$e');
    }
    isLoader = false;

    update();
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"}\nago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"}\nago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"}\nago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"}\nago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"}\nago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"}\nago";
    }
    return "just now";
  }
}
