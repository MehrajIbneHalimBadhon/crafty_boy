import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _fistNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const AppLogoWidget(),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Get started with us by providing your information',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _fistNameTEController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _lastNameTEController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _mobileTEController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Mobile'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _cityTEController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'City'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: 4,
                controller: _shippingAddressTEController,
                decoration: const InputDecoration(hintText: 'Shipping Address'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _onTapCompleteButton,
                child: const Text('Complete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapCompleteButton() {
    // Get.to(() => const HomeScreen());
  }

  @override
  void dispose() {
    _fistNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
