import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/authentication_state.dart';
import 'package:booking_app_mobile/service/user_service.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthenticationCubit extends Cubit<AuthenticationState> {

  final UserService userService;

  AuthenticationCubit({required this.userService}) : super(Unauthenticated());

  Future<void> login(String email, String password) async {
    try {
      // call the user service to check the user credentials
      //final storage = FlutterSecureStorage();
      await userService.signIn(email, password);
      //var isConfirm = await storage.read(key: IS_CONFIRM_STORAGE_KEY);
      var isConfirm = IS_CONFIRM_VALUE; 
      emit(Authenticated(isConfirm: isConfirm == 'true'));
    } catch (e) {
      emit(LoginFailed(error: e.toString()));
      rethrow;
    }
  }

  Future<bool> register(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
    try {
      // call the user service to check the user credentials
      return await userService.register(email, password, confirmPassword, fullname, phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(String otp, String? jwtToken) async {
    try {
      return await userService.verifyOtp(otp, jwtToken);
    } catch(e) {
      print('a $e');
      rethrow;
    }
  }

  Future<void> resendOtp(String? jwtToken) async {
    await userService.resendOtp(jwtToken);
  }

  Future<void> logout(String? token) async {
    try {
      return await userService.logout(token);
    }
    catch (e) {
      rethrow;
    }
  }
}
