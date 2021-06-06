import 'package:clean_login/net/firebase.dart';
import 'package:clean_login/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "image/secure_login.png",
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

    final usernameField = TextFormField(
      controller: _usernameController,
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
        hintText: "John Doe",
        labelText: "Username",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    final passwordField = TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
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
        hintText: "password here",
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    final repasswordField = TextFormField(
      controller: _repasswordController,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
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
        hintText: "re-enter password",
        labelText: "Re-enter Password",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [usernameField, emailField, passwordField, repasswordField],
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
          "Sign Up",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            await Firebase.initializeApp();
            User user =
                (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            ))
                    .user;
            if (user != null) {
              //User user = FirebaseAuth.instance.currentUser;
              user.updateProfile(displayName: _usernameController.text);
              userSetup(_usernameController.text);
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            print(e);
            _usernameController.text = "";
            _emailController.text = "";
            _passwordController.text = "";
            _repasswordController.text = "";
            // TODO: alerting with errormicheal
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Already a member?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              child: Text(
                "Log In",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
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
