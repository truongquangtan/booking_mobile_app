import 'package:booking_app_mobile/models/district.dart';
import 'package:booking_app_mobile/models/province.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class DistrictAndProvinceCubit extends Cubit<DistrictsAndProvincesState> {
  final Service service = getIt<Service>();

  DistrictAndProvinceCubit() : super(const InitialDistrictsAndProvices());

  // districts
  void getDistricts(int provinceId) async {
    emit(LoadingDistrictsState());

    final districts = await service.getDistrictByProvince(provinceId);

    emit(LoadedDistrictsState(districts));
  }
  void selectDistrict(int districtId) async {
    emit(SelectedADistrict(districtId));
  }

  // provinces
  void getAllProvinces() async {
    emit(LoadingProvincesState());

    final provinces = await service.getAllProvinces();

    emit(LoadedProvincesState(provinces));
  }
  void selectProvince(int provinceId) {
    emit(SelectedAProvince(provinceId));
  }
}

@immutable
abstract class DistrictsAndProvincesState extends Equatable {
  const DistrictsAndProvincesState();
}

// General
class InitialDistrictsAndProvices extends DistrictsAndProvincesState {
  const InitialDistrictsAndProvices();

  @override
  List<Object?> get props => [];
}

// District
class InitialDistrictsState extends DistrictsAndProvincesState {
  const InitialDistrictsState();

  @override
  List<Object?> get props => [];

}

class LoadingDistrictsState extends DistrictsAndProvincesState {
  const LoadingDistrictsState();

  @override
  List<Object?> get props => [];
}

class LoadedDistrictsState extends DistrictsAndProvincesState {
  final List<District> districts;

  const LoadedDistrictsState(this.districts);

  @override
  List<Object?> get props => [districts];
}

class SelectedADistrict extends DistrictsAndProvincesState {
  final int districtId;

  const SelectedADistrict(this.districtId);

  @override
  List<Object?> get props => [districtId];
}

//-----------------------------------------------------------------------------------

// Provinces
class InitialProvincesState extends DistrictsAndProvincesState {
  const InitialProvincesState();

  @override
  List<Object?> get props => [];

}

class LoadingProvincesState extends DistrictsAndProvincesState {
  const LoadingProvincesState();

  @override
  List<Object?> get props => [];
}

class LoadedProvincesState extends DistrictsAndProvincesState {
  final List<Province> provinces;

  const LoadedProvincesState(this.provinces);

  @override
  List<Object?> get props => [provinces];
}

class SelectedAProvince extends DistrictsAndProvincesState {
  final int provinceId;

  const SelectedAProvince(this.provinceId);

  @override
  List<Object?> get props => [provinceId];

}