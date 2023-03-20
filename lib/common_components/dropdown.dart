import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/districts_provinces_cubit.dart';
import 'package:booking_app_mobile/cubit/slots_cubit.dart';
import 'package:booking_app_mobile/models/dropdown_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class MyDropdownButton extends StatefulWidget {
  final String? forSpecificType;
  final List<DropDownOption> options;
  MyDropdownButton({super.key, required this.options, this.forSpecificType});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String? dropdownValue;

  @override
  void initState(){
    super.initState();
    dropdownValue = null;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.options.where((element) => element.value == dropdownValue).isEmpty) {
      dropdownValue = null;
    }
    return SizedBox(
      width: 200,
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: null,
        elevation: 16,
        underline: null,
        isDense: true,
        onChanged: (String? value) {
          setState(() {
            // Emit state change event
            if(widget.forSpecificType == PROVINCE) {
              final selectionCubit = BlocProvider.of<DistrictAndProvinceCubit>(context);
              selectionCubit.selectProvince(int.parse(value!));
            }
            
            // Emit state change event
            if(widget.forSpecificType == DISTRICT) {
              final selectionCubit = BlocProvider.of<DistrictAndProvinceCubit>(context);
              selectionCubit.selectDistrict(int.parse(value!));
            }

            // Emit state change event
            if(widget.forSpecificType == SUB_YARD) {
              final slotsCubit = BlocProvider.of<SlotsCubit>(context);
              slotsCubit.selectSubYard(value!);
            }

            dropdownValue = value;
          });
        },
        onTap: null,
        items: widget.options.map<DropdownMenuItem<String>>((DropDownOption option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Text(option.displayedValue),
          );
        }).toList(),
      ),
    );
  }
}