import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faculty/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FormAccepted extends StatefulWidget {
  const FormAccepted({super.key});

  @override
  State<FormAccepted> createState() => _FormAcceptedState();
}

class _FormAcceptedState extends State<FormAccepted> {
  bool reject = false;
  bool accept = false;

  List<dynamic> fetchform = [];

  Future<void> fetchForm()async{
    http.Response res = await http.get(
      Uri.parse('$uri/kcg/student/form'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    fetchform = jsonDecode(res.body);
    setState(() { });
    setState(() { });
  }

  @override
  void initState() {
    fetchForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rejectedForms = fetchform.where((form) => form['response'] == 'Accepted').toList();
    //final faculty = Provider.of<FacultyProvider>(context).user;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: rejectedForms.length,
        itemBuilder:(context, index) {
          final reversedIndex = rejectedForms.length - 1 - index;
          final form = rejectedForms[reversedIndex]; 
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height:MediaQuery.of(context).size.height * 0.08,
                        child: ClipOval(
                          child: form['dp']!=null
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: form['dp'].toString(),
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.width * 0.15,
                                progressIndicatorBuilder: (context, url, progress) {
                                  return Center(
                                    child: CircularProgressIndicator(value: progress.totalSize!.toDouble()),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: MediaQuery.of(context).size.width * 0.1,
                                    ),
                                  );
                                },
                              )
                            : Container(), 
                        ),
                      )
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                form['name'],
                                style: GoogleFonts.merriweather(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: Text(
                                  'view more',
                                  style: GoogleFonts.merriweather(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(form['formtype']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.5
                                    , MediaQuery.of(context).size.height * 0.03
                                    )
                                ),
                                onPressed: (){
                                }, 
                                child: Text('Accepted')
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}