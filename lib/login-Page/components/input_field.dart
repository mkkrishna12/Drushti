import 'package:drushti/login-Page/utils/viewport_size.dart';
import 'package:flutter/material.dart';

String password;

String email;

class InputField extends StatefulWidget {
  InputField({
    Key key,
    @required this.hintText,
    @required this.obscureText,
  }) : super(key: key);

  final String hintText;
  final bool obscureText;

  String getPassword1() {
    print(password);
    return password;
  }

  String getEmail1() {
    print(email);
    return email;
  }

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ViewportSize.width * 0.75,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          primaryColor: const Color(0x55000000),
        ),
        child: TextField(
          obscureText: widget.obscureText,
          onChanged: (value) async {
            if (widget.obscureText) {
              setState(() {
                password = value;
              });
            } else {
              setState(() {
                email = value;
              });
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ViewportSize.width * 0.02),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 15,
            ),
            fillColor: const Color(0x1F000000),
            filled: true,
          ),
        ),
      ),
    );
  }
}
