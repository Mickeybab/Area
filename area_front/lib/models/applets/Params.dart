import 'package:json_annotation/json_annotation.dart';

part 'Params.g.dart';

@JsonSerializable(nullable: false)
class AppletParam {
  /// name of the param
  final String name;
  /// it can be `string` or `int`
  final String type;
  /// the value is always a string but you can find a phrase or a int inside
  final String value;
  /// category can only have two value `action` or `reaction`
  final String category;

  const AppletParam({this.name, this.type, this.value, this.category});

  factory AppletParam.fromJson(Map<String, dynamic> json) => _$AppletParamFromJson(json);
  Map<String, dynamic> toJson() => _$AppletParamToJson(this);
}
