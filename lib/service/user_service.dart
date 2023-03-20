import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:booking_app_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserService {
  final String apiUrl;
  final String jwtSecret;

  UserService({required this.apiUrl, required this.jwtSecret});

  Future<String> signIn(String email, String password) async {

    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String> {
        'username': email,
        'password': password,
      }
      ),
    );

    if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        final storage = FlutterSecureStorage();
        await storage.write(key: 'jwt', value: data.token);
        await storage.write(key: 'isConfirm', value: data.isConfirm);
        return data;
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

  Map<String, dynamic> decodeToken(String token) {
    final jwt = JWT.verify(token, SecretKey(jwtSecret));
    return jwt.payload;
  }
}
