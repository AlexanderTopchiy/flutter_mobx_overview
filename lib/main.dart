import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/app/mobx_app.dart';
import 'package:flutter_mobx_overview/core/di.dart';

void main() {
  DI.register();

  runApp(const MobxApp());
}
