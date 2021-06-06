import 'package:clean_login/theme/routes.dart';
import 'package:flutter/material.dart';
import 'Views/opening_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Login',
      routes: AppRoutes.define(),
      home: OpeningScreen(),
    );
  }
}
