import 'package:booking_app_mobile/models/dropdown_option.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class MyDropdownButton extends StatefulWidget {
  final List<DropDownOption> options;
  const MyDropdownButton({super.key, required this.options});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String dropdownValue;

  @override
  void initState(){
    super.initState();
    dropdownValue = widget.options.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: null,
      elevation: 16,
      underline: null,
      isDense: true,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.options.map<DropdownMenuItem<String>>((DropDownOption option) {
        return DropdownMenuItem<String>(
          value: option.value,
          child: Text(option.displayedValue),
        );
      }).toList(),
    );
  }
}