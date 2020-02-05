import 'package:json_annotation/json_annotation.dart';

part 'Applet.g.dart';

/// Model of the Applet
@JsonSerializable(nullable: false)
class Applet {
	final String name;/// name of the applet
  final String description;/// description of the applet
	final List<String> services;/// Services used by the applet

  const Applet({this.name, this.services, this.description});

  factory Applet.fromJson(Map<String, dynamic> json) => _$AppletFromJson(json);
  Map<String, dynamic> toJson() => _$AppletToJson(this);
}