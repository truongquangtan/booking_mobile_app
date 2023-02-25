import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class IncomingMatchCubit extends Cubit<IncomingMatchState> {
  final Service service = getIt<Service>();

  IncomingMatchCubit() : super(const LoadingIncomingMatchesState());

  void getIncomingMatches(String? authToken) async {
    emit(LoadingIncomingMatchesState());

    final incomingMatches = await service.getIncomingMatch
    ('Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxZTc3OTQ4OC1kMTU1LTRjYmEtYWVkNS1lNGZkNzMzYWY1MzEiLCJmdWxsTmFtZSI6IlRydW9uZyBRdWFuZyBUYW4iLCJlbWFpbCI6InRydW9uZ3F1YW5ndGFuMjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjA4NDQxMTEwMDEiLCJyb2xlIjoidXNlciIsImlzQ29uZmlybWVkIjp0cnVlLCJpYXQiOjE2NzczNDA2NDQsImV4cCI6MTY3OTA2ODY0NH0.FrFqZkQECrQSavqiUQSX47usxzUv0TewgvsZ_xv-9VvgTPvtBNmta0uXGH6xvRdFa5E7U9QcUO9BCpahv5ZdCQ');

    emit(LoadedIncomingMatchesState(incomingMatches));
  }
}

@immutable
abstract class IncomingMatchState extends Equatable {
  const IncomingMatchState();
}

class LoadingIncomingMatchesState extends IncomingMatchState {
  const LoadingIncomingMatchesState();

  @override
  List<Object?> get props => [];
}

class LoadedIncomingMatchesState extends IncomingMatchState {
  final List<IncomingMatch> incomingMatches;

  const LoadedIncomingMatchesState(this.incomingMatches);

  @override
  List<Object?> get props => [incomingMatches];
}