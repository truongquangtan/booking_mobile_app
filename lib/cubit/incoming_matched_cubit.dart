import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class IncomingMatchCubit extends Cubit<IncomingMatchState> {
  final Service service = getIt<Service>();

  IncomingMatchCubit() : super(const LoadingIncomingMatchesState());

  void getIncomingMatches() async {
    emit(LoadingIncomingMatchesState());

    const authToken = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzODMxN2ZmMy03NjI2LTQ2MWYtOGUyMy0xMGE1MjExNGY0NGEiLCJmdWxsTmFtZSI6IlRyxrDGoW5nIFF1YW5nIFTDom4iLCJlbWFpbCI6InF1YW5ndGFuOWJnbUBnbWFpbC5jb20iLCJwaG9uZSI6IjA4NDQxMTEyMjIiLCJyb2xlIjoidXNlciIsImlzQ29uZmlybWVkIjp0cnVlLCJpYXQiOjE2NzkzNTM4MTEsImV4cCI6MTY4MTA4MTgxMX0.Wp73evwjlkAlWLETNkVLCb4FY4QaTSkPub8N26Zyi5b_70IH9LfWGYVf_jpMmQtWuY8CbnTKXdHyvaDrVNzdwQ';

    final incomingMatches = await service.getIncomingMatch(authToken);

    emit(LoadedIncomingMatchesState(incomingMatches));
  }

  void cancelMatch(String bookingId) async {
    emit(LoadingIncomingMatchesState());

    const authToken = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzODMxN2ZmMy03NjI2LTQ2MWYtOGUyMy0xMGE1MjExNGY0NGEiLCJmdWxsTmFtZSI6IlRyxrDGoW5nIFF1YW5nIFTDom4iLCJlbWFpbCI6InF1YW5ndGFuOWJnbUBnbWFpbC5jb20iLCJwaG9uZSI6IjA4NDQxMTEyMjIiLCJyb2xlIjoidXNlciIsImlzQ29uZmlybWVkIjp0cnVlLCJpYXQiOjE2NzkzNTM4MTEsImV4cCI6MTY4MTA4MTgxMX0.Wp73evwjlkAlWLETNkVLCb4FY4QaTSkPub8N26Zyi5b_70IH9LfWGYVf_jpMmQtWuY8CbnTKXdHyvaDrVNzdwQ';
    await service.cancelBookingMatch(authToken, bookingId);
    final incomingMatches = await service.getIncomingMatch(authToken);

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