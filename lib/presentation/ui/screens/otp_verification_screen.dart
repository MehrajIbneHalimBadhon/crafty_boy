import 'dart:async';

import 'package:crafty_boy_ecommerce_app/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/app_colors.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/snack_message.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/app_logo_widget.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final OTPVerificationController _otpTEVeryficationController =
      Get.find<OTPVerificationController>();
  final ReadProfileController _readProfileController = Get.find<ReadProfileController>();

  Timer? _timer;
  int _start = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();
    _start = 60; // Reset the timer to 120 seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer?.cancel(); // Stop the timer when it reaches 0
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 82,
              ),
              const AppLogoWidget(),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Enter OTP Code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'A 4 digit OTP has been sent to email',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                length: 6,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.green,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.themeColor),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _otpTEController,
                appContext: context,
              ),
              const SizedBox(
                height: 24,
              ),
              GetBuilder<OTPVerificationController>(
                  builder: (otpVerificationController) {
                return Visibility(
                  visible: !otpVerificationController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapNextScreen,
                    child: const Text('Next'),
                  ),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                  text: 'This code will expire in ',
                  children: [
                    TextSpan(
                      text: '$_start' 's',
                      style: const TextStyle(color: AppColors.themeColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  startTimer();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OTP code sent again'),
                      duration: Duration(seconds: 2), // Duration of snackbar
                    ),
                  );
                },
                child: const Text(
                  'Resend OTP',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextScreen() async {
    bool result = await _otpTEVeryficationController.verifyOTP(
        widget.email, _otpTEController.text);


    if (result) {

      final bool readProfileResult = await _readProfileController
          .getProfileDetails(_otpTEVeryficationController.accessToken);

      if (readProfileResult) {

        if (_readProfileController.isProfileCompleted)
        {
          Get.offAll(() => const MainBottomNavScreen());
        }

        else {
          Get.to(() => const CompleteProfileScreen());
        }

      }
    }

    else {

      if (mounted) {

        showSnackBarMessage(
            context, _otpTEVeryficationController.errorMessage!);
      }
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    _timer
        ?.cancel(); // Ensure the timer is canceled when the widget is disposed
    super.dispose();
  }
}
