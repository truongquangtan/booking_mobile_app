import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class YardListCubit extends Cubit<YardListState> {
  final Service service = getIt<Service>();

  YardListCubit() : super(const LoadingYardListState());

  void getYardList(String? provinceId, String? districtId) async {
    emit(LoadingYardListState());

    final yards = await service.getYardList(provinceId, districtId);

    emit(LoadedYardListState(yards));
  }
}

@immutable
abstract class YardListState extends Equatable {
  const YardListState();
}

class LoadingYardListState extends YardListState {
  const LoadingYardListState();

  @override
  List<Object?> get props => [];
}

class LoadedYardListState extends YardListState {
  final List<YardSimple> yards;

  const LoadedYardListState(this.yards);

  @override
  List<Object?> get props => [yards];
}