import 'package:booking_app_mobile/widgets/calendarView.dart';
import 'package:booking_app_mobile/widgets/dateInput.dart';
import 'package:booking_app_mobile/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:booking_app_mobile/widgets/listView.dart';
import 'package:booking_app_mobile/widgets/city_card.dart';
import 'package:booking_app_mobile/models/city_model.dart';
import 'package:booking_app_mobile/widgets/content_title.dart';
import 'package:booking_app_mobile/constant/values.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Widget build(BuildContext context) {
    print(listStateKey.currentState?.incomingMatchList.length);
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        HomePage(key: UniqueKey()),
        DateInput(
          key: dateInputKey,
          restorationId: 'main',
        ),
        ListPage(
          key: listStateKey,
        ),
        incomingScreen(context),
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
          ElevatedButton(onPressed: () => showMessage(), child: Text("Click me"))
        ],
      ),
    );
  }

  void showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Selected: ${dateInputKey.currentState?.selectedDate.value.day}'),
    ));
  }

  Widget buildBottomAppBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          print(listStateKey.currentState?.incomingMatchList.length);
        });
      },
      backgroundColor: Color.fromARGB(226, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(223, 22, 21, 21),
      selectedItemColor: Color.fromARGB(223, 41, 47, 242),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Book'),
        BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm), label: 'Incoming'),
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Incoming'),
      ],
    );
  }
}
