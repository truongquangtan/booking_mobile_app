import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class YardListStaticCubit extends Cubit<YardListStaticState> {
  final Service service = getIt<Service>();

  YardListStaticCubit() : super(const LoadingYardListStaticState());

  void getYardList(String? provinceId, String? districtId) async {
    emit(LoadingYardListStaticState());

    final yards = await service.getYardList(provinceId, districtId);

    emit(LoadedYardListStaticState(yards));
  }
}

@immutable
abstract class YardListStaticState extends Equatable {
  const YardListStaticState();
}

class LoadingYardListStaticState extends YardListStaticState {
  const LoadingYardListStaticState();

  @override
  List<Object?> get props => [];
}

class LoadedYardListStaticState extends YardListStaticState {
  final List<YardSimple> yards;

  const LoadedYardListStaticState(this.yards);

  @override
  List<Object?> get props => [yards];
}