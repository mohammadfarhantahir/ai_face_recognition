
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ai_face/const/globals.dart' as globals;

import 'homeScreen.dart';
XFile? imageFile;
late File file;
late String imageFilenew='';
String _similarity = "nil";
var image1 = new Regula.MatchFacesImage();
var image2 = new Regula.MatchFacesImage();
class enrollment extends StatefulWidget{

  State<enrollment> createState() => _enrollmentState();

}

class _enrollmentState extends State<enrollment>{

  late Uint8List encodeedimg;



  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source, imageQuality: 90,maxHeight: 1380, maxWidth: 18420);
      if (pickedImage != null) {
        // textScanning = true;
        imageFile = pickedImage;

        setState(() async {
          file =  File(imageFile!.path);
          print('picked file is:'+file.path);
          // var add =
          // uint8List =  io.File(file.path).readAsBytesSync();
          globals.uint8Listglobal = Uint8List.fromList(File(file.path).readAsBytesSync());
          final tempDir = await getTemporaryDirectory();
          var rnd = new Random();
          var next = rnd.nextDouble() * 1000000;
          while (next < 100000) {
            next *= 10;
          }
          print(next.toInt());
          String valueofrandom= next.toInt().toString();
          File file12 = await File('${tempDir.path}/'+valueofrandom+'.png').create();
         // file12.writeAsBytesSync(globals.uint8Listglobal!);
          print('uint8List value------>'+file12.path+'\n'+'======>'+valueofrandom);
          globals.filepaths = file12.path;
          globals.first = true;
        });

      }
    } catch (e) {
      // textScanning = false;
      imageFile = null;

      setState(() {});
    }
  }

  setImage(bool first, List<int> imageFile, int type) async {


    if (imageFile == null) return;
    setState(() => _similarity = "nil");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      globals.uint8Listglobal = Uint8List.fromList(imageFile);
      final tempDir = await getTemporaryDirectory();
      var rnd = new Random();
      var next = rnd.nextDouble() * 1000000;
      while (next < 100000) {
        next *= 10;
      }
      print(next.toInt());

      String valueofrandom= next.toInt().toString();
      File file12 = await File('${tempDir.path}/'+valueofrandom+'.png').create();
      file12.writeAsBytesSync(globals.uint8Listglobal!);
      print('uint8List value------>'+file12.path+'\n'+'======>'+valueofrandom);
      globals.filepaths = file12.path;

      String base64String = base64Encode(imageFile);
      String header = "data:image/png;base64,";
      String complete = header+base64String;
      print('---------->'+complete+'\n-----'+type.toString());


    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      //setState(() => img2 =  Image.memory(uint8List));
    }
  }
  late var result;
  void facecapture(){
    Regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
        setImage(
            globals.first,
            base64Decode(Regula.FaceCaptureResponse.fromJson(
                json.decode(result))!
                .image!
                .bitmap!
                .replaceAll("\n", "")),
            Regula.ImageType.LIVE));
    imageFilenew= json.decode(result);
    globals.first=true;
    print('image value -------'+imageFilenew);

    Navigator.pop(context);
  }





  late int count=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.black,
     appBar: AppBar(
       centerTitle: true,
       title: Text("Enroll Face",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.white),
         onPressed: () => movetoback(context),

       ),
       flexibleSpace: Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: <Color>[Color(0xff000000), Color(0xff000000)]),

         ),
       ),
     ),
     body: Center(
         child: SingleChildScrollView(

           child: Container(
               margin: const EdgeInsets.all(20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Stack(
                     children: [
                       Container(
                         height: 400,
                         width: 400,
                         child:
                             Padding(
                               padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                               child:globals.first?Image.memory(globals.uint8Listglobal!):
                               Center(
                                 child: Text('Please choose image',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),
                               ),

                                   )

                             ),
                         decoration: BoxDecoration(
                             color: Color(0xFF000000),
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [
                               const BoxShadow(
                                 color: Color(0xFFffffff),
                                 offset: Offset(2, 2),
                                 blurRadius: 10,
                                 spreadRadius: 1,
                               ),
                               const BoxShadow(
                                 color: Color(0xFFffffff),
                                 offset: Offset(-2, -2),
                                 blurRadius: 10,
                                 spreadRadius: 1,
                               ),
                             ]
                         ),
                       ),


                     ],
                   ),

                   SizedBox(height: 30,),
                   // if (imageFile != null) Image.file(File(imageFilenew)),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       Expanded(
                         flex: 1,
                         child: GestureDetector(
                         onTap: () {
                           globals.first=true;
                           getImage(ImageSource.gallery,);
                         
                           print('gallery clicked');
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width/1.2,
                           height: 100,
                           padding: EdgeInsets.all(8),
                           child: Center(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   SizedBox(
                                     height: 20,
                                   ),
                                   Expanded(
                                       flex: 1,
                                       child: Icon(CupertinoIcons.photo,color: Colors.white)),
                                   SizedBox(
                                     height: 20,
                                   ),
                                   Expanded(
                                     flex: 2,
                                     child:FittedBox(
                                       fit: BoxFit.fitWidth,
                                       child: Text('Gallery',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),)
                                   )
                                 ],
                               )
                           ),
                           decoration: BoxDecoration(
                               color: Color(0xFF000000),
                               borderRadius: BorderRadius.circular(20),
                               boxShadow: [
                                 const BoxShadow(
                                   color: Color(0xFFffffff),
                                   offset: Offset(2, 2),
                                   blurRadius: 10,
                                   spreadRadius: 1,
                                 ),
                                 const BoxShadow(
                                   color: Color(0xFFffffff),
                                   offset: Offset(-2, -2),
                                   blurRadius: 10,
                                   spreadRadius: 1,
                                 ),
                               ]
                           ),
                         ),

                       ),
                       ),
                       SizedBox(
                         width: 30,
                       ),
                       Expanded(
                         flex: 1,
                         child: GestureDetector(
                           onTap: () {
                             globals.first=true;
                             facecapture();
                             print('camera clicekd');
                           },
                           child: Container(
                             width: MediaQuery.of(context).size.width/1.2,
                             height: 100,
                             padding: EdgeInsets.all(8),
                             child: Center(
                                 child: Column(
                                   children: [
                                     SizedBox(
                                       height: 20,
                                     ),
                                     Expanded(
                                         flex: 1,
                                         child: Icon(CupertinoIcons.camera,color: Colors.white)),
                                     SizedBox(
                                       height: 20,
                                     ),
                                     Expanded(
                                       flex: 2,
                                       child: FittedBox(
                                         fit: BoxFit.fitWidth,
                                         child:
                                       Text('Camera',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),)
                                     )
                                   ],
                                 )
                             ),
                             decoration: BoxDecoration(
                                 color: Color(0xFF000000),
                                 borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                   const BoxShadow(
                                     color: Color(0xFFffffff),
                                     offset: Offset(2, 2),
                                     blurRadius: 10,
                                     spreadRadius: 1,
                                   ),
                                   const BoxShadow(
                                     color: Color(0xFFffffff),
                                     offset: Offset(-2, -2),
                                     blurRadius: 10,
                                     spreadRadius: 1,
                                   ),
                                 ]
                             ),
                           ),

                         ),
                       ),
                       SizedBox(
                         width: 30,
                       ),
                       Expanded(
                         flex: 1,
                         child: GestureDetector(
                           onTap: () {

                             print('both camera clicekd');
                           },
                           child: Container(
                             width: MediaQuery.of(context).size.width/1.2,
                             height: 100,
                             padding: EdgeInsets.all(8),
                             child: Center(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Expanded(
                                       flex: 1,
                                         child:  Center(
                                           child: Icon(CupertinoIcons.camera_on_rectangle,color: Colors.white),
                                         ),),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      Expanded(
                                        flex: 2,
                                          child:Align(
                                            alignment: Alignment.center,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child:
                                            Text('Use Both\nCamera',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),)
                                          )

                                      ),
                                     SizedBox(
                                       height: 5,
                                     ),


                                   ],
                                 )
                             ),
                             decoration: BoxDecoration(
                                 color: Color(0xFF000000),
                                 borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                   const BoxShadow(
                                     color: Color(0xFFffffff),
                                     offset: Offset(2, 2),
                                     blurRadius: 10,
                                     spreadRadius: 1,
                                   ),
                                   const BoxShadow(
                                     color: Color(0xFFffffff),
                                     offset: Offset(-2, -2),
                                     blurRadius: 10,
                                     spreadRadius: 1,
                                   ),
                                 ]
                             ),
                           ),

                         ),
                       )
                       
                       
                     ],
                   ),

                   const SizedBox(
                     height: 40,
                   ),
                   GestureDetector(
                     onTap: () {
                       print('Submit clicked');
                     },
                     child: Container(
                       width: MediaQuery.of(context).size.width/1.2,
                       height: 70,
                       padding: EdgeInsets.all(8),
                       child: Center(
                         child: FittedBox(
                           fit: BoxFit.fitWidth,
                           child:
                         Text('Submit',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
                       ),),
                       decoration: BoxDecoration(
                           color: Color(0xFF000000),
                           borderRadius: BorderRadius.circular(50),
                           boxShadow: [
                             const BoxShadow(
                               color: Color(0xFFffffff),
                               offset: Offset(2, 2),
                               blurRadius: 10,
                               spreadRadius: 1,
                             ),
                             const BoxShadow(
                               color: Color(0xFFffffff),
                               offset: Offset(-2, -2),
                               blurRadius: 10,
                               spreadRadius: 1,
                             ),
                           ]
                       ),
                     ),

                   ),
                   const SizedBox(
                     height: 20,
                   ),

                 ],
               )),
         ),
     ),
   );
  }


}

void movetoback(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
}