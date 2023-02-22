import 'dart:convert';

class YardSimple {
  final String id;
  final String name;
  final String address;
  final String districtName;
  final String openAt;
  final String closeAt;
  final int score;
  final List<String> images;

  YardSimple(this.id, this.name, this.address, this.districtName, this.openAt, this.closeAt, this.score, this.images);

  factory YardSimple.fromJson(Map<String, dynamic> jsonInput) {
    String jsonString = jsonEncode(jsonInput['images']);
    List<dynamic> imagesDynamic = json.decode(jsonString);
    List<String> imagesString = imagesDynamic.map((str) => str as String).toList();

    int score = jsonInput['score'] as int;

    return YardSimple(
      jsonInput['id'], 
      jsonInput['name'], 
      jsonInput['address'], 
      jsonInput['districtName'], 
      jsonInput['openAt'],
      jsonInput['closeAt'],
      score,
      imagesString,
    );
  }
}