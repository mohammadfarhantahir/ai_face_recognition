import 'dart:convert';

import 'package:ai_face/api/facedetailslist.dart';
import '../const/fetchFaceUrl.dart';
import 'package:ai_face/const/globals.dart' as globals;

class FacesDetails {

  final String image_name;
  final String enrolled_by;
  final String folder_creation_date;
  final String folder_creation_time;


  FacesDetails({
    required this.image_name,
    required this.enrolled_by,
    required this.folder_creation_date,
    required this.folder_creation_time
  }
      );

  factory FacesDetails.fromJson(Map<String,dynamic> json) {
    return FacesDetails(
        image_name: json['image_name'],
        enrolled_by: json['enrolled_by'],
        folder_creation_date: json['folder_creation_date'],
        folder_creation_time: json['folder_creation_time']
    );

  }

  static Resource<List<FacesDetails>> get all {

    return Resource(
        url: globals.facefetchresulturl,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => FacesDetails.fromJson(model)).toList();
        }
    );

  }

}