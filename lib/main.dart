import 'package:booking_app_mobile/widgets/calendarView.dart';
import 'package:booking_app_mobile/widgets/dateInput.dart';
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(listStateKey.currentState?.incomingMatchList.length);
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          buildHomePage(),
          DateInput(restorationId: 'main',),
          //historyScreen(context),
          ListPage(key: listStateKey,),
          incomingScreen(context),
        ]
        ),
      bottomNavigationBar: buildBottomAppBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Center bookingScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            '$_currentIndex',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Center historyScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'History screen',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            '$_currentIndex',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
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
        ],
      ),
    );
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
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: 'Incoming'),
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Incoming'),
      ],
    );
  }

  Widget buildHomePage() {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15,),
              const Text('What you would like to find??', style: headerStyle),
              const SizedBox(height: 10),
              const ContentTitle(title: 'Top Rating Yards'),
              buildCityList(),
              const ContentTitle(title: 'Nearby Yards'),
              buildCityList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCityList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: kCitiesList.length,
        itemBuilder: (BuildContext context, int index) {
          return CityCard(city: kCitiesList[index]);
        },
      ),
    );
  }
}
