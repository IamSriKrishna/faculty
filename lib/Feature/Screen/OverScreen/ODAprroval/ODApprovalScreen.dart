// ignore_for_file: prefer_const_constructors

import 'package:faculty/Feature/Service/FormService.dart';
import 'package:faculty/Feature/Service/notification.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/Additional/Loader.dart';
import 'package:faculty/model/Form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ODApproval extends StatefulWidget {
  static const route = '/ODApproval';
  const ODApproval({super.key});

  @override
  State<ODApproval> createState() => _ODApprovalState();
}

class _ODApprovalState extends State<ODApproval> {
  bool reject = false;
  bool accept = false;
  List<FormModel>? fetchFromForm;
  final FormService _formService = FormService();
  final FCMNotification _fcmNotification = FCMNotification();
  void retreive()async{
    fetchFromForm = await  _formService.DisplayAllForm(context: context);
    setState(() {
      
    });
  }
  @override
  void initState() {
    retreive();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final faculty = Provider.of<FacultyProvider>(context).user;
    return fetchFromForm==null?Loader() :Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: fetchFromForm!.length,
        itemBuilder:(context, index) {
          final reversedIndex = fetchFromForm!.length - 1 - index;
          final form = fetchFromForm![reversedIndex]; 
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              //color: cardColor,
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
                          child: form.dp.isNotEmpty
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: form.dp,
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
                                form.name,
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
                          Text(form.formtype),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              accept==false?ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.31
                                    , MediaQuery.of(context).size.height * 0.05
                                    )
                                ),
                                onPressed: (){
                                  _formService.formResponse(formid: form.id, response: 'Accepted')
                                  .then((value) => _fcmNotification.sendNotification(
                                    form.fcmtoken,
                                    '${faculty.role},Approved Your request',
                                  ));
                                }, 
                                child: Text('Approve')
                              ):Container(),
                              reject==false?Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.31
                                    , MediaQuery.of(context).size.height * 0.05
                                    ),
                                    backgroundColor: Colors.grey
                                  ),
                                  onPressed: (){
                                    _fcmNotification.sendNotification(
                                      form.fcmtoken,
                                      '${faculty.role},Declined Your request', 
                                    ).then((value) => _formService.formResponse(formid: form.id, response: 'Rejected'));
                                  }, 
                                  child: Text('Reject')
                                ),
                              ):Container(),
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
      ),
    );
  }
}