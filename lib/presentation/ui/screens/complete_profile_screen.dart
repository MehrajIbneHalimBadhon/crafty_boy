import 'package:crafty_boy_ecommerce_app/data/models/complete_profile_model.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/snack_message.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/app_logo_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _stateTEController = TextEditingController();
  final TextEditingController _postCodeTEController = TextEditingController();
  final TextEditingController _countryTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const AppLogoWidget(),
              const SizedBox(height: 24),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Get started with us by providing your information',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'First name'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Last name'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _mobileTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cityTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'City'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _stateTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'State/Division'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _postCodeTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Post Code'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _countryTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Country'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressTEController,
                      maxLines: 4,
                      decoration: const InputDecoration(hintText: 'Shipping Address'),
                      validator: (String? value) {
                        return value!.trim().isEmpty ? ' Please enter valid information' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<CompleteProfileController>(
                        builder: (createProfileController) {
                          return Visibility(
                            visible: !createProfileController.inProgress,
                            replacement: const CenteredCircularProgressIndicator(),
                            child: ElevatedButton(
                              onPressed: _onTapCompleteButton,
                              child: const Text('Complete'),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCompleteButton() async {
    if (_formKey.currentState!.validate()) {
      final fullName =
          "${_firstNameTEController.text.trim()} ${_lastNameTEController.text.trim()}";
      final CompleteProfileModel requestData = CompleteProfileModel(
        cusName: fullName,
        cusAdd: _addressTEController.text.trim(),
        cusCity: _cityTEController.text.trim(),
        cusState: _stateTEController.text.trim(),
        cusPostcode: _postCodeTEController.text.trim(),
        cusCountry: _countryTEController.text.trim(),
        cusPhone: _mobileTEController.text.trim(),
        cusFax: _mobileTEController.text.trim(),
        shipName: fullName,
        shipAdd: _addressTEController.text.trim(),
        shipCity: _cityTEController.text.trim(),
        shipState: _stateTEController.text.trim(),
        shipPostcode: _postCodeTEController.text.trim(),
        shipCountry: _countryTEController.text.trim(),
        shipPhone: _mobileTEController.text.trim(),
      );

      bool result = await Get.find<CompleteProfileController>()
          .competeProfile(profileData: requestData);
      if (result) {
        showSnackBarMessage(context, 'Profile created successfully!');
        Get.offAll(const MainBottomNavScreen());
      } else {
        showSnackBarMessage(context, 'Something went wrong! Please try again.', true);
      }
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _stateTEController.dispose();
    _postCodeTEController.dispose();
    _countryTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}
