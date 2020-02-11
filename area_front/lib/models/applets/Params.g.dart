// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  return Param(
    name: json['name'] as String,
    paramType: json['paramType'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ParamToJson(Param instance) => <String, dynamic>{
      'name': instance.name,
      'paramType': instance.paramType,
      'value': instance.value,
    };
