import 'package:faculty/Util/FontStyle/RobotoRegularFont.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final Color color;
  final String title;
  final Color iconColor;
  final IconData iconData;
  final IconData trailingIcon;
  final void Function() onTap;
  const ProfileWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.iconColor,
    required this.color,
    this.trailingIcon = Icons.arrow_forward_ios,
    required this.iconData
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                children: [
                  Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
              ),
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  color: iconColor,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RobotoRegularFont(text: title),
            ),
                ],
              ),
            ),
            Icon(trailingIcon)
          ],
        ),
      ),
    );
  }
}