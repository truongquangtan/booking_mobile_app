import 'package:booking_app_mobile/models/slot.dart';

class BookingRequest {
  final int slotId;
  final String refSubYard;
  final int price;
  final int originalPrice;
  final String date;

  BookingRequest(this.slotId, this.refSubYard, this.price, this.originalPrice, this.date);

  factory BookingRequest.genSimpleRequestFromSlot(Slot slot, String date) {
    return BookingRequest(slot.id, slot.refSubYard, slot.price, slot.price, date);
  }

  Map<String, dynamic> toJson() {
    return {
      "slotId": slotId,
      "refSubYard": refSubYard,
      "price": price,
      "originalPrice": originalPrice,
      "date": date,
    };
  }
}
