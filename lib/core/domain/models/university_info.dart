/// University information model
class UniversityInfo {
  final String name;
  final String region;

  UniversityInfo({
    required this.name,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
      };

  factory UniversityInfo.fromJson(Map<String, dynamic> json) => UniversityInfo(
        name: json['name'] as String,
        region: json['region'] as String,
      );
}
