import 'dart:convert';

import 'package:booking_app_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserService {
  final String apiUrl;
  final String jwtSecret;

  UserService({required this.apiUrl, required this.jwtSecret});

  Future<String?> signUp(String email, String password, String? confirmPassword) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      body: {'email': email, 'password': password, 'confirmPassword': confirmPassword},
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<String?> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<User> getUser(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<bool> verifyPassword(String password, String hashedPassword) {
    return  FlutterBcrypt.verify(password: password, hash: hashedPassword);
  }

  Future<String> hashPassword(String password) {
    return FlutterBcrypt.hashPw(password: password, salt: '12');
  }

  // String generateToken(User user) {
  //   final jwt = JWT({
  //     'iss': 'your_issuer_name',
  //     'sub': user.id,
  //     'email': user.email,
  //     'exp': DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch ~/ 1000
  //   });
  //   return JWT.verify(jwt);
  // }

  Map<String, dynamic> decodeToken(String token) {
    final jwt = JWT.verify(token, SecretKey(jwtSecret));
    return jwt.payload;
  }
}
