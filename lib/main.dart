import 'dart:convert';

import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:booking_app_mobile/common_components/date_input.dart';
import 'package:booking_app_mobile/widgets/pages/home_view.dart';
import 'package:booking_app_mobile/widgets/pages/login.dart';
import 'package:booking_app_mobile/widgets/pages/sign_up.dart';
import 'package:booking_app_mobile/widgets/pages/yard_view.dart';
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

Future<void> readJson() async {
  final String response =
      await rootBundle.loadString('assets/sampleSlot.json');
  
  final data = await json.decode(response);
  Slot slot = Slot.fromJson(data);
  print(slot.price);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.getProviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

    //readJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        HomePage(key: UniqueKey()),
        YardPage('87e4a35e-5f39-4d0c-b9d5-3a544fb550ca'),
        ListPage(
          key: listStateKey,
        ),
        LoginScreen(),
        SignUpScreen()
      ]),
      bottomNavigationBar:
          buildBottomAppBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Center incomingScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Incoming screen',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            '$_currentIndex',
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () => showMessage(), child: Text("Click me"))
        ],
      ),
    );
  }

  void showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Selected: ${dateInputKey.currentState?.selectedDate.value.day}'),
    ));
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
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Book'),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm), label: 'Incoming'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Login'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Signup'),
      ],
    );
  }
}
