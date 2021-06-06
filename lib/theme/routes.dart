import 'package:flutter/material.dart';
import 'package:clean_login/Views/login_screen.dart';
import 'package:clean_login/Views/register_screen.dart';
import 'package:clean_login/Views/menu.dart';
import 'package:clean_login/Views/videos.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';
  static const String videos = '/videos';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      menu: (context) => Menu(),
      videos: (context) => VideoScreen(),
    };
  }
}
