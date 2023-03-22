import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/authentication_cubit.dart';
import 'package:booking_app_mobile/main.dart';
import 'package:booking_app_mobile/widgets/pages/login.dart';
import 'package:booking_app_mobile/widgets/pages/verify_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_components/login_form.dart';
import '../../main.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleRegisterForm(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
      print("checkin handleLoginForm");
      var isSignup = await cubit.register(email, password, confirmPassword, fullname, phoneNumber);
      if (isSignup) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/stephen-baker-QAX5Ylx-lKo-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFF7A00).withOpacity(0.2),
                      Color(0xFF1F0F00).withOpacity(0.2),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Container(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Basketball Playground',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: LoginForm(
                            buttonText: "Sign up",
                            isSignup: true,
                            onSubmit: (email, password, confirmPassword, fullName, phoneNumber) {
                              handleRegisterForm(email, password, confirmPassword, fullName, phoneNumber);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text.rich(
                      TextSpan(
                        text: "Have your account, ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'sign in here',
                            style: TextStyle(
                              color: Color(0xFFFF7A00),
                              fontSize: 12.0,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              // Add other widgets here, such as text or buttons
            ],
          ),
        ));
  }
}
