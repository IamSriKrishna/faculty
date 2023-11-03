// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:faculty/Util/util.dart';
import 'package:http/http.dart' as http;
class FCMNotification{
  sendNotification(String registrationToken, String body) async {
  final String url = "$uri/send-notification"; 
  final Map<String, dynamic> requestBody = {
    'registrationToken': registrationToken,
    'body': body,
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification: ${response.statusCode}");
    }
  } catch (e) {
    print("Error sending notification: $e");
  }
}
}