import 'package:edraak/pref_manager/pref_manager.dart';
import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/view/auth_screen/login_screen.dart';
import 'package:edraak/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfoViewModel userInfoViewModel = Get.put(UserInfoViewModel());

  @override
  void initState() {
    super.initState();
    userInfoViewModel.getUserData();
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
      body: GetBuilder<UserInfoViewModel>(
        builder: (controller) {
          return Column(
            children: [
              userInfoTile(controller,
                  title: 'Name', subtitle: controller.userData.name ?? ""),
              userInfoTile(controller,
                  title: 'City', subtitle: controller.userData.city ?? ""),
              userInfoTile(controller,
                  title: 'Email', subtitle: controller.userData.email ?? ""),
              userInfoTile(controller,
                  title: 'Mobile', subtitle: controller.userData.mobile ?? ""),
              SizeBoxService.sH50,
              CommonButton().bRoundBorderPrimaryBlueButton(
                context,
                title: 'Log out',
                onTap: () {
                  PreferenceManager.clearAll();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogInScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  ListTile userInfoTile(UserInfoViewModel controller,
      {String title = '', String subtitle = ''}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
      ),
    );
  }
}
