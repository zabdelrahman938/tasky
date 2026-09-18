import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app_last_thing/themes/theme_controller.dart';

class CustomSvgPictureWidget extends StatelessWidget {
  const CustomSvgPictureWidget({super.key, required this.path, required this.withColorFilter, this.width, this.height});
final String path;
final bool withColorFilter;
final double? width;
final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
     path,
        width: width,
        height: height,
        colorFilter:withColorFilter? ColorFilter.mode(
            ThemeController.themeNotifier.value==ThemeMode.dark?
            Color(0xffFFFCFC):Color(0xff161F1B),
            BlendMode.srcIn
        ):null
    );
  }
}
