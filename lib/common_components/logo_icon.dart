import 'package:flutter/material.dart';

class SocialMediaCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color borderColor;
  final Color backgroundColor;

  const SocialMediaCard({
    Key? key,
    required this.icon,
    this.iconColor,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
