import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/authentication_cubit.dart';
import 'package:booking_app_mobile/main.dart';
import 'package:booking_app_mobile/widgets/pages/signup.dart';
import 'package:booking_app_mobile/widgets/pages/verify_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_components/login_form.dart';
import '../../main.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleLoginFormSubmit(String email, String password) async {
      print("checkin handleLoginForm");
      await cubit.login(email, password);
      final storage = FlutterSecureStorage();
      var isConfirm = await storage.read(key: IS_CONFIRM_STORAGE_KEY);
      var token = await storage.read(key: JWT_STORAGE_KEY);
      await cubit.resendOtp(token);
      if (isConfirm == 'true') {
        print(isConfirm);
        Navigator.pushReplacementNamed(context, MyHomePage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, VerifyOtpPage.routeName);
      }
    }
    void _launchUrl(String url) async {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
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
          SizedBox(),
          Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              Container(
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Hola!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Now you know how to say hi in Spain!',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60, bottom: 40),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Basketball Playground',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
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
                        buttonText: "Sign in",
                        onSubmit: (email, password, value, value2, value3) {
                          handleLoginFormSubmit(email, password);
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
                    text: "Didn't have any account, ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'sign up here',
                        style: TextStyle(
                          color: Color(0xFFFF7A00),
                          fontSize: 12.0,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, SignupScreen.routeName);
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
