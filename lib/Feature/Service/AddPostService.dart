// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:faculty/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/Additional/error_handling.dart';
import 'package:faculty/Util/Additional/snackbar.dart';
import 'package:faculty/Util/util.dart';
import 'package:faculty/Widget/Additional/CustomHiddenbar.dart';
import 'package:faculty/model/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class AddPostService{

  void uploadPost({
    required BuildContext context,
    required String description,
    required String title,
    required String link,
    required List<File> images,
  })async{
    
      
      final userProvider = Provider.of<FacultyProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dadtmv9ma', 't154mm7k');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: 'Post'),
        );
        imageUrls.add(res.secureUrl);
      }

      Post post = Post(
        id: '',
        name: userProvider.user.name, 
        dp: userProvider.user.dp, 
        image_url: imageUrls, 
        link: link,
        likes: [], 
        description: description, 
        title: title, 
        createdAt: DateTime.now()
      );

      http.Response res = await http.post(
        Uri.parse('$uri/post/faculty/createPostData'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: post.toJson(),
      );
      print(res.body);
      print(res);
      
      print(userProvider.user.token);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pushReplacementNamed(context, HiddenDrawer.route);
        },
      );
    }catch(error){
      print('Failed:$error');
    }
  }

  Future<List<Post>> DisplayAllForm(
  {
    required BuildContext context,
  }
  )async{
    List<Post> form = [];
    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/post/getAllPostData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("response=${res.body}");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            form.add(
              Post.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return form;
  }
}