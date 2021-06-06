import 'package:clean_login/net/firebase.dart';
import 'package:clean_login/theme/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    void showAlertDialog(BuildContext context) {
      TextEditingController _reemailControllerField = TextEditingController();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: false,
        body: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 3.5,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Text(
                "Insert Reset Email:",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
              ),
              TextField(
                controller: _reemailControllerField,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "something@example.com",
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xff8c52ff),
                  child: MaterialButton(
                    minWidth: mq.size.width / 2,
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
                    child: Text(
                      "Send Reset Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _reemailControllerField.text);
                        Navigator.of(context).pop();
                      } catch (e) {
                        print(e);
                        // TODO: Add snackbar reporting error
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        buttonsTextStyle: TextStyle(color: Colors.black),
        showCloseIcon: true,
      )..show();
    }

    final logo = Image.asset(
      "image/auth.png",
      fit: BoxFit.contain,
      height: mq.size.width / 2.2,
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    final passwordField = Column(
      children: [
        TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: "password here",
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
                child: Text("Forgot Password",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white)),
                onPressed: () {
                  showAlertDialog(context);
                }),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [emailField, passwordField],
      ),
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
        onPressed: () async {
          try {
            await Firebase.initializeApp();
            User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text))
                .user;
            if (user != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("displayName", user.displayName);
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            print(e);
            _emailController.text = "";
            _passwordController.text = "";
            // TODO: AlertDialog with error
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xff993EAB),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                logo,
                fields,
                bottom,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
