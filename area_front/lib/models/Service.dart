// Core
import 'package:area_front/models/applets/Params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Service.g.dart';

@JsonSerializable(explicitToJson: true)
class AService {
  final String service;
  final String logo;
  final String action;
  List<Param> param;
  AService({this.service, this.logo, this.action, this.param});

  factory AService.fromJson(Map<String, dynamic> json) =>
      _$AServiceFromJson(json);
  Map<String, dynamic> toJson() => _$AServiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RService {
  final String service;
  final String logo;
  final String reaction;
  List<Param> param;
  RService({this.service, this.logo, this.reaction, this.param});

  factory RService.fromJson(Map<String, dynamic> json) =>
      _$RServiceFromJson(json);
  Map<String, dynamic> toJson() => _$RServiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Service {
  final String service;
  final String logo;
  final String color;
  bool enable;
  bool sync;

  Service({this.service, this.logo, this.color, this.enable, this.sync});

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}