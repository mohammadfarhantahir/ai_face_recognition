import 'dart:convert';

import '../api/userwebservice.dart';
import '../const/fetchFaceUrl.dart';

class Users {

  final String folder_name;
  final String image_name;
  final String enrolled_by;
  final String folder_creation_date;
  final String folder_creation_time;
  final String folder_have_model;

  Users({
    required this.folder_name,
    required this.image_name,
    required this.enrolled_by,
    required this.folder_creation_date,
    required this.folder_creation_time,
    required this.folder_have_model
  }
      );

  factory Users.fromJson(Map<String,dynamic> json) {
    return Users(
        folder_name: json['folder_name'],
        image_name: json['image_name'],
        enrolled_by: json['enrolled_by'],
        folder_creation_date: json['folder_creation_date'],
        folder_creation_time: json['folder_creation_time'],
        folder_have_model: json['folder_have_model']
    );

  }

  static Resource<List<Users>> get all {

    return Resource(
        url: Constants.userDetails,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Users.fromJson(model)).toList();
        }
    );

  }

}