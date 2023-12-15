import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edraak/pref_manager/pref_manager.dart';
import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/common_snackbar_widget.dart';
import 'package:edraak/utils/notification_service.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/utils/text_field_widget.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:edraak/view/auth_screen/login_screen.dart';
import 'package:edraak/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    authViewModel.sNameController.text = '';
    authViewModel.sCityController.text = '';
    authViewModel.sEmailController.text = '';
    authViewModel.sMobileController.text = '';
    authViewModel.sPasswordController.text = '';
    authViewModel.sConfirmPasswordController.text = '';
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

                      ///Name

                      // region Name

                      commonTextField(
                        controller: controller.sNameController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.person,
                        labelText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                      ),

                      //endregion

                      SizeBoxService.sH20,

                      ///CITY

                      // region CITY

                      commonTextField(
                        controller: controller.sCityController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.add_location,
                        labelText: 'City',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the city';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      //endregion
                      SizeBoxService.sH20,

                      ///EMAIL

                      // region EMAIL

                      commonTextField(
                        controller: controller.sEmailController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.email,
                        labelText: 'Email Address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          } else if (!value.contains('@')) {
                            return 'Please enter the valid email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      //endregion
                      SizeBoxService.sH20,

                      ///Mobile

                      // region Mobile

                      commonTextField(
                        controller: controller.sMobileController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.phone,
                        labelText: 'Mobile Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the mobile number';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        textInputType: TextInputType.number,
                        textInputFormatter: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      //endregion
                      SizeBoxService.sH20,

                      ///PASSWORD

                      // region PASSWORD

                      commonTextField(
                        controller: controller.sPasswordController,
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
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      //endregion
                      SizeBoxService.sH20,

                      ///CONFIRM PASSWORD

                      // region CONFIRM PASSWORD

                      commonTextField(
                        controller: controller.sConfirmPasswordController,
                        prefixIconVisibility: true,
                        prefixIcon: Icons.key,
                        suffixIconVisibility: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.setConfirmPasswordVisible();
                          },
                          icon: Icon(
                            controller.confirmPasswordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        obscureText: controller.confirmPasswordHide,
                        labelText: 'Confirm Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          } else if (value.length < 6) {
                            return 'Please Enter a Valid Password. Min 6 Character';
                          } else if (value !=
                              controller.sPasswordController.text) {
                            return 'Please enter valid password';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      //endregion

                      SizeBoxService.sH20,

                      controller.isLoader
                          ? const CircularProgressIndicator()
                          : CommonButton().bRoundBorderPrimaryBlueButton(
                              context,
                              title: 'Sign Up',
                              onTap: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                try {
                                  controller.setLoaderStart();

                                  UserCredential credential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                    email: controller.sEmailController.text,
                                    password:
                                        controller.sPasswordController.text,
                                  );

                                  if (!mounted) {
                                    return;
                                  }
                                  String fcm =
                                      await NotificationService.getFCMToken();

                                  Map<String, dynamic> data = {
                                    'name': controller.sNameController.text,
                                    'city': controller.sCityController.text,
                                    'email': controller.sEmailController.text,
                                    'mobile': controller.sMobileController.text,
                                    'password':
                                        controller.sPasswordController.text,
                                    'uid': credential.user?.uid,
                                    'fcmToken': fcm
                                  };

                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(credential.user?.uid)
                                      .set(data);

                                  if (!mounted) {
                                    return;
                                  }

                                  PreferenceManager.setUID(
                                      "${credential.user?.uid}");
                                  PreferenceManager.setUserName(
                                      controller.sNameController.text);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LogInScreen(),
                                    ),
                                  );
                                  controller.setLoaderEnd();
                                } on FirebaseAuthException catch (e) {
                                  controller.setLoaderEnd();

                                  CommonSnackBarWidget.commonSnackBar(
                                      "${e.code}");

                                  print('eee--->${e.code}');
                                  print('eee-stackTrace-->${e.stackTrace}');
                                } catch (e) {
                                  controller.setLoaderEnd();
                                  print('error---$e');

                                  CommonSnackBarWidget.commonSnackBar('$e');
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const LogInScreen(),
                                //   ),
                                // );
                              },
                            ),

                      SizeBoxService.sH20,

                      RichText(
                        text: TextSpan(
                          text: 'Already a member? ',
                          style: TextStyleHelper.kBlackW600,
                          children: [
                            TextSpan(
                              text: 'Log In',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LogInScreen(),
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
