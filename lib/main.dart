import 'package:flutter/material.dart';
import 'package:tcp_penguin/app/app.dart';
import 'package:tcp_penguin/app/di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();

  runApp(const MyApp());
}
