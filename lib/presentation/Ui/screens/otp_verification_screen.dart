
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../state_holders/otp_verification_controller.dart';
import '../../state_holders/read_profile_controller.dart';
import '../utils/app_colors.dart';
import '../utils/tost_message.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/loding_indicator.dart';
import 'complete_profile_screen.dart';
import 'main_bottom_nav_bar.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();
  final ReadProfileController _readProfileController =
      Get.find<ReadProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 82),
              const AppLogoWidget(),
              const SizedBox(height: 24),
              Text(
                'Enter OTP Code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'A 4 digit OTP has been sent to email',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: PinCodeTextField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter 6 digit OTP send to your email';
                    }
                    return null;
                  },
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
                    inactiveColor: AppColors.themeColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _otpTEController,
                  appContext: context,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onTapNextButton,
                child: const Text('Next'),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                  text: 'This code will expire in ',
                  children: const [
                    TextSpan(
                      text: '120s',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: !_otpVerificationController.inProgress,
                  replacement: const LoadingIndicator(),
                  child: TextButton(
                      onPressed: _onTapNextButton,
                      child: const Text('Resend Code'))),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _otpVerificationController.verifyOTP(
        email: widget.email, otp: _otpTEController.text);
    if (result) {
      final bool readProfileResult = await _readProfileController
          .getProfileDetails(_otpVerificationController.accessToken);
      if (readProfileResult) {
        if (_readProfileController.isProfileCompleted) {
          Get.offAll(() => const MainBottomNavBar());
        } else {
          Get.off(() => const CompleteProfileScreen());
        }
      } else {
        if (mounted) {
          toastMessage(context, _readProfileController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        toastMessage(context, _otpVerificationController.errorMessage!, true);
      }
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
