import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/response/invitation_code_response_dto.dart';
import '../models/response/psychologist_stats_response_dto.dart';

class PsychologistService {
  final HttpClient _httpClient;

  PsychologistService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<InvitationCodeResponseDto> getInvitationCode() async {
    final response =
        await _httpClient.get(UsersEndpoints.psychologistInvitationCode);
    if (response.statusCode == 200) {
      return InvitationCodeResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Error al obtener código de invitación: ${response.body}');
    }
  }

  Future<PsychologistStatsResponseDto> getStats({
    String? fromDate,
    String? toDate,
  }) async {
    String url = UsersEndpoints.psychologistStats;
    if (fromDate != null || toDate != null) {
      final queryParams = <String>[];
      if (fromDate != null) queryParams.add('fromDate=$fromDate');
      if (toDate != null) queryParams.add('toDate=$toDate');
      url += '?${queryParams.join('&')}';
    }

    final response = await _httpClient.get(url);
    if (response.statusCode == 200) {
      return PsychologistStatsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener estadísticas: ${response.body}');
    }
  }
}
