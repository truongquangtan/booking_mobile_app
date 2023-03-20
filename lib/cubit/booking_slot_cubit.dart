import 'package:booking_app_mobile/models/slot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/service/service.dart';

class BookingSlotsCubit extends Cubit<BookingSlotsState> {
  final Service service = getIt<Service>();

  BookingSlotsCubit() : super(BookingSlotsState(slots: [], isLoading: false, error: '', isJustBooked: false, targetSlot: null, isSelected: null));

  void selectOneMoreSlot(Slot slot) {
    if(state.isJustBooked) {
      emit(state.copyWith(slots: [], error: '', isLoading: false, isJustBooked: false, targetSlot: null, isSelected: null));
    }
    final slots = [...state.slots];
    final index = slots.indexWhere((element) => element.id == slot.id);
    if(index < 0){
      slots.add(slot);
    }
    emit(state.copyWith(slots: slots, error: '', isLoading: false, isJustBooked: false, targetSlot: slot, isSelected: true));
  }

  void unselectedOneSlot(Slot slot) {
    final slots = [...state.slots];
    final index = slots.indexWhere((element) => element.id == slot.id);
    if(index >= 0) {
      slots.removeAt(index);
    }
    emit(state.copyWith(slots: slots, error: '', isLoading: false, isJustBooked: false, targetSlot: slot, isSelected: false));
  }

  void bookSomeSlots(String date, String yardId) async {
    final slots = [...state.slots];

    emit(state.copyWith(slots: slots, error: '', isLoading: true, isJustBooked: false, targetSlot: null, isSelected: null));

    const authToken = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzODMxN2ZmMy03NjI2LTQ2MWYtOGUyMy0xMGE1MjExNGY0NGEiLCJmdWxsTmFtZSI6IlRyxrDGoW5nIFF1YW5nIFTDom4iLCJlbWFpbCI6InF1YW5ndGFuOWJnbUBnbWFpbC5jb20iLCJwaG9uZSI6IjA4NDQxMTEyMjIiLCJyb2xlIjoidXNlciIsImlzQ29uZmlybWVkIjp0cnVlLCJpYXQiOjE2NzkzNTM4MTEsImV4cCI6MTY4MTA4MTgxMX0.Wp73evwjlkAlWLETNkVLCb4FY4QaTSkPub8N26Zyi5b_70IH9LfWGYVf_jpMmQtWuY8CbnTKXdHyvaDrVNzdwQ';
    final response = await service.book(authToken, yardId, slots, date);

    emit(state.copyWith(slots: slots, error: response.isSuccess ? '' : response.errorMessage , isLoading: false, isJustBooked: true, targetSlot: null, isSelected: null));
  }

  void removeJustBookedMark() {
    emit(state.copyWith(slots: [], error: '', isLoading: false, isJustBooked: false, targetSlot: null, isSelected: null));
  }
}

@immutable
class BookingSlotsState extends Equatable {
  final List<Slot> slots;
  final bool isLoading;
  final String error;
  final bool isJustBooked;
  final Slot? targetSlot;
  final bool? isSelected;
  
  BookingSlotsState({
    required this.slots,
    required this.isLoading,
    required this.error,
    required this.isJustBooked,
    required this.targetSlot,
    required this.isSelected,
  });

  BookingSlotsState copyWith({
    List<Slot>? slots,
    bool? isLoading,
    String? error,
    bool? isJustBooked,
    Slot? targetSlot,
    bool? isSelected,
  }) {
    return BookingSlotsState(
      slots: slots ?? this.slots,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isJustBooked: isJustBooked ?? this.isJustBooked,
      targetSlot: targetSlot,
      isSelected: isSelected);
  }

  @override
  List<Object?> get props => [slots, isLoading, error, isJustBooked, targetSlot, isSelected];
}
