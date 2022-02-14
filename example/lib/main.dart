import 'dart:io';

import 'package:authentication_package/authentication_package.dart';
import 'package:authentication_package/Utils/Constants.dart';
import 'package:example/Forgot.dart';
import 'package:example/Login.dart';
import 'package:example/Register.dart';
import 'package:flutter/material.dart';

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
        "/Login" : (context) => const Login(),
        "/Forgot" : (context) => const Forgot(),
        "/Register" : (context) => const Register()
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


  @override
  void initState() {
    super.initState();
    Constants().initialize("https://cabletradesfinal.pugmarker.org/api/pm_api/", Colors.purple);
    Future.delayed(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, "/Login"));
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(
        logoWidth: 50,
        logoHeight: 50,
        logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
      ),
    );
  }
}
