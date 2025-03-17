class Country {
  final String name;
  final String region;
  final String code;
  final String capital;

  Country({
    required this.name,
    required this.region,
    required this.code,
    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      code: json['code'] ?? '',
      capital: json['capital'] ?? '',
    );
  }
}
