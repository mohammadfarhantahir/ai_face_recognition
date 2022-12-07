import 'dart:convert';

List<StopModel> recordofstopapiModelFromJson(String str) =>
    List<StopModel>.from(json.decode(str).map((x) => StopModel.fromJson(x)));



class StopModel {
  StopModel({
    required this.API,



  });


  String API;





  factory StopModel.fromJson(Map<String, dynamic> json) => StopModel(

    API: json["API"],



  );

  Map<String, dynamic> toJson() => {
    "API": API,




  };
}
