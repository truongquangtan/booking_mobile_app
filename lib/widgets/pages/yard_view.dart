import 'package:booking_app_mobile/common_components/dropdown.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/booking_slot_cubit.dart';
import 'package:booking_app_mobile/cubit/slots_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_cubit.dart';
import 'package:booking_app_mobile/models/dropdown_option.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:booking_app_mobile/models/yard_model.dart';
import 'package:booking_app_mobile/common_components/date_input.dart';
import 'package:booking_app_mobile/common_components/loading.dart';
import 'package:booking_app_mobile/widgets/slot_widget.dart';
import 'package:booking_app_mobile/common_components/star_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class YardPage extends StatefulWidget {
  final String yardId;

  YardPage(this.yardId, {Key? key}) : super(key: key);

  @override
  State<YardPage> createState() => _YardPageState();
}

class _YardPageState extends State<YardPage> {
  String? dateSelected = DateFormat("dd/MM/yyyy").format(DateTime.now());

  String? subYardId;

  final GlobalKey<DateInputState> dateInputKey = GlobalKey<DateInputState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<YardCubit>(context);
    cubit.getYard(widget.yardId);

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 18.0),
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        backgroundColor: Color.fromARGB(255, 49, 67, 227),
        foregroundColor: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yard detail"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', ModalRoute.withName("/")),
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: BlocBuilder<YardCubit, YardState>(
        builder: (context, state) {
          if (state is InitialYardState) {
            return const Loading();
          } else {
            state as LoadedYardState;

            final yard = state.yard;

            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: Image.network(
                          yard.images.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    _yardDetail(context, yard),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: _getSlotsWidget(context),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: TextButton(
                          onPressed: _onBookClick,
                          style: flatButtonStyle,
                          child: Text("Book"),
                        ))
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _onBookClick() {
    final cubit = BlocProvider.of<BookingSlotsCubit>(context);
    cubit.bookSomeSlots(dateSelected!, widget.yardId);
  }

  BlocBuilder _getSlotsWidget(BuildContext context) {
    return BlocBuilder<SlotsCubit, SlotsState>(
      builder: (context, state) {
        if (state is LoadingSlots) {
          return Loading();
        }

        if (state is LoadedSlots) {
          print("loaded slots outside");
          List<Slot> slots = state.slots;
          if (subYardId == null || dateSelected == null) {
            slots = [];
          }
          return slotWidgetReactiveBuilder(context, slots);
        }

        if (state is SelectedADate) {
          print("select a date state");
          dateSelected = state.date;
          if (subYardId != null) {
            final cubit = BlocProvider.of<SlotsCubit>(context);
            cubit.getSlots(subYardId!, state.date);
          }
        }
        if (state is SelectedASubYard) {
          print("select a subyard state");
          subYardId = state.subYardId;
          if (dateSelected != null) {
            final cubit = BlocProvider.of<SlotsCubit>(context);
            cubit.getSlots(state.subYardId, dateSelected!);
          }
        }

        return slotWidgetReactiveBuilder(context, []);
      },
    );
  }

  Widget slotWidgetReactiveBuilder(BuildContext context, List<Slot> slots) {
    return BlocBuilder<BookingSlotsCubit, BookingSlotsState>(
      builder: (context, state) {
        if (state.isJustBooked) {
          print("just booked");
          final bookingCubit = BlocProvider.of<BookingSlotsCubit>(context);
          bookingCubit.removeJustBookedMark();
          final cubit = BlocProvider.of<SlotsCubit>(context);
          cubit.getSlots(subYardId!, dateSelected!);
        }

        if (state.error != '') {
          // toast error
        }
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _slotsWidget(context, slots),
        );
      }
    );
  }

  List<Widget> _slotsWidget(BuildContext context, List<Slot> slots) {
    List<Widget> items = [];

    for (Slot slot in slots) {
      items.add(SlotWidget(slot: slot, key: Key(slot.id.toString())));
    }

    return items;
  }

  Padding _yardDetail(BuildContext context, Yard yard) {
    final themeData = Theme.of(context);
    final titleMedium = themeData.textTheme.titleMedium;
    final headlineSmall = themeData.textTheme.headlineSmall;
    final boldHeadlineSmall =
        headlineSmall?.copyWith(fontWeight: FontWeight.bold);
    final options = yard.subYards
        .map((subYard) => DropDownOption(
            displayedValue: '${subYard.name} - [${subYard.typeYard}]',
            value: subYard.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(yard.name, style: boldHeadlineSmall)),
              StarRatingBar(
                rating: yard.score / 20,
                size: 24.0,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 24.0,
                    color: themeData.colorScheme.primary,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      yard.address,
                      style: titleMedium,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_clock,
                    size: 24.0,
                    color: themeData.colorScheme.primary,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '${yard.openAt} - ${yard.closeAt}',
                    style: titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border(top: BorderSide(width: 0.5))),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    Center(
                      child: Text("Select date and sub-yard to get slots:",
                          style: themeData.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DateInput(
                          key: dateInputKey,
                          restorationId: 'main',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("0xff0000ff"))
                                    .withAlpha(20)),
                            child: MyDropdownButton(
                              options: options,
                              forSpecificType: SUB_YARD,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
