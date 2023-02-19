import 'package:booking_app_mobile/common_components/dropdown.dart';
import 'package:booking_app_mobile/models/dropdown_option.dart';
import 'package:flutter/material.dart';

class DistrictProvinceSelection extends StatefulWidget {
  const DistrictProvinceSelection({Key? key}) : super(key: key);

  @override
  DistrictProvinceSelectionState createState() =>
      DistrictProvinceSelectionState();
}

class DistrictProvinceSelectionState extends State<DistrictProvinceSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Choose location:", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyDropdownButton(options: [
                DropDownOption(displayedValue: "Bình Dương", value: "BD1"),
                DropDownOption(displayedValue: "SGR", value: "SG1")
              ]),
              SizedBox(
                width: 20,
              ),
              MyDropdownButton(options: [
                DropDownOption(displayedValue: "Bình Dương", value: "BD1"),
                DropDownOption(displayedValue: "SGR", value: "SG1")
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
