library backend;

// Core
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

// Config
import 'package:global_configuration/global_configuration.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';

import '../models/applets/Applet.dart' as Model;

part 'Applet.dart';
part 'Client.dart';
