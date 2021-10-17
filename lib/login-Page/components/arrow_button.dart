import 'package:drushti/login-Page/enums/mode.dart';
import 'package:drushti/login-Page/utils/custom_icons_icons.dart';
import 'package:drushti/login-Page/utils/viewport_size.dart';
import 'package:drushti/source/object_detection/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArrowButton extends StatelessWidget {
  ArrowButton({
    Key key,
    @required this.email,
    @required this.password,
    @required this.activeMode,
  }) : super(key: key);
  final String email, password;
  final Mode activeMode;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void pushData(BuildContext context) async {
    try {
      print("$email $password");
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.pushNamed(context, HomePage.id);
        print("Registered ");
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchData(BuildContext context) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.pushNamed(context, HomePage.id);
        print("Logged in");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ViewportSize.width - ViewportSize.width * 0.26,
      margin: EdgeInsets.only(
        top: ViewportSize.height * 0.06,
      ),
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {
          if (activeMode == Mode.day)
            fetchData(context);
          else {
            pushData(context);
          }
        },
        child: Container(
          width: ViewportSize.width * 0.155,
          height: ViewportSize.width * 0.155,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: const Color(0xFFFFFFFF),
            shadows: [
              BoxShadow(
                color: const Color(0x55000000),
                blurRadius: ViewportSize.width * 0.9,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Icon(CustomIcons.right_arrow),
        ),
      ),
    );
  }
}
