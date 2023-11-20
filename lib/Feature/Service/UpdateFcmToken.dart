// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class UpdateFCMToken{
  Future<void> fcmUpdate({
    required BuildContext context,
    required String fcmtoken,
  })async{
    final faculty = Provider.of<FacultyProvider>(context,listen: false).user;
    try{
      final Map<String, dynamic> data = {'fcmtoken': fcmtoken};
      http.Response res = await http.put(
        Uri.parse('$uri/kcg/faculty/fcm-token/${faculty.id}'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        print('FCMTOKEN updated successfully:'+fcmtoken);
        // You can handle success here
      } else {
        print('Failed to update Form');
        print(res.body);
        // Handle error here
      }
    }catch(e){
      print(e);
    }
  }
}