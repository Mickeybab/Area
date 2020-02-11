import 'package:json_annotation/json_annotation.dart';

part 'Params.g.dart';

@JsonSerializable()
class Param {
  /// name of the param
  final String name;
  /// it can be `string` or `int`
  final String type;
  /// the value is always a string but you can find a phrase or a int inside
  final String value;

  const Param({this.name, this.type, this.value});

  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
  Map<String, dynamic> toJson() => _$ParamToJson(this);
}
