import 'dart:convert';
import 'package:booking_app_mobile/models/yard_model.dart';
import 'package:http/http.dart' as http;

//Mock service that works with mock data stores for testing.
class Service {
  // Methods for place entity

  Future<Yard?> getYard(String yardId) async {
    final response = await http.get(Uri.parse('https://d2bawuzpgqlp7v.cloudfront.net/api/v1/yards/$yardId'));
    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      return Yard.fromJson(responseBody['data']);
    }
    return null;
  }
}
