import 'package:booking_app_mobile/common_components/dropdown.dart';
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

class YardPage extends StatelessWidget {
  final String yardId;
  final GlobalKey<DateInputState> dateInputKey = GlobalKey<DateInputState>();

  YardPage(this.yardId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<YardCubit>();
    //final cubit = BlocProvider.of<PlaceDetailCubit>(context);
    cubit.getYard(yardId);

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _menuCategories(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _menuCategories(BuildContext context) {
    List<Widget> items = [];

    Slot slot = Slot(1000, 'abc', 500, '8:00', '9:00', false);

    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );
    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );
    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );
    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );
    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );
    items.add(
      SlotWidget(slot: slot, key: UniqueKey()),
    );

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
              Center(child: Text(yard.name, style: boldHeadlineSmall)),
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
                          height: 40,alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("0xff0000ff"))
                                    .withAlpha(20)),
                            child: MyDropdownButton(
                              options: options,
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
