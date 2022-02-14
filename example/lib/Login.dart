import 'package:authentication_package/authentication_package.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(
        apiUrl: "https://cabletradesfinal.pugmarker.org/api/pm_api/api_login",
        logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
        onForgotPassword: () => Navigator.pushNamed(context, "/Forgot"),
        onLogin: (){},
        // onLogin: (data){
        //   print("data : $data");
        // },
        onRegister: () => Navigator.pushNamed(context, "/Register"),
      ),
    );
  }
}
