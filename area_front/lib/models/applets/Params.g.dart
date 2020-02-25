// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  return Param(
    name: json['name'] as String,
    type: json['type'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ParamToJson(Param instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'value': instance.value,
    };
