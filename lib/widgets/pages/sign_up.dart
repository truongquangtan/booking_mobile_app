import 'package:booking_app_mobile/common_components/logo_icon.dart';
import 'package:booking_app_mobile/widgets/pages/home_view.dart';
import 'package:booking_app_mobile/widgets/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import '../../common_components/login_form.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';

  void handleSignupFormSubmit(String email, String password) {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    String email = 'example@email.com';
    String password = 'password123';
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
                margin: EdgeInsets.only(top: 60, bottom: 80),
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
                        buttonText: "Sign up",
                        onSubmit: (email, password) {
                          handleSignupFormSubmit(email, password);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text.rich(
                  TextSpan(
                    text: "If you have account, ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: [
                    SocialMediaCard(
                      icon: Icons.apple,
                      iconColor: Colors.black,
                    ),
                    SocialMediaCard(
                      icon: Icons.facebook,
                      iconColor: Colors.blue,
                    ),
                    SocialMediaCard(
                      icon: FontAwesomeIcons.google,
                    )
                  ],
                ),
              )
            ],
          )

          // Add other widgets here, such as text or buttons
        ],
      ),
    ));
  }
}
