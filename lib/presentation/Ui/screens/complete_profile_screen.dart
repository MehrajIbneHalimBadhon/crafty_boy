
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/create_profile_model.dart';
import '../../state_holders/create_profile_controller.dart';
import '../utils/tost_message.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/loding_indicator.dart';
import 'main_bottom_nav_bar.dart';

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
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameTEController,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'First name'),
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _lastNameTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Last name'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _mobileTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Mobile'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _cityTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'City'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _stateTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'State/Division'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _postCodeTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Post Code'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _countryTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Country'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _addressTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return ' Please enter valid information';
                            }
                            return null;
                          },
                          maxLines: 4,
                          decoration: const InputDecoration(
                              hintText: 'Shipping Address'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<CreateProfileController>(
                      builder: (createProfileController) {
                    return Visibility(
                      visible: !createProfileController.inProgress,
                      replacement: const LoadingIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapCompleteButton,
                        child: const Text('Complete'),
                      ),
                    );
                  }),
                ],
              )
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
      final CreateProfileModel requestData = CreateProfileModel(
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

      bool result = await Get.find<CreateProfileController>()
          .competeProfile(profileData: requestData);
      if (result) {
        toastMessage(context, 'Profile created successfully!');
        Get.offAll(const MainBottomNavBar());
      } else {
        toastMessage(context, 'Something went wrong! Please try again.', true);
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
