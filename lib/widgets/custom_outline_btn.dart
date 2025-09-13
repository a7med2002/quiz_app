import 'package:flutter/material.dart';
import 'package:quiz_app/helper/color_helper.dart';

class CustomOutlineBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? ontap;
  final Color iconColor;
  const CustomOutlineBtn({
    super.key,
    required this.icon,
    required this.size,
    this.ontap,
    this.iconColor = kBlueIcon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Icon(icon, size: size, color: iconColor),
      onPressed: ontap,
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        foregroundColor: iconColor,
        side: BorderSide(color: kGreyFont),
      ),
    );
  }
}
