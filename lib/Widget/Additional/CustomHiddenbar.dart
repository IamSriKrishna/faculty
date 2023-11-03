import 'dart:async';
import 'package:faculty/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:faculty/Feature/Screen/OverScreen/ODAprroval/ODApprovalScreen.dart';
import 'package:faculty/Feature/Screen/OverScreen/Post/Add_post.dart';
import 'package:faculty/Util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HiddenDrawer extends StatefulWidget {
  static const route = 'HiddenDrawer';
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  @override
  void dispose() {

    super.dispose();
  }

  List<ScreenHiddenDrawer> _pages = [];

  
  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          colorLineSelected: themeColor.appThemeColor2,
          name: 'CampusLink', 
          baseStyle: GoogleFonts.merriweather(
            color: themeColor.appThemeColor2
          ), 
          selectedStyle: GoogleFonts.merriweather(
            color: themeColor.appThemeColor2
          ),
        ), 
        MainScreen()
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          colorLineSelected: themeColor.appThemeColor2,
          name: 'Approval', 
          baseStyle: GoogleFonts.merriweather(), 
          selectedStyle: GoogleFonts.merriweather(),
        ), 
        const ODApproval()
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          colorLineSelected: themeColor.appThemeColor,
          name: 'Add Post', 
          baseStyle: GoogleFonts.merriweather(), 
          selectedStyle: GoogleFonts.merriweather(),
        ), 
        const AddPostScreen()
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return HiddenDrawerMenu(
      initPositionSelected: 0,
      backgroundColorMenu: Colors.transparent,
      backgroundColorAppBar: Colors.white,
      screens: _pages,
      leadingAppBar: Transform.flip(
          flipX: true,
          child: Image.asset(
            'asset/icons/menu.png',
            height: MediaQuery.of(context).size.height * 0.0325,
            color: themeColor.appThemeColor
          ),
        ),
        styleAutoTittleName: GoogleFonts.merriweather(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: themeColor.appThemeColor
          ),
        elevationAppBar: 0,
        backgroundColorContent: themeColor.appBarColor,
    );
    
  }
  
}