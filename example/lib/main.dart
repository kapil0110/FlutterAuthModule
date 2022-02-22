import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:authentication_package/Utils/PMAPConstants.dart';
import 'package:authentication_package/authentication_package.dart';
import 'package:example/HomeScreen.dart';
import 'package:example/MySharedPreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Overrides http Client setting to accept faulty/corrupt SSL Certificates.
//Only for development purpose. Solve Certificate issues before production release

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Sets setting globally for all HttpClients
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Plugin Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const MyHomePage(title: "Authentication Demo"),
        "/Home" : (context) => const HomeScreen()
      },    );
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
    //Initialize Configuration properties that will be used inside plugin
    //to make api call, set color theme
    PMAPConstants().initialize(
        //Provides baseUrl for all api calls
        baseUrl: "https://cabletradesfinal.pugmarker.org/api/pm_api/",
        //Provides Background color for Buttons and Color of clickable links
        // within Plugin classes
        themeColor: Colors.purple,
        //Provides url to logo displayed in Splash Screen
        logo: "https://raw.githubusercontent.com/nimish-pugmarker/"
            "File-Hosting-For-Demo/9269c45b6323c6738a4bd12df4fcf3667e6ff528/"
            "Dummy-logo%20(1).svg",
      socialLogins: [
        SocialMediaTypes.google,
        SocialMediaTypes.facebook,
        SocialMediaTypes.twitter,
      ],
    );

    //Future call returns true after apiToken is initialized
    // Returns apiToken string if present in SharedPreferences,
    // else returns empty string.
    _future = getApiToken();
  }

  Future<bool> getApiToken()async{
    apiToken = await MySharedPreferences().getApiToken();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // FutureBuilder to ensure that apiToken is initialized properly
      body: FutureBuilder(
          future: _future,
          builder: (context, snapShot) {
            if(snapShot.hasData) {

              return PMAPSplash(
/*---------------------- Required mandatory parameters -----------------------*/

                //Used to check user session authenticity
                //If authenticated, response is returned in onAuthenticated callback below
                apiToken: apiToken,
                //Provides width to logo displayed in Splash Screen
                logoWidth: 150,
                //Provides height to logo displayed in Splash Screen
                logoHeight: 150,
                //Callback returning result from Registration api
                //Returns jsonString on Success and empty string on Failure
                onRegister: (value){
                  log("onRegister: $value");
                  if(value!.isNotEmpty) {
                    dynamic result = jsonDecode(value);
                    MySharedPreferences().addApiToken(result["access_token"]);
                    Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                    // Navigator.pushReplacementNamed(context, "/Home");
                  }
                },
                //Callback returning result from Authentication api
                onAuthenticated: (value) {
                  log("onAuthenticated: $value");

                  dynamic result = jsonDecode(value!);
                  if(result["message"] == "Authenticated") {
                    Navigator.pushReplacementNamed(context, "/Home");
                  }
                },
                //Callback returning result from Login api
                //Returns jsonString on Success and empty string on Failure
                onLogin: (value){
                  log("onLogin: $value");

                  if(value!.isNotEmpty){
                    dynamic result = jsonDecode(value);
                    MySharedPreferences().addApiToken(result["access_token"]);
                    Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                    // Navigator.pushReplacementNamed(context, "/Home");
                  }
                },
                //Callback returning result from Reset Password api
                //Returns jsonString on Success and empty string on Failure
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
                onGoogleLogin: (value){
                  log("main: $value");

                  if(value!.isNotEmpty){
                    dynamic result = jsonDecode(value);
                    MySharedPreferences().addApiToken(result["access_token"]);
                    Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                  }

                },
                onFacebookLogin: (value){
                  log("main: $value");

                  if(value!.isNotEmpty){
                    dynamic result = jsonDecode(value);
                    MySharedPreferences().addApiToken(result["access_token"]);
                    Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                  }

                },
                onTwitterLogin: (value){
                  log("main: $value");

                  if(value!.isNotEmpty){
                    dynamic result = jsonDecode(value);
                    MySharedPreferences().addApiToken(result["access_token"]);
                    Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                  }

                },

/*-------------------- Splash Screen Configuration Options -------------------*/

                splashScreenConfigOptions: PMAPSplashConfigOptions(
                  apiName: "api_validate_token",

                  //App title default none
                  title: "My Auth Plugin",

                  //App title font size default 20, max 40
                  titleFontSize: 20,

                  // App title font color default black,
                  titleFontColor: Colors.black,

                  // App title font weight default normal,
                  titleFontWeight: FontWeight.normal,

                  // App title font style default normal,
                  titleFontStyle: FontStyle.normal,

                  // App title underline default false,
                  titleUnderline: false,

                ),

/*---------------------- Login Screen Configuration Options -----------------------*/

                loginScreenConfigOptions: PMAPLoginConfigOptions(
                  apiName: "api_login",
                  //Provides width to logo displayed in Splash Screen
                  logoWidth: 150,

                  //Provides height to logo displayed in Splash Screen
                  logoHeight: 150,

                  //App title default none
                  title: "My Auth Plugin",

                  //App title font size default 20, max 40
                  titleFontSize: 20,

                  // App title font color default black,
                  titleFontColor: Colors.black,

                  // App title font weight default normal,
                  titleFontWeight: FontWeight.normal,

                  // App title font style default normal,
                  titleFontStyle: FontStyle.normal,

                  // App title underline default false,
                  titleUnderline: false,
                ),

/*---------------------- Register Screen Configuration Options -----------------------*/
                //
                registerScreenConfigOptions: PMAPRegisterConfigOptions(
                  apiName: "api_register",
/*--------------------------- Optional parameters ----------------------------*/

                  //App title default none
                  title: "My Auth Plugin",

                  //App title font size default 20, max 40
                  titleFontSize: 20,

                  // App title font color default black,
                  titleFontColor: Colors.black,

                  // App title font weight default normal,
                  titleFontWeight: FontWeight.normal,

                  // App title font style default normal,
                  titleFontStyle: FontStyle.normal,

                  // App title underline default false,
                  titleUnderline: false,
                ),

/*---------------------- Forgot Password Screen Configuration Options -----------------------*/

                forgotPasswordScreenConfigOptions: PMAPForgotPasswordConfigOptions(
                  apiName: "api_password_reset",
/*--------------------------- Optional parameters ----------------------------*/

                  //App title default none
                  title: "My Auth Plugin",

                  //App title font size default 20, max 40
                  titleFontSize: 20,

                  // App title font color default black,
                  titleFontColor: Colors.black,

                  // App title font weight default normal,
                  titleFontWeight: FontWeight.normal,

                  // App title font style default normal,
                  titleFontStyle: FontStyle.normal,

                  // App title underline default false,
                  titleUnderline: false,
                ),

              );
            }else{
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
