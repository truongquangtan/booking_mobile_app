class SubYard {
  final String id;
  final String name;
  final String parentYard;
  final String typeYard;

  SubYard(this.id, this.name, this.parentYard, this.typeYard);

  factory SubYard.fromJson(Map<String, dynamic> json) {
    return SubYard(
      json['id'],
      json['name'],
      json['parentYard'],
      json['typeYard'],
    );
  }
}