import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserModel {
  String? name;
  String? city;
  String? email;
  String? mobile;
  UserModel({this.name, this.city, this.email, this.mobile});
}

class UserInfoViewModel extends GetxController {
  UserModel userData = UserModel();

  bool isLoader = true;

  Future<void> getUserData() async {
    isLoader = true;
    update();
    userData = UserModel();
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData.email = data.data()?['email'];
      userData.city = data.data()?['city'];
      userData.name = data.data()?['name'];
      userData.mobile = data.data()?['mobile'];
    } catch (e) {
      print('===e=====>$e');
    }
    isLoader = false;

    update();
  }
}
