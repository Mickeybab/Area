import 'package:area_front/backend/Backend.dart';

/// Model of our user info
class User {
  final String uid;
  final Backend client;

  User({this.uid, this.client});
}