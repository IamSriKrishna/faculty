// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:faculty/Constrains/ThemeStyle.dart';
import 'package:faculty/Feature/Screen/Auth/Login.dart';
import 'package:faculty/Feature/Service/AuthService.dart';
import 'package:faculty/Provider/DarkThemeProvider.dart';
import 'package:faculty/Provider/FOrmProvider.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/LocalNotification.dart';
import 'package:faculty/Widget/Additional/CustomHiddenbar.dart';
import 'package:faculty/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE', 
      appId: '1:879927221521:android:c46c67a6f1ea8b6eb1c0b0', 
      messagingSenderId: '879927221521', 
      projectId: 'campuslink-d1f2d'
    )
  ):Firebase.initializeApp(); 
  await LocalNotifications.init();
  FirebaseMessaging.instance.getToken().then((value)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('fcmToken', value!);
  print('main file la print agudhu:$value');
  });
  await SharedPreferences.getInstance();

  FirebaseMessaging.onBackgroundMessage((message) => 
    firebaseMessaginBackgroundHandler(message)
  );
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
            ),
            ChangeNotifierProvider(create:(context) => FormDataNotifier(),)
          ],child: MyApp(), 
        )
  ));
}

Future<void> firebaseMessaginBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print('FirebaseMessageing:$message');
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true
    );
    _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true
    );
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
            return HiddenDrawer();
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
