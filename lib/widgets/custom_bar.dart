import 'package:flutter/material.dart';
import 'package:elearning/utilities/common_variables.dart';

class CustomBar extends StatelessWidget {
  const CustomBar(
    this.titleName,
    this.titleIcon, {
    this.onTap,
    this.onLongPressed,
    this.trailing,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    super.key,
  });

  final String titleName;
  final IconData titleIcon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: commonPadding,
      child: Card(
        color: backgroundColor,
        child: ListTile(
          minTileHeight: 60,
          leading: Icon(
            titleIcon,
            color: iconColor,
          ),
          title: Text(
            titleName,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
          trailing: trailing,
          onTap: onTap,
          onLongPress: onLongPressed,
        ),
      ),
    );
  }
}
