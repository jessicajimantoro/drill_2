class HeroModel {
  final int id;
  final String name;
  final String localizedName;
  final String primaryAttribute;
  final String attackType;
  final List<String> roles;
  int? legs;

  HeroModel({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttribute,
    required this.attackType,
    required this.roles,
    this.legs,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'],
      name: json['name'],
      localizedName: json['localized_name'],
      primaryAttribute: json['primary_attr'],
      attackType: json['attack_type'],
      roles: List<String>.from(json['roles']),
      legs: json['legs'],
    );
  }
}
