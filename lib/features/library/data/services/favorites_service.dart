import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../auth/data/local/user_session.dart';
import '../models/request/favorite_request_dto.dart';
import '../models/response/content_list_response_dto.dart';

class FavoritesService {
  final UserSession _userSession = UserSession();

  Future<HttpClient> _getAuthenticatedClient() async {
    final user = await _userSession.getUser();
    return HttpClient(token: user?.token);
  }

  Future<ContentListResponseDto> getFavorites() async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.get(LibraryEndpoints.favorites);

    if (response.statusCode == 200) {
      return ContentListResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get favorites: ${response.body}');
    }
  }

  Future<void> addFavorite(FavoriteRequestDto request) async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.post(
      LibraryEndpoints.favorites,
      body: request.toJson(),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add favorite: ${response.body}');
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.delete(
      LibraryEndpoints.deleteFavorite(favoriteId),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to remove favorite: ${response.body}');
    }
  }
}
