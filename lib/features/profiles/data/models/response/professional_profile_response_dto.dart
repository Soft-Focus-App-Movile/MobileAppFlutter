import 'package:json_annotation/json_annotation.dart';

part 'professional_profile_response_dto.g.dart';

@JsonSerializable()
class ProfessionalProfileResponseDto {
  @JsonKey(name: 'professionalBio')
  final String? professionalBio;

  @JsonKey(name: 'isAcceptingNewPatients')
  final bool? isAcceptingNewPatients;

  @JsonKey(name: 'maxPatientsCapacity')
  final int? maxPatientsCapacity;

  @JsonKey(name: 'targetAudience')
  final List<String>? targetAudience;

  @JsonKey(name: 'languages')
  final List<String>? languages;

  @JsonKey(name: 'businessName')
  final String? businessName;

  @JsonKey(name: 'businessAddress')
  final String? businessAddress;

  @JsonKey(name: 'bankAccount')
  final String? bankAccount;

  @JsonKey(name: 'paymentMethods')
  final String? paymentMethods;

  @JsonKey(name: 'isProfileVisibleInDirectory')
  final bool? isProfileVisibleInDirectory;

  @JsonKey(name: 'allowsDirectMessages')
  final bool? allowsDirectMessages;

  ProfessionalProfileResponseDto({
    this.professionalBio,
    this.isAcceptingNewPatients,
    this.maxPatientsCapacity,
    this.targetAudience,
    this.languages,
    this.businessName,
    this.businessAddress,
    this.bankAccount,
    this.paymentMethods,
    this.isProfileVisibleInDirectory,
    this.allowsDirectMessages,
  });

  factory ProfessionalProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionalProfileResponseDtoToJson(this);
}
