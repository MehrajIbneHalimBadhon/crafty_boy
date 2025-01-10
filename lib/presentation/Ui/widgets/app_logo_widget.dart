
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_path.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.appLogo,
      width: 150,
    );
  }
}
