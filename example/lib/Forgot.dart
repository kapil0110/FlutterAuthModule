import 'package:authentication_package/authentication_package.dart';
import 'package:flutter/material.dart';
class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordScreen(
        logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
        onForgotPassword: (){},
        onLoginLink: () => Navigator.pop(context),
      ),
    );
  }
}