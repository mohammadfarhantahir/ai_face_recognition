library ai_face.globals;

import 'dart:typed_data';


import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';

late final cameras;
Future<void> search() async {
  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();

// Get a specific camera from the list of available cameras.

}

late final firstCamera ;
late String trainresultstatus='';

var now = new DateTime.now();
var formatter = new DateFormat('MM');
var formattertext = new DateFormat('MMM');
var formatteryear = new DateFormat('yyyy');
var formatterdat = new DateFormat('dd');
String currentMOnth = formatter.format(now);
String currentYEar =  formatteryear.format(now);
String currentday = formatterdat.format(now);
String currentdate = currentday;
String todaysdate = currentdate+'/'+currentMOnth+'/'+currentYEar;
String newtodaysdate = currentdate+'-'+currentMOnth+'-'+currentYEar;
late String globalimgpath='';
late String storefoldername='';
late String statusoffaceexist='';
late String valueofstopstatus='';
late String valueoftrainstatus='';
late String serverstatusstart='';
late Stopwatch stopwatch;
late String facedetailnameid='';
bool statusoffacedetectionLive= false;
late String adminusername ='';
late String facefetchresulturl='';
String? readIPURL;
String? adminauto;
bool darkmode=true;
bool dialogloading = true;
late String verifiedName='';
bool idcardopeningstatus= false;
late File tmpFile;

late String scanNationality='';
late String scanGender='';
late String scanFirstName='';
late String scanLastName='';
late String pathimagetobeusedinpdf='';
late String foldercheck='';
String? username='';
late String password ='';
String imagenameforenrollment='';

late String imagelabelname ='';
String currenttime = DateFormat.jm().format(now);
late String finalpathfromfacedetector='';
Uint8List? uint8Listglobal;
late BuildContext contextgobal;
late bool first=false;
late bool takingimagestatus=false;
late String filepaths='';
late bool mlcamerabool = false;