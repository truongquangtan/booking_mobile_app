import 'dart:convert';
import 'package:booking_app_mobile/models/booking_request.dart';
import 'package:booking_app_mobile/models/booking_response.dart';
import 'package:booking_app_mobile/models/district.dart';
import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:booking_app_mobile/models/province.dart';
import 'package:booking_app_mobile/models/slot.dart';
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

  Future<List<Slot>> getSlots(String subYardId, String date) async {
    final uri = 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1/sub-yards/$subYardId/slots';
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'date': date,
      }),
    );
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      return data['data'].map((data) => Slot.fromJson(data)).toList().cast<Slot>();
    }
    return [];
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

  Future<List<IncomingMatch>> getIncomingMatch(String authToken) async {
    const uri = 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1/me/incoming-matches';
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': authToken,
      },
      body: jsonEncode(<String, dynamic>{
      'itemsPerPage': 1000,
      'page': 1,
      }),
    );
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      return data['data'].map((data) => IncomingMatch.fromJson(data)).toList().cast<IncomingMatch>();
    }
    return [];
  }

  Future<BookingGeneralResponse> book(String authToken, String yardId, List<Slot> slots, String date) async {
    final uri = 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1/yards/$yardId/booking';

    final slotsBookingRequest = slots.map((e) => BookingRequest.genSimpleRequestFromSlot(e, date)).toList().cast<BookingRequest>();

    final requestBody = jsonEncode(<String, dynamic>{
      'bookingList': slotsBookingRequest,
    });

    print('request body: $requestBody');
    print('authToken: $authToken');

    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': authToken,
      },
      body: requestBody,
    );

    print('get status code: ${response.statusCode}');
    print('and body: ${response.body}');

    if(response.statusCode == 200) {
      final data = await json.decode(response.body);
      return BookingGeneralResponse(!(data['isError'] as bool), data['message'] as String);
    }

    return BookingGeneralResponse(false, 'Something went wrong');
  }
}
