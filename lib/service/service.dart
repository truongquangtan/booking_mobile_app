import 'dart:convert';
import 'package:booking_app_mobile/models/district.dart';
import 'package:booking_app_mobile/models/province.dart';
import 'package:booking_app_mobile/models/yard_model.dart';
import 'package:booking_app_mobile/models/yard_simple.dart';
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

  Future<List<Province>> getAllProvinces() async {
    final response = await http.get(Uri.parse('https://d2bawuzpgqlp7v.cloudfront.net/api/v1/provinces'));
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      return data.map((data) => Province.fromJson(data)).toList().cast<Province>();
    }
    return [];
  }

  Future<List<District>> getDistrictByProvince(int provinceId) async {
    final uri = 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1/provinces/$provinceId/districts';
    final response = await http.get(Uri.parse(uri));
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      return data.map((data) => District.fromJson(data)).toList().cast<District>();
    }
    return [];
  }

  Future<List<YardSimple>> getYardList(String? provinceId, String? districtId) async {
    const uri = 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1/yards/search';
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
      'itemsPerPage': 1000,
      'page': 1,
      'provinceId': provinceId ?? '',
      'districtId': districtId ?? '',
      }),
    );
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      return data['yards'].map((data) => YardSimple.fromJson(data)).toList().cast<YardSimple>();
    }
    return [];
  }
}
