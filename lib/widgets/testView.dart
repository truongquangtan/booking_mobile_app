import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TestScreenState();
  }
}

class _TestScreenState extends State<TestScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
  }

  // Hiển thị DatePicker
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1950, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    children: <Widget>[
      Text(
        'Selected date: ${selectedDate.toString()}',
        style: TextStyle(fontSize: 20),
      ),
      ElevatedButton(
        child: Text('Open Date Picker'),
        onPressed: _showDatePicker,
      ),
    ],
  );
  }
}
