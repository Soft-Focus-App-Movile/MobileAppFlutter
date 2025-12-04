import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/response/profile_response_dto.dart';
import '../models/response/professional_profile_response_dto.dart';
import '../models/response/psychologist_complete_profile_response_dto.dart';

class ProfileService {
  final HttpClient _httpClient;

  ProfileService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<ProfileResponseDto> getProfile() async {
    final response = await _httpClient.get(UsersEndpoints.profile);
    if (response.statusCode == 200) {
      return ProfileResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener perfil: ${response.body}');
    }
  }

  Future<PsychologistCompleteProfileResponseDto>
      getPsychologistCompleteProfile() async {
    final response =
        await _httpClient.get(UsersEndpoints.psychologistCompleteProfile);
    if (response.statusCode == 200) {
      return PsychologistCompleteProfileResponseDto.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception(
          'Error al obtener perfil de psicólogo: ${response.body}');
    }
  }

  Future<PsychologistCompleteProfileResponseDto> getUserById(
      String userId) async {
    final response = await _httpClient.get(UsersEndpoints.getById(userId));
    if (response.statusCode == 200) {
      return PsychologistCompleteProfileResponseDto.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener usuario: ${response.body}');
    }
  }

  Future<PsychologistCompleteProfileResponseDto> getPsychologistById(
      String psychologistId) async {
    final response = await _httpClient
        .get(UsersEndpoints.getPsychologistDetail(psychologistId));
    if (response.statusCode == 200) {
      print('🔍 Raw JSON response from getPsychologistById:');
      print(response.body);
      final jsonData = jsonDecode(response.body);
      print('🔍 Decoded JSON keys: ${jsonData.keys}');
      return PsychologistCompleteProfileResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error al obtener psicólogo: ${response.body}');
    }
  }

  Future<ProfileResponseDto> updateProfileWithImage({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? phone,
    String? bio,
    String? country,
    String? city,
    List<String>? interests,
    List<String>? mentalHealthGoals,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? isProfilePublic,
    File? profileImageFile,
  }) async {
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('${ApiConstants.baseUrl}${UsersEndpoints.profile}'),
    );

    request.headers['Authorization'] = 'Bearer ${_httpClient.token}';

    if (firstName != null) request.fields['FirstName'] = firstName;
    if (lastName != null) request.fields['LastName'] = lastName;
    if (dateOfBirth != null) request.fields['DateOfBirth'] = dateOfBirth;
    if (gender != null) request.fields['Gender'] = gender;
    if (phone != null) request.fields['Phone'] = phone;
    if (bio != null) request.fields['Bio'] = bio;
    if (country != null) request.fields['Country'] = country;
    if (city != null) request.fields['City'] = city;
    if (emailNotifications != null) {
      request.fields['EmailNotifications'] = emailNotifications.toString();
    }
    if (pushNotifications != null) {
      request.fields['PushNotifications'] = pushNotifications.toString();
    }
    if (isProfilePublic != null) {
      request.fields['IsProfilePublic'] = isProfilePublic.toString();
    }

    if (interests != null) {
      for (var interest in interests) {
        request.fields['Interests'] = interest;
      }
    }

    if (mentalHealthGoals != null) {
      for (var goal in mentalHealthGoals) {
        request.fields['MentalHealthGoals'] = goal;
      }
    }

    if (profileImageFile != null) {
      final mimeType = lookupMimeType(profileImageFile.path) ?? 'image/jpeg';
      final mimeTypeData = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          profileImageFile.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return ProfileResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar perfil: ${response.body}');
    }
  }

  Future<ProfessionalProfileResponseDto> updateProfessionalProfile(
      Map<String, dynamic> professionalData) async {
    final response = await _httpClient.put(
      UsersEndpoints.psychologistProfessionalData,
      body: professionalData,
    );

    if (response.statusCode == 200) {
      return ProfessionalProfileResponseDto.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception(
          'Error al actualizar perfil profesional: ${response.body}');
    }
  }
}
