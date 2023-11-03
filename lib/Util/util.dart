
import 'dart:io';

import 'package:faculty/Constrains/AssetImage.dart';
import 'package:faculty/Constrains/FontFamily.dart';
import 'package:faculty/Constrains/ThemeColor.dart';
import 'package:faculty/Util/Duration.dart';
import 'package:file_picker/file_picker.dart';
// To access Fontfamily
RobotoFontFamily robotoFontFamily = RobotoFontFamily();


// To access App Theme Color
ThemeColor themeColor = ThemeColor();

// To access App assets images
AssetImage assetImage = AssetImage();

// To access App Duration
AppDuration duration = AppDuration();

String uri ="http://192.168.29.172:3000";

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return images;
}