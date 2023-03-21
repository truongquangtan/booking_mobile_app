import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IncomingMatchCubit extends Cubit<IncomingMatchState> {
  final Service service = getIt<Service>();

  IncomingMatchCubit() : super(const LoadingIncomingMatchesState());

  void getIncomingMatches() async {
    emit(LoadingIncomingMatchesState());

    final storage = FlutterSecureStorage();
    final authToken = await storage.read(key: JWT_STORAGE_KEY);
    
    final incomingMatches = await service.getIncomingMatch(authToken!);

    emit(LoadedIncomingMatchesState(incomingMatches));
  }

  void cancelMatch(String bookingId) async {
    emit(LoadingIncomingMatchesState());

    final storage = FlutterSecureStorage();
    final authToken = await storage.read(key: JWT_STORAGE_KEY);

    await service.cancelBookingMatch(authToken!, bookingId);
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