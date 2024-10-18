import 'package:crafty_boy_ecommerce_app/controller_binder.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/splash_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBoy extends StatefulWidget {
  const CraftyBoy({super.key});

  @override
  State<CraftyBoy> createState() => _CraftyBoyState();
}

class _CraftyBoyState extends State<CraftyBoy> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorSchemeSeed: AppColors.themeColor,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.themeColor),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
            errorBorder: _outlineInputBorder(Colors.red),
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontSize: 16),
              fixedSize: const Size.fromWidth(double.maxFinite)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppColors.themeColor,
              textStyle: const TextStyle(fontSize: 16)),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 20,
            fontWeight: FontWeight.w500
          )
        )
      ),

    );
  }

  OutlineInputBorder _outlineInputBorder([Color? color]) {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: color ?? AppColors.themeColor, width: 1.4),
        borderRadius: BorderRadius.circular(8));
  }
}
