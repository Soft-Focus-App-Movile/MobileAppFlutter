import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/content_search_request_dto.dart';
import '../models/response/content_search_response_dto.dart';

class VideosSearchService {
  final HttpClient _httpClient;

  VideosSearchService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<ContentSearchResponseDto> searchVideos(String query) async {
    final request = ContentSearchRequestDto(
      query: query,
      contentType: 'video',
      limit: 20,
    );

    final response = await _httpClient.post(
      LibraryEndpoints.search,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return ContentSearchResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search videos: ${response.body}');
    }
  }
}
