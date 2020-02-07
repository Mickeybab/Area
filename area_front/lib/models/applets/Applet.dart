// Core
import 'package:json_annotation/json_annotation.dart';

// Model
import './Params.dart';

part 'Applet.g.dart';

/// Model of the Applet
@JsonSerializable(nullable: false)
class Applet {
  final String id;

  /// id of the applet
  final String title;

  /// name of the applet
  final String description;

  /// description of the applet
  final String action;

  /// the linked actions
  final String reaction;

  /// the linked reactions
  final bool enabled;

  /// if the applet is running
  final List<AppletParam> params;

  const Applet(
      {this.id,
      this.title,
      this.description,
      this.action,
      this.reaction,
      this.enabled,
      this.params});

  factory Applet.fromJson(Map<String, dynamic> json) => _$AppletFromJson(json);
  Map<String, dynamic> toJson() => _$AppletToJson(this);
}
