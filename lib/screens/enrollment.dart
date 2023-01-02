
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ai_face/const/globals.dart' as globals;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../api/folder_check.dart';
import '../api/insertTrainingdata.dart';
import '../api/model_creation.dart';

import '../api/trainServer.dart';
import '../utils/dialogAlerts.dart';
import '../utils/makePdf.dart';
import 'homeScreen.dart';
import 'idcardScanner.dart';
import 'mlKitfaceDetectorView.dart';
XFile? imageFile;
late File file;

late String imageFilenew='';
String _similarity = "nil";
var image1 = new Regula.MatchFacesImage();
var image2 = new Regula.MatchFacesImage();
final nameController = TextEditingController();
late String pathofimg ='';
bool facestatusknownUnknow= false;
File? localFile;
late String imageuploadstatus='';
late String filepath1='';
late String resdata='';
late String imgpatfhforalert;
late String nameofface='';
late String _rere='';
late String imageofface = '';
bool enrollmentStatus=true;
int buttoncount=0;

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
                json.decode(result)
            )!
                .image!
                .bitmap!
                .replaceAll("\n", "")
            ),
            Regula.ImageType.LIVE)
    );
    imageFilenew= json.decode(result);
    globals.first=true;
    print('image value -------'+imageFilenew);

    Navigator.pop(context);
  }



  Future<String>  upload(imageFile,BuildContext context)async{


    //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("http://"+globals.readIPURL!+'/face-recognition-webservice-master/train/uploadfacetoserver.php');

    var request = http.MultipartRequest("POST",uri);
    request.fields['folder_name'] = nameController.text.toString();

    var pic = await http.MultipartFile.fromPath("image", imageFile);
    request.files.add(pic);
    var response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    resdata = responseString.toString();
    _rere = resdata;
    // Map<String, dynamic> data = jsonDecode(_rere);


    print("--->"+_rere);
    // print('pic file name '+pic.filename.toString());
    print('now upload section image path:'+imageFile.toString());
    String getimagename = globals.filepaths;

    final split = getimagename.split('/');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++)
        i: split[i]
    };

   final imagevalue = values[6];
   globals.imagenameforenrollment = imagevalue.toString();
   print('image name ----->'+globals.imagenameforenrollment);
    // {0: grubs, 1:  sheep}


    //var pic1 = await http.MultipartFile.fromPath("image", value7!);


    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));


    if (response.statusCode == 200) {
      print("image uploaded");
      imageuploadstatus = "image uploaded sucessfully!";

      await ApiofTrainmodel().gettrainapiresult();
      _gettrainserver(context);
      //  _gettrainapidetail(context);
      // globals.trainingstatusface = false;
      //   showAlertDialogserverresponse(context);


      // dismiss dialog
      // Toast.show('image uploaded successfully', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }else{
      print("uploaded faild");

    }

    return response.stream.toString();


  }




  void _gettrainserver(BuildContext context) async {
    int counta = 0;

    if(globals.valueoftrainstatus == ' "Training complete"'){
      print('yes training completed');
      // Navigator.of(context, rootNavigator: true).pop();
      buttoncount = 0;
      dialogAlertslforEnrollmentSuccess(context);


      //Navigator.pop(dialogContexttoclosefacetection); // <<----
      ///Navigator.pop(dialogContextafterfacedetection); // <<----



      // showAlertSucess(context);
      // showAlertMore(context);


      setState(() {
        clearlabel();
        clearimage();
        globals.first = false;
       // dialogAlertForIdcard(context);
        enrollmentStatus = true;

      });

      /* await Future.delayed(Duration(milliseconds: 800), () {
      // Do something

      Navigator.pop(dialogContextTRAININGSUCCESS); // <<----
     // gobacktomain(context);
    });*/

      print('server response TRAINED successfully');



    }
    else{
      print('server response TRained not successfully');
    }




  }




  late final String uploadUrlfacedetection = 'http://128.199.243.236:8000/detect';
  Future<String?> uploadImagefacedetection(filepath, url,BuildContext context) async {

    // showAlertDialogserverresponsewait(context);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();

    if(res.statusCode==500){
     setState(() {
       enrollmentStatus = true;

       print('no face dound');
       buttoncount = 0;
       dialogAlertsEnrollmentnofacefound(context);

     });
    }
    else{

      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);
      resdata = responseString.toString();
      _rere = resdata;
      print(resdata.toString());

      final parsedJson = json.decode(_rere);
      final privilege = parsedJson['facescount'];

      String imgval1 = privilege.toString().replaceAll("[", '');
      String imgval2= imgval1.replaceAll(']', '');
      print("--->"+imgval2);
      if(imgval2=='0'){


      }
      else if(imgval2=='1'){

        print('can regsiterd this face on server');

        setState(() {

        });



      }
      else{
        print('more then 1 faces');
        setState(() {
          buttoncount = 0;
          enrollmentStatus = true;

          dialogAlertsEnrollmentMorethen1face(context);

        });



      }



      // print(responseString);

    }








    return res.reasonPhrase;
  }


  late final String uploadUrlfacereco = 'http://'+globals.readIPURL!+':5000/api/recognize';
  Future<String?> uploadImagefacerec(filepath, url,BuildContext context) async {
    var headers = {
      'Access-Control-Allow-Methods', 'PUT,POST,PATCH,DELETE,GET'


    };
    // showAlertDialogserverresponsewait(context);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    var responseBytes = await res.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    resdata = responseString.toString();
    _rere = resdata;
    print('------>'+request.toString());
    Map<String, dynamic> data = jsonDecode(_rere);
    if(resdata=='<!DOCTYPE html><html lang=en><meta charset=UTF-8><title>⚠️ 500 — Internal Server Error</title>'){
      print('no face dound in tis image');
    }
    else{
      print('not working');
    }

    String s = data["Name"].toString().replaceAll("[", "").replaceAll(']', '');
    if(s.isEmpty){
      print('value is empty');
      setState(() {


        dialogAlerts(context);
      });

    }
    else{
      final split = s.split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++)
          i: split[i]
      };
      final vaa1 = values[0];
      print('----->splitedd value'+vaa1.toString());
      nameofface =vaa1.toString();
      globals.verifiedName = vaa1.toString();
      if(nameofface=='unknown'){
        setState(() {


          facestatusknownUnknow = false;
          checklabel(context);
          print('face is unknown and can used to process forward');
        });
      }
      else if(nameofface=='[]'){
        print('no face found');

        setState(() {


          dialogAlerts(context);
        });


      }
      else{

        facestatusknownUnknow = true;
        print('face found');
        enrollmentStatus = true;
        buttoncount = 0;
        dialogAlertsEnrollmentFacefound(context);
        facestatusknownUnknow = true;
      }

      setState(() {


        print(responseString);
      });





    }


    /*nameofface =s.replaceAll("]", "");
    globals.verifiedName = nameofface;
    if(nameofface=='unknown'){

      facestatusknownUnknow = false;
      checklabel(context);
      print('face is unknown and can used to process forward');
    }
    else{
      print('face found');
      enrollmentStatus = true;
      dialogAlertsEnrollmentFacefound(context);
      facestatusknownUnknow = true;
    }
    String imgval = statusdata.toString().replaceAll(' ', '');
    String imgval1 = imgval.replaceAll("[", '');
    String imgval2= imgval1.replaceAll(']', '');
    imageofface = imgval2;
    print("``````````````"+token.toString());
    print("--->"+_rere);

    setState(() {


      print(responseString);
    });




*/





    return res.reasonPhrase;
  }




  Future<void> checklabel(BuildContext context) async {
    if(globals.storefoldername=='' ){
      print('textfield is empty');


    }
    else if(globals.filepaths==''){
      print('image is empty');

    }
    else if(globals.storefoldername!=null){
      await Apiofcheckfolder().gettrainapiresult();
      if(globals.foldercheck=='"already exists"'){
       setState(() {
         enrollmentStatus = true;

         print('FOLDER ALREADY EXISTS');
         buttoncount = 0;
         dialogAlertsEnrollmentNamefound(context);
       });
      }else{
        print('CAN PROCEED TO NEXT');
        await insertTrainingModelDetails();
        await Apiofmodelcreationfolder().getresults();
        upload(globals.filepaths, context);
      }
      // await Apiofcheckfolder().gettrainapiresult(context);
      print('now will check the folder existance');




    }
  }



  late int count=0;
  @override
  void initState() {

    globals.first = globals.mlcamerabool;
    print('value of bool '+globals.first.toString());
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.initState();

  }
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


                             movetobthcamera(context);

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
                   Container(
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
                     child: TextField(
                       style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),
                       enableSuggestions: false,
                       autocorrect: false,
                        controller: nameController,
                       decoration: InputDecoration(
                         floatingLabelBehavior: FloatingLabelBehavior.never,
                         // hintText: 'Password',
                          //hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),

                         border: InputBorder.none,
                         labelText: 'Enter Name',
                         labelStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),
                       ),
                       onChanged: (text) {

                       },
                     ),

                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   GestureDetector(
                     behavior: HitTestBehavior.opaque,

                     onTap: () {
                       FocusScopeNode currentFocus = FocusScope.of(context);
                       if (!currentFocus.hasPrimaryFocus) {
                         currentFocus.unfocus();
                       }
                      // dialogAlertForIdcard(context);
                       enrollmentStatus=false;
                       buttoncount = buttoncount+1;

                        setState(() {
                          globals.storefoldername =nameController.text.toString();
                          print(globals.storefoldername);
                          if(buttoncount==1){
                            if(nameController.text.isNotEmpty){
                              uploadImagefacerec(globals.filepaths, uploadUrlfacereco, context);


                            }
                            else if(globals.filepaths.isEmpty){
                              buttoncount = 0;
                              enrollmentStatus=true;
                              dialogAlertslforEnrollmentImage(context);
                            }
                            else{
                              buttoncount = 0;
                              dialogAlertslforEnrollmentempty(context);
                              enrollmentStatus=true;
                              print('field is empty');
                            }
                          }else{
                            dialogAlertslforTraining(context);
                            print('already clicked have patieces');

                          }

                         // checklabel(context);
                         // dialogAlertForIdcard(context);
                        });


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
                           enrollmentStatus?Text('Submit',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),):
                           Stack(
                             alignment: Alignment.center,
                             children: [


                               Container(

                                 child: Text('Wait',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                               ),

                               Container(

                                 height: 80,
                                 width: 80,

                                 child:  CircularProgressIndicator(
                                   color: Colors.white,

                                 ),
                               )
                             ],
                           ),

                       ),

                       ),
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
//  Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
  clearlabel();
  globals.first = false;
  Navigator.pushNamed(context, '/homescreen');

}

void movetobthcamera(BuildContext context){
 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceDetectorView()));
  Navigator.pushNamed(context, '/FaceDetectorView');

}

void movetoidpassport(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => idCardScannerCamera()));



}


void clearlabel(){
  nameController.clear();

}

void clearimage(){
  imageCache.clear();
  globals.mlcamerabool = false;
}