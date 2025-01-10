
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/logout_controller.dart';
import '../../state_holders/profile_details_controller.dart';
import '../utils/tost_message.dart';
import '../widgets/loding_indicator.dart';
import 'main_bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileDetailsController>().getUserProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<ProfileDetailsController>(
              builder: (profileDetailsController) {
            if (profileDetailsController.inProgress) {
              return const LoadingIndicator();
            }
            return Column(
              children: [
                _buildBasicInfoSection(profileDetailsController),
                const SizedBox(height: 30),
                _buildDetailInfoSection(profileDetailsController),
                const SizedBox(height: 30),
                GetBuilder<LogoutController>(builder: (logOutController) {
                  return Visibility(
                    visible: !logOutController.inProgress,
                    replacement: const LoadingIndicator(),
                    child: ElevatedButton(
                        onPressed: _onClickLogoutButton,
                        child: Text(
                          'Log-out',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )),
                  );
                })
              ],
            );
          }),
        ),
      ),
    );
  }

  Column _buildDetailInfoSection(
      ProfileDetailsController profileDetailsCntroller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Number : ${profileDetailsCntroller.profileData.profileData!.cusPhone}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'Address : ${profileDetailsCntroller.profileData.profileData!.cusAdd}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  SizedBox _buildBasicInfoSection(
      ProfileDetailsController profileDetailsCntroller) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(150),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 100,
            ),
          ),
          Text(
            '${profileDetailsCntroller.profileData.profileData!.cusName}',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          Text(
            '${profileDetailsCntroller.profileData.profileData!.user!.email}',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  Future<void> _onClickLogoutButton() async {
    bool isLogoutSuccess = await Get.find<LogoutController>().logout();
    if (isLogoutSuccess) {
      toastMessage(context, "Logout Successfull");
      Get.offAll(() => const MainBottomNavBar());
    } else {
      toastMessage(context, Get.find<LogoutController>().errorMessage!, true);
    }
  }
}
