import 'package:faculty/Provider/DarkThemeProvider.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/FontStyle/RobotoBoldFont.dart';
import 'package:faculty/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopMainScreen extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;
  const TopMainScreen({super.key,required this.context});

  @override
  State<TopMainScreen> createState() => _TopMainScreenState();

  @override
  Size get preferredSize {
    double preferredHeight = MediaQuery.of(context).size.height * 0.102;
    return Size.fromHeight(preferredHeight);
  }
}

class _TopMainScreenState extends State<TopMainScreen> {
  String greeting = '';

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour >= 12 && hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<FacultyProvider>(context);
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.102,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RobotoBoldFont(
                text: greeting,
                size: 25,
                textColor: theme.getDarkTheme ? themeColor.backgroundColor : themeColor.darkTheme,
              ),
            ],
          ),
          RobotoBoldFont(
            text: "${student.user.name.toString().toUpperCase()}:)",
            size: 25,
            textColor: theme.getDarkTheme ? themeColor.appThemeColor : themeColor.appThemeColor2,
          ),
        ],
      ),
    );
  }
}
