import 'package:booking_app_mobile/models/yard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class YardCubit extends Cubit<YardState> {
  final Service service = getIt<Service>();

  YardCubit() : super(const InitialYardState());

  void getYard(String yardId) async {
    final yard = await service.getYard(yardId);

    emit(LoadedYardState(yard!));
  }
}

@immutable
abstract class YardState extends Equatable {
  const YardState();
}

class InitialYardState extends YardState {
  const InitialYardState();

  @override
  List<Object?> get props => [];
}

class LoadedYardState extends YardState {
  final Yard yard;

  const LoadedYardState(this.yard);

  @override
  List<Object?> get props => [yard];
}