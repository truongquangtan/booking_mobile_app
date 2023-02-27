import 'package:booking_app_mobile/cubit/slots_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  const DateInput({super.key, this.restorationId});

  final String? restorationId;

  @override
  DateInputState createState() => DateInputState();
}

class DateInputState extends State<DateInput> with RestorationMixin {
  //define state
  DateTime dateValue = DateTime.now();

  @override
  void initState() {
    super.initState();
    //init code here
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 40,
        child: GestureDetector(
          onTap: () {
            //_showDialog(incomingMatch: incomingMatch);
            print("tap");
            _restorableDatePickerRouteFuture.present();
          },
          child: AnimatedContainer(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(int.parse("0xff0000ff")).withAlpha(20)),
              duration: Duration(milliseconds: 300),
              child: Center(
                child: Text(DateFormat("dd/MM/yyyy").format(selectedDate.value)),
              )),
        ),
      ),
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime selectedDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime(2048),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      // Emit state change event
      final slotsCubit = BlocProvider.of<SlotsCubit>(context);
      slotsCubit.selectDate(DateFormat("dd/MM/yyyy").format(newSelectedDate));

      // And setState
      setState(() {
        selectedDate.value = newSelectedDate;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}'),
        // ));
      });
    }
  }

}
