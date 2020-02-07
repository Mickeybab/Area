// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppletParam _$AppletParamFromJson(Map<String, dynamic> json) {
  return AppletParam(
    name: json['name'] as String,
    type: json['type'] as String,
    value: json['value'] as String,
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$AppletParamToJson(AppletParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'value': instance.value,
      'category': instance.category,
    };
