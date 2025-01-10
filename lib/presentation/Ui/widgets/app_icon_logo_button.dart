import 'package:flutter/material.dart';

class AppIconLogoButton extends StatelessWidget {
  const AppIconLogoButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.shade200,
        child: Icon(
          iconData,
          size: 18,
          color: Colors.grey,
        ),
      ),
    );
  }
}
