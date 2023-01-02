import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({
    required this.url,
    required this.parse});
}

class FaceDetailsList {

  Future<T> load<T>(Resource<T> resource) async {

    final response = await http.get(Uri.parse(resource.url));
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

}