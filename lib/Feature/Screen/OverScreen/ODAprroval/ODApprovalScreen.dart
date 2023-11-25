// ignore_for_file: prefer_const_constructors


import 'package:faculty/Feature/Screen/OverScreen/ODAprroval/Widget/FormAccepted.dart';
import 'package:faculty/Feature/Screen/OverScreen/ODAprroval/Widget/FormRejected.dart';
import 'package:faculty/Feature/Screen/OverScreen/ODAprroval/Widget/Requested.dart';
import 'package:faculty/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
class ODApproval extends StatefulWidget {
  static const route = '/ODApproval';
  const ODApproval({super.key});

  @override
  State<ODApproval> createState() => _ODApprovalState();
}

class _ODApprovalState extends State<ODApproval> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: themeColor.appThemeColor,
            tabs: const [
              Tab(text: 'Requested'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            FormRequested(),
            FormAccepted(),
            FormRejected(),
          ],
        ),
      ),
    );
  }
}