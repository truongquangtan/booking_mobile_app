import 'package:booking_app_mobile/models/subyard_model.dart';
import 'dart:convert';

class Yard {
  final String id;
  final String name;
  final String address;
  final String districtName;
  final String openAt;
  final String closeAt;
  final int score;
  final List<String> images;
  final List<SubYard> subYards;

  Yard(this.id, this.name, this.address, this.districtName, this.openAt, this.closeAt, this.score, this.images, this.subYards);

  factory Yard.fromJson(Map<String, dynamic> jsonInput) {
    String jsonString = jsonEncode(jsonInput['subYards']);
    List<dynamic> jsonList = json.decode(jsonString);
    List<SubYard> subYardList = jsonList.map((json) => SubYard.fromJson(json)).toList();

    jsonString = jsonEncode(jsonInput['images']);
    List<dynamic> imagesDynamic = json.decode(jsonString);
    List<String> imagesString = imagesDynamic.map((str) => str as String).toList();

    int score = jsonInput['score'] as int;

    return Yard(
      jsonInput['id'], 
      jsonInput['name'], 
      jsonInput['address'], 
      jsonInput['districtName'], 
      jsonInput['openAt'],
      jsonInput['closeAt'],
      score,
      imagesString,
      subYardList,
    );
  }
}