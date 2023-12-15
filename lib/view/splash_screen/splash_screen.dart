import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/view/auth_screen/login_screen.dart';
import 'package:edraak/view/auth_screen/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          SizeBoxService.sH20,
          CommonButton().bSquareRoundBorderPrimaryBlueButton(
            context,
            title: 'Log In',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogInScreen(),
                ),
              );
            },
          ),
          SizeBoxService.sH20,
          CommonButton().bSquareRoundBorderPrimaryBlueButton(
            context,
            title: 'Sign Up',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
