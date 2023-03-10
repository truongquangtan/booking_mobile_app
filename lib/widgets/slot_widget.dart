import 'package:booking_app_mobile/cubit/booking_slot_cubit.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    if(widget.slot.isBooked) {
      _backgroundColor = Color.fromARGB(255, 232, 173, 173);
    }
  }

  void _onSlotTap() {
    final cubit = BlocProvider.of<BookingSlotsCubit>(context);
    setState(() {
      if (_backgroundColor == Colors.white) {
        cubit.selectOneMoreSlot(widget.slot);
        _backgroundColor = Color.fromARGB(255, 20, 132, 189);
      } else if (_backgroundColor == Color.fromARGB(255, 20, 132, 189)) {
        cubit.unselectedOneSlot(widget.slot);
        _backgroundColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final titleSmall = themeData.textTheme.titleSmall;
    final bodyMedium = themeData.textTheme.bodyMedium;

    return BlocBuilder<BookingSlotsCubit, BookingSlotsState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          widget.slot.isBooked ? null : _onSlotTap();
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
                "${widget.slot.price} VN??",
                style: titleSmall,
              ),
            ],
          ),
        ),
      );
    });
  }
}
