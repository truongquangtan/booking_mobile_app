class Slot {
  final int id;
  final String refSubYard;
  final int price;
  final String startTime;
  final String endTime;
  bool isBooked;

  Slot(this.id, this.refSubYard, this.price, this.startTime, this.endTime, this.isBooked);

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      json['id'] as int,
      json['refSubYard'],
      json['price'] as int,
      json['startTime'],
      json['endTime'],
      json['isBooked'] as bool,
    );
  }
}