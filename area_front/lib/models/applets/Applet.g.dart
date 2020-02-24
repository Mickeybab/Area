// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Applet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applet _$AppletFromJson(Map<String, dynamic> json) {
  return Applet(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    color: json['color'] as String,
    enable: json['enable'] as bool,
    action: json['action'] == null
        ? null
        : Service.fromJson(json['action'] as Map<String, dynamic>),
    reaction: json['reaction'] == null
        ? null
        : Service.fromJson(json['reaction'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppletToJson(Applet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'color': instance.color,
      'enable': instance.enable,
      'action': instance.action?.toJson(),
      'reaction': instance.reaction?.toJson(),
    };
