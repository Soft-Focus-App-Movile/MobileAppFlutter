import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../auth/data/local/user_session.dart';
import '../models/request/content_search_request_dto.dart';
import '../models/response/content_item_response_dto.dart';
import '../models/response/content_search_response_dto.dart';

class ContentSearchService {
  final UserSession _userSession = UserSession();

  Future<HttpClient> _getAuthenticatedClient() async {
    final user = await _userSession.getUser();
    return HttpClient(token: user?.token);
  }

  Future<ContentItemResponseDto> getContentById(String contentId) async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.get(
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
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.post(
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
