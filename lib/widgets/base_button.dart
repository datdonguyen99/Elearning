import 'package:flutter/material.dart';
import 'package:elearning/style/app_colors.dart';
import 'package:elearning/style/app_sizes.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color,
    this.textStyle,
    this.width,
    this.height,
  });

  final String title;
  final VoidCallback onPress;
  final Color? color;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.cornflowerBlue,
          foregroundColor: textStyle?.color ?? AppColors.gold,
          textStyle: textStyle ?? const TextStyle(fontSize: AppSize.size20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
        ),
        onPressed: onPress,
        child: Text(title),
      ),
    );
  }
}
