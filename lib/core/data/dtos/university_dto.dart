/// DTO for university API response
class UniversityDto {
  final String name;
  final String country;
  final String alphaTwoCode;
  final List<String> webPages;
  final List<String> domains;
  final String? stateProvince;

  UniversityDto({
    required this.name,
    required this.country,
    required this.alphaTwoCode,
    required this.webPages,
    required this.domains,
    this.stateProvince,
  });

  factory UniversityDto.fromJson(Map<String, dynamic> json) {
    return UniversityDto(
      name: json['name'] as String,
      country: json['country'] as String,
      alphaTwoCode: json['alpha_two_code'] as String,
      webPages: List<String>.from(json['web_pages'] as List),
      domains: List<String>.from(json['domains'] as List),
      stateProvince: json['state-province'] as String?,
    );
  }
}
