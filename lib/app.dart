import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/splash_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/Ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_binder.dart';

class CraftyBoy extends StatelessWidget {
  const CraftyBoy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.themeColor,
        ),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
            color: Colors.black, // Set the back button color to black
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
            errorBorder: _outlineInputBorder(Colors.red),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            hintStyle: const TextStyle(fontWeight: FontWeight.w400)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: const TextStyle(fontSize: 16),
              fixedSize: const Size.fromWidth(double.maxFinite)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.themeColor,
              textStyle: const TextStyle(fontSize: 16),
            )),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? AppColors.themeColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
