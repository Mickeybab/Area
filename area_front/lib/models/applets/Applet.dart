import 'package:json_annotation/json_annotation.dart';

part 'Applet.g.dart';


@JsonSerializable(nullable: false)
class Applet {
	final String name;
  final String description;
	final List<String> services;

  const Applet({this.name, this.services, this.description});

  factory Applet.fromJson(Map<String, dynamic> json) => _$AppletFromJson(json);
  Map<String, dynamic> toJson() => _$AppletToJson(this);
}