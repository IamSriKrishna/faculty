// ignore_for_file: prefer_const_constructors

import 'package:faculty/Feature/Service/UpdateFcmToken.dart';
import 'package:faculty/Util/FontStyle/RobotoRegularFont.dart';
import 'package:faculty/Widget/Additional/CustomHiddenbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
 String? fcmToken = '';

  final UpdateFCMToken _updateFCMToken = UpdateFCMToken();
  void Update(){
    _updateFCMToken.fcmUpdate(
      context: context, fcmtoken: fcmToken!);
  }
  void _initializePreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    fcmToken = pref.getString('fcmToken');
    print(fcmToken);
  }
  @override
  void initState() {
    super.initState();
    _initializePreferences();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(milliseconds: 2950),(){
      Navigator.pushReplacementNamed(context, HiddenDrawer.route);
    }).then((value) => Update());
  }
  @override

  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.0),
            child: Image.asset('asset/Logo/kcg.png',height: MediaQuery.of(context).size.height * 0.3)),
          Align(
            alignment: Alignment(0, 0.6),
            child: Lottie.asset('asset/lottie/load.json',height: 150,)),
          Align(
            alignment: Alignment(0, 0.95),
            child: RobotoRegularFont(text: 'Developed By Sri Krishna & Krithick',size: 9,)),
        ],
      ),
    );
  }
}