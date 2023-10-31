// ignore_for_file: prefer_const_constructors

import 'package:faculty/Constrains/ThemeStyle.dart';
import 'package:faculty/Feature/Screen/Auth/Login.dart';
import 'package:faculty/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:faculty/Feature/Service/AuthService.dart';
import 'package:faculty/Provider/DarkThemeProvider.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/LocalNotification.dart';
import 'package:faculty/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) =>  runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DarkThemeProvider(),
              child: MyApp(),
            ),
            ChangeNotifierProvider(
              create: (context) => FacultyProvider(),
            )
          ],child: MyApp(), 
        )
    
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
  builder: (context, darkThemeProvider, child) {
        return GetMaterialApp(
          theme:  Styles().themeData(darkThemeProvider.getDarkTheme, context),
          debugShowCheckedModeBanner: false,
          home:FutureBuilder(
      future: authService.getUserData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final student = Provider.of<FacultyProvider>(context).user;
          if (student.token.isNotEmpty) {
            return OverScreen();
          } else {
            return Login();
          }
        }
      },
    ),
          onGenerateRoute: (settings) => onGenerator(settings),
        );
      },
    );
  }
}
