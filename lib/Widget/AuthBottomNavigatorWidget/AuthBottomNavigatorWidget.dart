import 'package:faculty/Util/FontStyle/RobotoBoldFont.dart';
import 'package:faculty/Util/FontStyle/RobotoRegularFont.dart';
import 'package:flutter/material.dart';

class AuthBottomNavigatorWidget extends StatelessWidget {
  final String prefixText;
  final String sufixText;
  final void Function() onTap;
  const AuthBottomNavigatorWidget({
    super.key,
    required this.prefixText,
    required this.sufixText,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RobotoRegularFont(text: prefixText,textColor: Colors.black,),
          GestureDetector(
            onTap: onTap,
            child: RobotoBoldFont(text: sufixText,textColor: Colors.black,)),
        ],
      ),
    );
  }
}