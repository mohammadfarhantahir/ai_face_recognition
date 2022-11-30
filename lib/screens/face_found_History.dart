

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/webservice.dart';
import '../model/foundfaces.dart';


class facFoundHistory extends StatefulWidget{
  State<facFoundHistory> createState()=> facefoundState();
}
class facefoundState extends State<facFoundHistory>{
  List<Faces> _faceFound = <Faces>[];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {

    Webservice().load(Faces.all).then((faceFound) => {
      setState(() => {
        _faceFound = faceFound
      })
    });

  }
  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(

              children: [
                Expanded(
                  flex: 1,
                  child:
                Container(
                  height: 100,

                  child: Column(
                    children: [
                      Text('Verification Starts : '+_faceFound[index].verification_start_time ,style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                      Text('Verification Ends : '+_faceFound[index].verification_end_time ,style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                      Text('Verification Date : '+_faceFound[index].verification_date ,style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                      Text('Verification Result : '+_faceFound[index].verification_result ,style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),

                    ],
                  ),
                ),
                 ) ,
                Expanded(
                  flex: 2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child:  Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      )
                    ),


                  )




                  /*GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    )*/


              ],

          )
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
        title: Text('Face Verification History',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
            child:Container(
              child:    Text('Total Actions : '+_faceFound.length.toString() ,style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            preferredSize: Size.fromHeight(0)
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _faceFound.length,
        itemBuilder: _buildItemsForListView,
      ),
    );
  }

}


