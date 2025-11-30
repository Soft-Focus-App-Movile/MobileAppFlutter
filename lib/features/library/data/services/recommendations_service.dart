import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/response/weather_place_response_dto.dart';
import '../models/response/content_list_response_dto.dart';

/// Service for content and place recommendations
class RecommendationsService {
  final HttpClient _httpClient;

  RecommendationsService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  /// Get recommended places based on current weather
  ///
  /// @param latitude User's latitude (-90 to 90)
  /// @param longitude User's longitude (-180 to 180)
  /// @param emotionFilter Optional emotion filter
  /// @param limit Maximum number of results (1-50, default: 10)
  /// @return Weather info + list of recommended places
  ///
  /// How it works:
  /// 1. Gets current weather from OpenWeather
  /// 2. Determines if suitable for outdoor/indoor activities
  /// 3. Searches places in Foursquare based on weather and emotion
  Future<WeatherPlaceResponseDto> getRecommendedPlaces({
    required double latitude,
    required double longitude,
    String? emotionFilter,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'limit': limit.toString(),
    };

    if (emotionFilter != null) {
      queryParameters['emotionFilter'] = emotionFilter;
    }

    final response = await _httpClient.get(
      LibraryEndpoints.recommendPlaces,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return WeatherPlaceResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recommended places: ${response.body}');
    }
  }

  /// Get recommended content based on user's current emotion
  ///
  /// @param contentType Optional content type filter
  /// @param limit Maximum number of results (1-50, default: 10)
  /// @return List of recommended content
  ///
  /// How it works:
  /// 1. Tries to get emotion from Tracking context
  /// 2. If not available, tries to infer emotion from weather (if location available)
  /// 3. Defaults to "Calm" emotion
  Future<ContentListResponseDto> getRecommendedContent({
    String? contentType,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'limit': limit.toString(),
    };

    if (contentType != null) {
      queryParameters['contentType'] = contentType;
    }

    final response = await _httpClient.get(
      LibraryEndpoints.recommendContent,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return ContentListResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recommended content: ${response.body}');
    }
  }

  /// Get recommended content for a specific emotion
  ///
  /// @param emotion Specific emotion (Happy, Sad, Anxious, Calm, Energetic)
  /// @param contentType Optional content type filter
  /// @param limit Maximum number of results (1-100, default: 10)
  /// @return List of content filtered by emotion
  Future<ContentListResponseDto> getRecommendedByEmotion({
    required String emotion,
    String? contentType,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'limit': limit.toString(),
    };

    if (contentType != null) {
      queryParameters['contentType'] = contentType;
    }

    final response = await _httpClient.get(
      LibraryEndpoints.recommendByEmotionType(emotion),
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return ContentListResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get recommendations by emotion: ${response.body}');
    }
  }
}
