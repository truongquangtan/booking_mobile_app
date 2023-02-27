import 'package:booking_app_mobile/common_components/dropdown.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/districts_provinces_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_list_cubit.dart';
import 'package:booking_app_mobile/models/dropdown_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictProvinceSelection extends StatefulWidget {
  const DistrictProvinceSelection({Key? key}) : super(key: key);

  @override
  DistrictProvinceSelectionState createState() =>
      DistrictProvinceSelectionState();
}

class DistrictProvinceSelectionState extends State<DistrictProvinceSelection> {
  List<DropDownOption> districtOptions = [];
  List<DropDownOption> provinceOptions = [];
  int? provinceIdSelected;
  int? districtIdSelected;

  @override
  Widget build(BuildContext context) {
    final selectionCubit = BlocProvider.of<DistrictAndProvinceCubit>(context);
    selectionCubit.getAllProvinces();

    return BlocBuilder<DistrictAndProvinceCubit, DistrictsAndProvincesState>(
      builder: (context, state) {

        if (state is LoadedProvincesState) {
          provinceOptions = state.provinces.map( (p) => DropDownOption(displayedValue: p.provinceName, value: p.id.toString())).toList();
        }

        if (state is LoadedDistrictsState) {
          districtOptions = state.districts.map( (d) => DropDownOption(displayedValue: d.disctrictName, value: d.id.toString())).toList();
        }

        if (state is SelectedAProvince) {
          provinceIdSelected = state.provinceId;
          districtOptions = [];
          selectionCubit.getDistricts(provinceIdSelected!);

          // And load yard
          final yardListCubit = BlocProvider.of<YardListCubit>(context);
          yardListCubit.getYardList(provinceIdSelected.toString(), null);
        }

        if (state is SelectedADistrict) {
          districtIdSelected = state.districtId;

          // load yard
          final yardListCubit = BlocProvider.of<YardListCubit>(context);
          yardListCubit.getYardList(provinceIdSelected.toString(), districtIdSelected.toString());
        }

        return _reactiveBuild();
      }
    );
  }

  Widget _reactiveBuild(){
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Province: '),
                  MyDropdownButton(options: provinceOptions, forSpecificType: PROVINCE,),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('District: '),
                  MyDropdownButton(options: districtOptions, forSpecificType: DISTRICT),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
