import 'dart:convert';

import '../api/webservice.dart';
import '../const/fetchFaceUrl.dart';

class Faces {

  final String verification_start_time;
  final String verification_end_time;
  final String verification_lat;
  final String verification_long;
  final String verification_date;
  final String verification_result;

  Faces({
    required this.verification_start_time,
    required this.verification_end_time,
    required this.verification_lat,
    required this.verification_long,
    required this.verification_date,
    required this.verification_result
  }
  );

  factory Faces.fromJson(Map<String,dynamic> json) {
    return Faces(
        verification_start_time: json['verification_start_time'],
        verification_end_time: json['verification_end_time'],
        verification_lat: json['verification_lat'],
        verification_long: json['verification_long'],
        verification_date: json['verification_date'],
        verification_result: json['verification_result']
    );

  }

  static Resource<List<Faces>> get all {

    return Resource(
        url: Constants.fetchFaces,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Faces.fromJson(model)).toList();
        }
    );

  }

}