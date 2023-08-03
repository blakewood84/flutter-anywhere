import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';

FutureOr<void> main(List<String> args) async {
  final query = args.first;
  final title = args.last;

  runApp(const App());
}
