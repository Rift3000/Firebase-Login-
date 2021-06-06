import 'package:clean_login/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningScreen extends StatefulWidget {
  OpeningScreen({Key key}) : super(key: key);

  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  String displayName = "";

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString("displayName");
    });
  }

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "image/login.png",
      fit: BoxFit.contain,
      height: mq.size.width / 2.5,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authRegister);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 70),
          child: registerButton,
        ),
      ],
    );

    display() {
      if (displayName != null) {
        return Text(
          "Welcome Back $displayName!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      } else {
        return Text(
          "Welcome!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff993EAB),
      body: Padding(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 45.0),
              child: display(),
            ),
            buttons,
          ],
        ),
      ),
    );
  }
}
