// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Applet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applet _$AppletFromJson(Map<String, dynamic> json) {
  return Applet(
    name: json['name'] as String,
    services: (json['services'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$AppletToJson(Applet instance) => <String, dynamic>{
      'name': instance.name,
      'services': instance.services,
    };
