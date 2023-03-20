import 'dart:convert';
import 'package:bloc/bloc.dart';
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
      final user = await userService.signIn(email, password);
      if (user != null) {
        var isConfirm = await storage.read(key: 'isConfirm');
        emit(Authenticated(isConfirm: isConfirm == 'true'));
      }
    } catch (e) {
      emit(LoginFailed(error: e.toString()));
    }
    return null;
  }
}
