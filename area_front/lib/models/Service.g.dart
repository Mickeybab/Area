// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AService _$AServiceFromJson(Map<String, dynamic> json) {
  return AService(
    service: json['service'] as String,
    logo: json['logo'] as String,
    action: json['action'] as String,
    param: (json['param'] as List)
        ?.map(
            (e) => e == null ? null : Param.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AServiceToJson(AService instance) => <String, dynamic>{
      'service': instance.service,
      'logo': instance.logo,
      'action': instance.action,
      'param': instance.param?.map((e) => e?.toJson())?.toList(),
    };

RService _$RServiceFromJson(Map<String, dynamic> json) {
  return RService(
    service: json['service'] as String,
    logo: json['logo'] as String,
    reaction: json['reaction'] as String,
    param: (json['param'] as List)
        ?.map(
            (e) => e == null ? null : Param.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RServiceToJson(RService instance) => <String, dynamic>{
      'service': instance.service,
      'logo': instance.logo,
      'reaction': instance.reaction,
      'param': instance.param?.map((e) => e?.toJson())?.toList(),
    };
