import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/content_search_request_dto.dart';
import '../models/response/content_item_response_dto.dart';
import '../models/response/content_search_response_dto.dart';

class ContentSearchService {
  final HttpClient _httpClient;

  ContentSearchService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<ContentItemResponseDto> getContentById(String contentId) async {
    final response = await _httpClient.get(
      LibraryEndpoints.getContentById(contentId),
    );

    if (response.statusCode == 200) {
      return ContentItemResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get content: ${response.body}');
    }
  }

  Future<ContentSearchResponseDto> searchContent(
    ContentSearchRequestDto request,
  ) async {
    final response = await _httpClient.post(
      LibraryEndpoints.search,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return ContentSearchResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search content: ${response.body}');
    }
  }
}
