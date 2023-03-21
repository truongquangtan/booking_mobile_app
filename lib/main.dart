import 'dart:convert';

import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:booking_app_mobile/common_components/date_input.dart';
import 'package:booking_app_mobile/widgets/pages/home_view.dart';
import 'package:booking_app_mobile/widgets/pages/login.dart';
import 'package:booking_app_mobile/widgets/pages/signup.dart';
import 'package:booking_app_mobile/widgets/pages/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:booking_app_mobile/widgets/pages/list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/bloc_providers.dart';
import 'package:flutter/services.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.getProviders,
      child: MaterialApp(
        title: 'Basketball Yard Booking System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: LoginScreen.routeName, // Set the initial route
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          VerifyOtpPage.routeName: (context) => VerifyOtpPage(),
          MyHomePage.routeName: (context) => const MyHomePage(title: 'Basketball Yard Booking System'),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  static const String routeName = "/home";

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  int _counter = 0;
  final GlobalKey<ListPageState> listStateKey = GlobalKey<ListPageState>();
  final GlobalKey<DateInputState> dateInputKey = GlobalKey<DateInputState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        HomePage(key: UniqueKey()),
        ListPage(
          key: listStateKey,
        ),
      ]),
      bottomNavigationBar:
          buildBottomAppBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildBottomAppBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: Color.fromARGB(226, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(223, 22, 21, 21),
      selectedItemColor: Color.fromARGB(223, 41, 47, 242),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Book'),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm), label: 'Incoming'),
      ],
    );
  }
}
