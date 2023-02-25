class Province {
  final int id;
  final String provinceName;

  Province(this.id, this.provinceName);

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      json['id'] as int,
      json['provinceName'],
    );
  }
}