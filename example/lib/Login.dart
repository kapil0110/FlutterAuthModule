// import 'dart:convert';
//
// import 'package:authentication_package/Utils/PMAPConfigOptions.dart';
// import 'package:authentication_package/authentication_package.dart';
// import 'package:example/MySharedPreferences.dart';
// import 'package:flutter/material.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   @override
//   void initState() {
//     super.initState();
//     String? url = PMAPConfigOptions().getApiBaseUrl();
//     print("url: $url");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PMAPLogin(
//         logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
//         onForgotPassword: () => Navigator.pushNamed(context, "/Forgot"),
//         onLogin: (data){
//           // print("data : $data");
//           // if(data!.isNotEmpty){
//           //   dynamic result = jsonDecode(data);
//           //   MySharedPreferences().addApiToken(result["access_token"]);
//           //   Navigator.pushReplacementNamed(context, "/Home");
//           // }
//         },
//         onRegister: () => Navigator.pushNamed(context, "/Register"),
//       ),
//     );
//   }
// }
