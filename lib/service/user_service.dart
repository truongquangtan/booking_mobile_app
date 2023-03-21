import 'dart:convert';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:booking_app_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserService {
  final String apiUrl;
  final String jwtSecret;

  UserService({required this.apiUrl, required this.jwtSecret});
  Future<bool> register(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String> {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'fullName': fullname,
        'phone': phoneNumber,
      }
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to sign in');
    }
  }
  Future<void> signIn(String email, String password) async {

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
        await storage.write(key: JWT_STORAGE_KEY, value: data['token'].toString());
        await storage.write(key: IS_CONFIRM_STORAGE_KEY, value: data['isConfirm'].toString());
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
  Future<void> resendOtp(String? jwtToken) async {
    final response = await http.get(
      Uri.parse('$apiUrl/verify-account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to verify');
    }
  }
  Future<bool> verifyOtp(String otp, String? jwtToken) async {
    print('otp tai service $otp');
    final response = await http.post(
      Uri.parse('$apiUrl/verify-account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $jwtToken',
      },
      body:jsonEncode(<String, String> {
        'otpCode': otp,
      }
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to verify');
    }
  }
  Future<void> logout(String? token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
      );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to verify');
    }
  }

  Future<String> hashPassword(String password) {
    return FlutterBcrypt.hashPw(password: password, salt: '12');
  }

  Map<String, dynamic> decodeToken(String token) {
    final jwt = JWT.verify(token, SecretKey(jwtSecret));
    return jwt.payload;
  }
}
