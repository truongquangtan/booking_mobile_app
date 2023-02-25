import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:flutter/material.dart';

class YardInfo extends StatelessWidget {
  final YardSimple yard;

  const YardInfo({Key? key, required this.yard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(yard.name, style: const TextStyle(fontSize: 24, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}
