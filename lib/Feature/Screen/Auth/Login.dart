// ignore_for_file: prefer_const_constructors

import 'package:faculty/Feature/Screen/Auth/Signup.dart';
import 'package:faculty/Feature/Screen/Auth/widget/LoginWidget.dart';
import 'package:faculty/Feature/Service/AuthService.dart';
import 'package:faculty/Util/FontStyle/RobotoBoldFont.dart';
import 'package:faculty/Util/FontStyle/RobotoRegularFont.dart';
import 'package:faculty/Util/util.dart';
import 'package:faculty/Widget/AuthBottomNavigatorWidget/AuthBottomNavigatorWidget.dart';
import 'package:faculty/Widget/TextField/CustomTextField.dart';
import 'package:faculty/Widget/TextField/CustomTextFieldPassword.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const route = '/Login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _rollNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoginWidget(),
          Padding(
            padding: const EdgeInsets.only(top:307.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,left:10),
                    child: RobotoBoldFont(
                      text: 'Login Now!',
                      size: 25,
                      textColor: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left:10),
                    child: RobotoRegularFont(
                      text: 'Join the Faculty Hub',
                      size: 19,
                      fontWeight: FontWeight.w100,
                      textColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    labelText: 'Email',
                    controller: _rollNumber,
                    //textCapitalization: TextCapitalization.characters,
                  ),
                  CustomTextFieldPassword(password: _password,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor.appThemeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: (){
                        _authService.signInUser(
                          context: context, 
                          email: _rollNumber.text, 
                          password: _password.text
                        );
                      }, 
                      child: RobotoBoldFont(text: 'Login')
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:AuthBottomNavigatorWidget(
        prefixText: 'Ready to Begin Your Journey?', 
        sufixText: 'Sign Up', 
        onTap: (){
          Navigator.pushNamed(context, SignUp.route);
        }
      ),
    );
  }
}