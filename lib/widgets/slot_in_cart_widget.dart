import 'package:booking_app_mobile/cubit/booking_slot_cubit.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SlotInCartWidget extends StatefulWidget {
  final Slot slot;

  const SlotInCartWidget({
    required this.slot,
    Key? key,
  }) : super(key: key);

  @override
  SlotInCartState createState() => SlotInCartState();
}

class SlotInCartState extends State<SlotInCartWidget> {
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  void _onSlotTap() {
    final cubit = BlocProvider.of<BookingSlotsCubit>(context);
    cubit.unselectedOneSlot(widget.slot);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final titleSmall = themeData.textTheme.titleSmall;

    final currencyFormat =
        NumberFormat.currency(locale: 'vi-VN', symbol: 'đ', decimalDigits: 0);
    final currencyDisplay = currencyFormat.format(widget.slot.price);

    return BlocBuilder<BookingSlotsCubit, BookingSlotsState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                    "${widget.slot.startTime} - ${widget.slot.endTime} [${widget.slot.refSubYard.split("-")[0]}]",
                    style: titleSmall,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              currencyDisplay,
              style: titleSmall,
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () {
                _onSlotTap();
              },
              child: AnimatedContainer(
                  padding: EdgeInsets.all(5),
                  duration: Duration(milliseconds: 300),
                  child: Center(
                      child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))),
            )
          ],
        ),
      );
    });
  }
}
