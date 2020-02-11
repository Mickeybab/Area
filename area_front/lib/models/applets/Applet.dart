// Core
import 'package:json_annotation/json_annotation.dart';

import 'package:area_front/models/Service.dart';

part 'Applet.g.dart';

/// Model of the Applet
@JsonSerializable()
class Applet {
  final String id;

  /// id of the applet
  final String title;

  /// name of the applet
  final String description;

  /// the color of the applet
  final String color;

  /// the linked reactions
  final bool enabled;

  final Service action;
  final Service reaction;

  const Applet({
    this.id,
    this.title,
    this.description,
    this.color,
    this.enabled,
    this.action,
    this.reaction,
  });

  factory Applet.fromJson(Map<String, dynamic> json) => _$AppletFromJson(json);
  Map<String, dynamic> toJson() => _$AppletToJson(this);
}
