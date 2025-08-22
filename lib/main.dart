import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_models/login_view_model.dart';
import 'view_models/app_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) =>AppViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckLoginState(),
      debugShowCheckedModeBanner: false,
    );
  }
}