// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Applet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applet _$AppletFromJson(Map<String, dynamic> json) {
  return Applet(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    action: json['action'] as String,
    reaction: json['reaction'] as String,
    enabled: json['enabled'] as bool,
    params: (json['params'] as List)
        .map((e) => AppletParam.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AppletToJson(Applet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'action': instance.action,
      'reaction': instance.reaction,
      'enabled': instance.enabled,
      'params': instance.params,
    };
