import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/university_dto.dart';

/// Service for university API calls
class UniversityService {
  static const String _baseUrl = 'http://universities.hipolabs.com';

  /// Search universities by name and country
  Future<List<UniversityDto>> searchUniversities({
    String country = 'Peru',
    required String name,
  }) async {
    final url = Uri.parse('$_baseUrl/search')
        .replace(queryParameters: {
      'country': country,
      'name': name,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => UniversityDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search universities: ${response.statusCode}');
    }
  }
}
