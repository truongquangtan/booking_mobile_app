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
      final storage = FlutterSecureStorage();
      await userService.signIn(email, password);
      var isConfirm = await storage.read(key: IS_CONFIRM_STORAGE_KEY);
      emit(Authenticated(isConfirm: isConfirm == 'true'));
    } catch (e) {
      emit(LoginFailed(error: e.toString()));
      rethrow;
    }
    return null;
  }
}
