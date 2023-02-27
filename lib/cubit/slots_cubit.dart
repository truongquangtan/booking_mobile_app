import 'package:booking_app_mobile/locator.dart';
import 'package:booking_app_mobile/models/slot.dart';
import 'package:booking_app_mobile/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlotsCubit extends Cubit<SlotsState> {
  final Service service = getIt<Service>();

  SlotsCubit() : super(const InitialSlotsState());

  void getSlots(String subYardId, String date) async {
    emit(LoadingSlots());

    final slots = await service.getSlots(subYardId, date);
    
    emit(LoadedSlots(slots));
  }

  void selectDate(String date) {
    emit(SelectedADate(date));
  }

  void selectSubYard(String subYardId) {
    emit(SelectedASubYard(subYardId));
  }
}

abstract class SlotsState extends Equatable {
  const SlotsState();
}

class InitialSlotsState extends SlotsState {
  const InitialSlotsState();

  @override
  List<Object?> get props => [];
}

class LoadingSlots extends SlotsState {
  const LoadingSlots();

  @override
  List<Object?> get props => [];
}

class LoadedSlots extends SlotsState {
  final List<Slot> slots;
  const LoadedSlots(this.slots);

  @override
  List<Object?> get props => [slots];
}

class SelectedADate extends SlotsState {
  final String date;
  const SelectedADate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectedASubYard extends SlotsState {
  final String subYardId;
  const SelectedASubYard(this.subYardId);

  @override
  List<Object?> get props => [subYardId];
}
