import 'package:booking_app_mobile/models/slot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class BookingSlotsCubit extends Cubit<BookingSlotsState> {
  final Service service = getIt<Service>();

  BookingSlotsCubit() : super(BookingSlotsState(slots: [], isLoading: false, error: '', isJustBooked: false));

  void selectOneMoreSlot(Slot slot) {
    if(state.isJustBooked) {
      emit(state.copyWith(slots: [], error: '', isLoading: false, isJustBooked: false));
    }
    final slots = state.slots;
    slots.add(slot);
    emit(state.copyWith(slots: slots, error: '', isLoading: false, isJustBooked: false));
  }

  void unselectedOneSlot(Slot slot) {
    final slots = state.slots;
    final index = slots.indexWhere((element) => element.id == slot.id);
    slots.removeAt(index);
    emit(state.copyWith(slots: slots, error: '', isLoading: false, isJustBooked: false));
  }

  void bookSomeSlots(String date, String yardId) async {
    final slots = state.slots;

    emit(state.copyWith(slots: slots, error: '', isLoading: true, isJustBooked: false));

    const authToken = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxZTc3OTQ4OC1kMTU1LTRjYmEtYWVkNS1lNGZkNzMzYWY1MzEiLCJmdWxsTmFtZSI6IlRydW9uZyBRdWFuZyBUYW4iLCJlbWFpbCI6InRydW9uZ3F1YW5ndGFuMjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjA4NDQxMTEwMDEiLCJyb2xlIjoidXNlciIsImlzQ29uZmlybWVkIjp0cnVlLCJpYXQiOjE2NzczNDA2NDQsImV4cCI6MTY3OTA2ODY0NH0.FrFqZkQECrQSavqiUQSX47usxzUv0TewgvsZ_xv-9VvgTPvtBNmta0uXGH6xvRdFa5E7U9QcUO9BCpahv5ZdCQ';
    final response = await service.book(authToken, yardId, slots, date);

    emit(state.copyWith(slots: slots, error: response.isSuccess ? '' : response.errorMessage , isLoading: false, isJustBooked: true));
  }

  void removeJustBookedMark() {
    emit(state.copyWith(slots: [], error: '', isLoading: false, isJustBooked: false));
  }
}

@immutable
class BookingSlotsState extends Equatable {
  final List<Slot> slots;
  final bool isLoading;
  final String error;
  final bool isJustBooked;
  
  BookingSlotsState({
    required this.slots,
    required this.isLoading,
    required this.error,
    required this.isJustBooked,
  });

  BookingSlotsState copyWith({
    List<Slot>? slots,
    bool? isLoading,
    String? error,
    bool? isJustBooked,
  }) {
    return BookingSlotsState(slots: slots ?? this.slots, isLoading: isLoading ?? this.isLoading, error: error ?? this.error, isJustBooked: isJustBooked ?? this.isJustBooked);
  }

  @override
  List<Object?> get props => [slots, isLoading, error];
}
