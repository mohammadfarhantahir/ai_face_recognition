


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:ai_face/const/globals.dart' as globals;
import '../api/userwebservice.dart';
import '../model/userfoundModel.dart';

class adminDashboard extends StatefulWidget{

  State<adminDashboard> createState()=> adminDashboardState();
}

class adminDashboardState extends State<adminDashboard>{
  List<Users> _userDetails = <Users>[];
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.initState();
    getadminauto();
    _populateUsers();
  }

  movetoverification(BuildContext context){
    _userDetails.clear();
    Navigator.pushNamed(context, '/adminVerification');

  }
  movetoadminsetttings(BuildContext context){
    _userDetails.clear();
    Navigator.pushNamed(context, '/adminSettings');

  }
  getadminauto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    globals.adminauto= prefs.getString('admin');
    print('admin username is ----->'+globals.adminauto!);


    return globals.adminauto;
  }

  movetomanager(BuildContext context){
    _userDetails.clear();
    Navigator.pushNamed(context, '/adminLiveManager');

  }
  void _populateUsers() {

    UserWebservice().load(Users.all).then((faceFound) => {
      setState(() => {
        _userDetails = faceFound
      })
    });

  }
  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        title: Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery
              .of(context)
              .size
              .height / 3,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child:  Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                          Container(
                            height: 100,

                            child: Column(
                              children: [

                                ClipOval(
                                  child: Image.network(
                                    'http://'+globals.readIPURL!+'/face-recognition-webservice-master/train/train/'+ _userDetails[index].folder_name+'/'+_userDetails[index].image_name,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeText('Id/name : ',style: GoogleFonts.gruppo(fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),),
                                  AutoSizeText(_userDetails[index].folder_name,style: GoogleFonts.gruppo(fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal))

                                ],
                              ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child:  Text('Enrolled By: ',style: GoogleFonts.gruppo(fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),), ),
                                    Expanded(
                                        flex: 3,
                                        child:   Text(_userDetails[index].enrolled_by,style: GoogleFonts.gruppo(fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)))



                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AutoSizeText('Creation Date : ',style: GoogleFonts.gruppo(fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),
                                    AutoSizeText(_userDetails[index].folder_creation_date,style: GoogleFonts.gruppo(fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal))

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AutoSizeText('Creation Time : ',style: GoogleFonts.gruppo(fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),
                                    AutoSizeText(_userDetails[index].folder_creation_time,style: GoogleFonts.gruppo(fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal))

                                  ],
                                )








                              ],
                            ),
                          ),
                        ),

                      ],
                    )
                  ]),

          ),
          decoration: BoxDecoration(
              color: Color(0xFF000000),
              borderRadius: BorderRadius.circular(18),
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
        )

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: AutoSizeText('Admin Dashboard',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: AutoSizeText(
                  "SWIMS- BIO",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: AutoSizeText('enrolled face'),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFE8E7E8),
                  child: AutoSizeText(
                    "E",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled),
              title: const AutoSizeText('Live Manager'),
              onTap: () {

                Navigator.pop(context);
                movetomanager(context);


              },
            ),

            ListTile(
              leading: const Icon(CupertinoIcons.arrowtriangle_down_circle_fill),
              title: const AutoSizeText('Verifications'),
              onTap: () {

                Navigator.pop(context);
                movetoverification(context);


              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.settings),
              title: const AutoSizeText('Settings'),
              onTap: () {

                Navigator.pop(context);
                movetoadminsetttings(context);


              },
            ),
        ])
      ),
      body:    Container(
        child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [

                  StickyHeader(
                  header:  Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Container(
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child:  Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child:  AutoSizeText('Hi,🖐 Enrolled Face',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                          )
                      ),

                      Expanded(
                        flex: 1,
                        child:   Text('Total users are '+_userDetails.length.toString(),style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),)


                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xFFffffff),
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

                          // onChanged: onTextChange,
                            decoration: InputDecoration(
                                fillColor: Colors.black.withOpacity(0.1),
                                filled: true,
                                prefixIcon: Icon(Icons.search,color: Colors.black,),
                                hintText: 'Search users ...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.zero
                            )
                        )
                    ),

                  )
                ],
              )
          ),
        ),
          content: ListView.builder(
            controller: _scrollController,
           // physics: ClampingScrollPhysics(),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _userDetails.length,
            itemBuilder: _buildItemsForListView,
          ),
                  )





                ],
              ),
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Material(
            type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4.0),
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                //This keeps the splash effect within the circle
                borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                onTap: (){
                  setState(() {
                    print('floating button clicked');
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceIn
                    );
                  });

                },
                child: Padding(
                  padding:EdgeInsets.all(10.0),
                  child:  Image.asset(
                      'assets/images/arrow_down.gif',
                      height: 30,
                      width: 30,
                    )
                ),
              ),
            )
        ),
      )


    );
  }


}
