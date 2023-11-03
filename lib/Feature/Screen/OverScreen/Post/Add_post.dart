// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:faculty/CleanWidget/CustomSpinKit.dart';
import 'package:faculty/Feature/Service/AddPostService.dart';
import 'package:faculty/Util/util.dart';
import 'package:faculty/Widget/Additional/custom_button.dart';
import 'package:faculty/Widget/Additional/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/AddPostScreen';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final AddPostService adminServices = AddPostService();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool _link = false;
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }
  bool _load = false;
  void sellProduct({
    required String description,
    required String title,
    required String link
  }) {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.uploadPost(
        context: context, 
        description: description, 
        title: title, 
        link: link, 
        images: images
      );
      setState(() {
        _load = true;
      });
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.fitWidth,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Select Images',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: titleController,
                      hintText: 'Title',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      maxLines: 7,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          value: _link, 
                          onChanged:(value) {
                            setState(() {
                              _link = !_link;
                            });
                          },
                        ),
                        Text('Link')
                      ],
                    ),
                    _link?CustomTextField(
                      controller: linkController,
                      hintText: 'Link',
                    ):Container(),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Upload',
                      onTap:() => sellProduct(
                        description: descriptionController.text, 
                        title: titleController.text, 
                        link: _link==false?'null':linkController.text
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          _load == true?
          CustomSpinkit():Container()
        ],
      ),
    );
  }
}