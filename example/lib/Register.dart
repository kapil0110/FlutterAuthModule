import 'package:authentication_package/authentication_package.dart';
import 'package:flutter/material.dart';
class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterScreen(
        logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
        onLoginLink: () => Navigator.pop(context),
        onRegister: (){},
      ),
    );
  }
}