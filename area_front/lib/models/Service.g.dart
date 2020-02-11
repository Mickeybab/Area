// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    service: json['service'] as String,
    logo: json['logo'] as String,
    action: json['action'] as String,
    param: (json['param'] as List)
        ?.map(
            (e) => e == null ? null : Param.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'service': instance.service,
      'logo': instance.logo,
      'action': instance.action,
      'param': instance.param,
    };
