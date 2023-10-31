// ignore_for_file: prefer_const_declarations, use_build_context_synchronously

import 'dart:convert';

import 'package:faculty/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:faculty/Util/Additional/error_handling.dart';
import 'package:faculty/Util/LocalNotification.dart';
import 'package:faculty/Util/showsnackbar.dart';
import 'package:faculty/Util/util.dart';
import 'package:faculty/model/Form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// Define a unique key for storing the upload count for each user.
final String uploadCountKey = 'uploadCount';
final String lastUploadDateKey = 'lastUploadDate';
class FormService{

  //Upload Form
  void UploadForm(
  {
    required BuildContext context,
    required String rollno,
    required String name,
    required String department,
    required String image,
    required String year,
    required String formtype,
    required String Studentclass,
    required String reason,
    required int no_of_days,
    required String from,
    required String to,
    required DateTime createdAt,
    required String id,
    required int spent
  }
  )async{
    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final lastUploadDate = prefs.getString(lastUploadDateKey);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // If it's a new day, reset the upload count and update the last upload date.
    if (lastUploadDate == null || DateTime.parse(lastUploadDate).isBefore(today)) {
      prefs.setInt(uploadCountKey, 0);
      prefs.setString(lastUploadDateKey, today.toIso8601String());
    }

    // Check if the user has exceeded the upload limit.
    int uploadCount = prefs.getInt(uploadCountKey) ?? 0;
    if (uploadCount >= 2) {
      showSnackBar(context: context, text: 'You have reached the daily upload limit.');
      return;
    }
      FormModel user = FormModel(
        spent:spent,
        id: id,
        name: name, 
        rollno: rollno, 
        department: department, 
        dp: image, 
        no_of_days:no_of_days,
        from: from,
        to: to,
        response: '',
        createdAt: createdAt,
        year: year, 
        formtype: formtype, 
        Studentclass: Studentclass, 
        reason: reason
      );
      
      http.Response res = await http.post(
        Uri.parse('$uri/kcg/student/form-upload'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          LocalNotifications.showSimpleNotification(
                    title: 'Campus~Link',
                    body: "Form Request Successfully Sent\nCheck History",
                  ).then((value) => Navigator.pushNamedAndRemoveUntil(context, OverScreen.route, (route) => false).then((value) => showSnackBar(
            context:context,
            text:'Account created! Login with the same credentials!',
          )));
          
          
        },
      );
    } catch (e) {
      showSnackBar( context:context,text: e.toString());
    }
  }



}