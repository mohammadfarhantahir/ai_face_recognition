

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ai_face/const/globals.dart' as globals;
import '../provider/theme_provider.dart';
import '../widgets/change_theme_button_widget.dart';

class adminSettings extends StatefulWidget{

  State<adminSettings> createState()=> adminSettingsState();

}

class adminSettingsState extends State<adminSettings>{

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  globals.darkmode?Colors.black:Colors.white,
        title:  AutoSizeText('Settings',style: GoogleFonts.gruppo(fontSize: 28,fontWeight: FontWeight.bold)),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


        ],
      ),
    );
  }


}