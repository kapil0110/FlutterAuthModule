import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:authentication_package/Utils/PMAPConfigOptions.dart';
import 'package:authentication_package/authentication_package.dart';
import 'package:authentication_package/Utils/PMAPConstants.dart';
import 'package:example/Forgot.dart';
import 'package:example/HomeScreen.dart';
import 'package:example/Login.dart';
import 'package:example/MySharedPreferences.dart';
import 'package:example/Register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const MyHomePage(title: "Authentication Demo"),
        // "/Login" : (context) => const Login(),
        // "/Forgot" : (context) => const Forgot(),
        // "/Register" : (context) => const Register(),
        "/Home" : (context) => const HomeScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String apiToken;
  late Future<bool> _future;

  @override
  void initState() {
    super.initState();
    PMAPConstants().initialize("https://cabletradesfinal.pugmarker.org/api/pm_api/", Colors.purple);
    PMAPConfigOptions().initialize(
        baseUrl: "https://cabletradesfinal.pugmarker.org/api/pm_api/",
        themeColor: Colors.purple);
    _future = getApiToken();
    // Future.delayed(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, "/Login"));
  }

  Future<bool> getApiToken()async{
    apiToken = await MySharedPreferences().getApiToken();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot) {
          if(snapShot.hasData) {
            return PMAPSplash(
              apiToken: apiToken,
              logoWidth: 50,
              logoHeight: 50,
              logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
              onAuthenticated: (value) {
                log("onAuthenticated: $value");

                dynamic result = jsonDecode(value!);
                if(result["message"] == "Authenticated") {
                  Navigator.pushReplacementNamed(context, "/Home");
                }
              },
              onForgotPassword: (value){
                log("onForgotPassword: $value");

                if(value!.isNotEmpty) {
                  if (jsonDecode(value)["resetStatus"] == "Success") {
                    Fluttertoast.showToast(
                      msg: jsonDecode(value)["message"],
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
                }
              },
              onLogin: (value){
                log("onLogin: $value");

                if(value!.isNotEmpty){
                  dynamic result = jsonDecode(value);
                  MySharedPreferences().addApiToken(result["access_token"]);
                  Navigator.pushReplacementNamed(context, "/Home");
                }
              },
              onRegister: (value){
                log("onRegister: $value");
                if(value!.isNotEmpty) {
                  dynamic result = jsonDecode(value);
                  MySharedPreferences().addApiToken(result["access_token"]);
                  Navigator.pushReplacementNamed(context, "/Home");
                }
              },

            );
          }else{
            return const CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
