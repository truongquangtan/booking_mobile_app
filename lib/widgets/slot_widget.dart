import 'package:booking_app_mobile/models/slot.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotWidget extends StatefulWidget {
  final Slot slot;

  const SlotWidget({
    required this.slot,
    Key? key,
  }) : super(key: key);

  @override
  SlotState createState() => SlotState();
}

class SlotState extends State<SlotWidget> {
  Color _backgroundColor = Colors.white;

  void _changeColor() {
    setState(() {
      if(_backgroundColor == Colors.white){
        _backgroundColor = Color.fromARGB(255, 20, 132, 189);
      } else if(_backgroundColor == Color.fromARGB(255, 20, 132, 189)){
        _backgroundColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final titleSmall = themeData.textTheme.titleSmall;
    final bodyMedium = themeData.textTheme.bodyMedium;

    return GestureDetector(
      onTap: () {
        _changeColor();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: _backgroundColor,
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${widget.slot.startTime} - ${widget.slot.endTime}",
                    style: titleSmall,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              "${widget.slot.price} VNĐ",
              style: titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
