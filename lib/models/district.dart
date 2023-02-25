class District {
  final int id;
  final int provinceId;
  final String disctrictName;

  District(this.id, this.provinceId, this.disctrictName);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      json['id'] as int,
      json['provinceId'] as int,
      json['districtName']
    );
  }
}