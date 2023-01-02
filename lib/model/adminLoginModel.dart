import 'dart:convert';

List<AdminModel> adminLoginModel(String str) =>
    List<AdminModel>.from(json.decode(str).map((x) => AdminModel.fromJson(x)));



class AdminModel {
  AdminModel({
    required this.API,



  });


  String API;





  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(

    API: json["username"],



  );

  Map<String, dynamic> toJson() => {
    "API": API,




  };
}
