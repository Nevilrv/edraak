import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edraak/model/diseases_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DiseasesViewModel extends GetxController {
  List<DiseasesModel> diseasesList = [];

  bool isLoader = true;

  Future<void> getDiseasesData() async {
    isLoader = true;
    update();

    diseasesList.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('diseases').get();

      for (var element in data.docs) {
        DiseasesModel model = DiseasesModel();
        model.name = element.data()['name'];
        model.description = element.data()['description'];
        model.symptoms = element.data()['symptoms'];
        model.prevention = element.data()['prevention'];

        diseasesList.add(model);
        print('====DATA====>${element.data()}');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'ERROR: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 12.0);
      print('===e=====>$e');
    }
    isLoader = false;

    update();
  }
}
