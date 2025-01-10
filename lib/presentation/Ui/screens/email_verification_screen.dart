
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/verify_email_controller.dart';
import '../utils/tost_message.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/loding_indicator.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final VerifyEmailController verifyEmailController =
      Get.find<VerifyEmailController>();
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              'Welcome back',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Please enter your email address',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: TextFormField(
                controller: _emailTEController,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter an email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: !verifyEmailController.inProgress,
              replacement: const LoadingIndicator(),
              child: ElevatedButton(
                onPressed: _onTapNextButton,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await verifyEmailController.verifyUserEmail(
        email: _emailTEController.text.trim());
    if (result) {
      Get.to(() => OtpVerificationScreen(
            email: _emailTEController.text.trim(),
          ));
    } else {
      if (mounted) {
        toastMessage(context, verifyEmailController.errorMessage!, false);
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
