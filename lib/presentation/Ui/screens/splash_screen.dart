
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/auth_controller.dart';
import '../widgets/app_logo_widget.dart';
import 'main_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _moveToNextScreen() async {
    await Get.find<AuthController>().getAccessToken();
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const MainBottomNavBar());
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'version 1.0.0',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
