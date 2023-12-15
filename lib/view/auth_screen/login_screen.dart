import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edraak/pref_manager/pref_manager.dart';
import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/common_snackbar_widget.dart';
import 'package:edraak/utils/notification_service.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/utils/text_field_widget.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:edraak/view/auth_screen/signup_screen.dart';
import 'package:edraak/view/home_screen/home_screen.dart';
import 'package:edraak/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    authViewModel.lEmailController.text = '';
    authViewModel.lPasswordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: GetBuilder<AuthViewModel>(
              builder: (controller) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                      ),
                      SizeBoxService.sH20,

                      // region emailField

                      commonTextField(
                        controller: controller.lEmailController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.email,
                        labelText: 'Email Address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter Your valid email';
                          } else {
                            return null;
                          }
                        },
                      ),

                      //endregion

                      SizeBoxService.sH20,

                      // region password
                      commonTextField(
                        controller: controller.lPasswordController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.key,
                        suffixIconVisibility: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.setPasswordVisible();
                          },
                          icon: Icon(
                            controller.passwordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        obscureText: controller.passwordHide,
                        labelText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Please Enter a Valid Password. Min 6 Character';
                          } else {
                            return null;
                          }
                        },
                      ),
                      //endregion

                      SizeBoxService.sH20,
                      controller.isLoader
                          ? const CircularProgressIndicator()
                          : CommonButton().bRoundBorderPrimaryBlueButton(
                              context,
                              title: 'Log In',
                              onTap: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                try {
                                  controller.setLoaderStart();
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                    email: controller.lEmailController.text,
                                    password:
                                        controller.lPasswordController.text,
                                  );

                                  if (!mounted) {
                                    return;
                                  }

                                  PreferenceManager.setEmailId(
                                      controller.lEmailController.text);

                                  PreferenceManager.setIsLogin(true);
                                  String fcm =
                                      await NotificationService.getFCMToken();
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc("${userCredential.user!.uid}")
                                      .update({
                                    "fcmToken": fcm,
                                    'uid': userCredential.user?.uid,
                                  });

                                  DocumentSnapshot<Map<String, dynamic>> data =
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(userCredential.user!.uid)
                                          .get();

                                  PreferenceManager.setUserName(
                                      "${data.data()?['name']}");

                                  PreferenceManager.setUID(
                                      userCredential.user!.uid);

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false,
                                  );
                                  controller.setLoaderEnd();
                                } on FirebaseAuthException catch (e) {
                                  controller.setLoaderEnd();

                                  Fluttertoast.showToast(
                                      msg:
                                          "There is no user record corresponding to this identifier. The user may have been deleted.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 12);
                                } catch (e) {
                                  controller.setLoaderEnd();
                                  print('error---$e');
                                  CommonSnackBarWidget.commonSnackBar(
                                      "There is no user record corresponding to this identifier. The user may have been deleted.");
                                }
                              },
                            ),
                      SizeBoxService.sH20,
                      RichText(
                        text: TextSpan(
                          text: 'Not a member? ',
                          style: TextStyleHelper.kBlackW600,
                          children: [
                            TextSpan(
                              text: 'Sign up.',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    ),
                              style: TextStyleHelper.kPurpleW600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
