// Core
import 'package:area_front/models/applets/Params.dart';
import 'package:json_annotation/json_annotation.dart';


part 'Service.g.dart';

@JsonSerializable()
class Service {
  final String service;
  final String logo;
  final String action;
  final List<Param> param;
  const Service({this.service, this.logo, this.action, this.param});

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);

}
