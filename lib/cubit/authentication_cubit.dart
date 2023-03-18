import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:booking_app_mobile/cubit/authentication_state.dart';
import 'package:booking_app_mobile/service/user_service.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {

  final UserService userService;

  AuthenticationCubit({required this.userService}) : super(Unauthenticated());

  Future<void> login(String email, String password) async {
    try {
      // call the user service to check the user credentials
      final user = await userService.signIn(email, password);

      // generate the JWT token
      // final jwt = _generateJwt(email);

      // generate the bcrypt hash of the password
      final bcrypt = _generateBcryptHash(password);

      // store the JWT and bcrypt hash in the state
      emit(Authenticated(bcrypt: bcrypt));
    } catch (e) {
      emit(LoginFailed(error: e.toString()));
    }
  }

  String _generateBcryptHash(String password) {
    final hash =   FlutterBcrypt.hashPw(password: password, salt: '12').toString();

    return hash;
  }
}
final userService = UserService(apiUrl: 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1', jwtSecret: 'my_secret_key');
final authenticationCubit = AuthenticationCubit(userService: userService);
