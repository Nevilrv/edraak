import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  bool isLoader = false;

  setLoaderStart() {
    isLoader = true;
    update();
  }

  setLoaderEnd() {
    isLoader = false;
    update();
  }

  bool passwordHide = true;
  bool confirmPasswordHide = true;

  setPasswordVisible() {
    passwordHide = !passwordHide;
    update();
  }

  setConfirmPasswordVisible() {
    confirmPasswordHide = !confirmPasswordHide;
    update();
  }

  ///LOGIN CONTROLLER
  TextEditingController lEmailController = TextEditingController();
  TextEditingController lPasswordController = TextEditingController();

  ///SIGN UP CONTROLLER
  TextEditingController sNameController = TextEditingController();
  TextEditingController sCityController = TextEditingController();
  TextEditingController sEmailController = TextEditingController();
  TextEditingController sMobileController = TextEditingController();
  TextEditingController sPasswordController = TextEditingController();
  TextEditingController sConfirmPasswordController = TextEditingController();
}
