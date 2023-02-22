import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:flutter/material.dart';

class CityInfo extends StatelessWidget {
  final YardSimple yard;

  const CityInfo({Key? key, required this.yard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(yard.name, style: const TextStyle(fontSize: 24, color: Colors.white)),
          Row(
            children: <Widget>[
              const Icon(Icons.flight_takeoff, color: Colors.white, size: 14),
              const SizedBox(width: 8),
              Text(yard.address, style: const TextStyle(fontSize: 14, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
