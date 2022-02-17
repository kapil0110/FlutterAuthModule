import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HelperMethods{
  static late BuildContext myContext;

  void init(BuildContext context){
    myContext = context;
  }


  static String? getOutDate(dynamic document){
    List<dynamic> history = document["doc_history"];
    dynamic data = history.elementAt(history.indexWhere((element) => element["event"] == "Added Document"));

    return formatDate(data["updated_at"]);

  }

  static String? formatDate(String dateTime){
    late String date;
    DateTime time = DateTime.parse(dateTime);
    date = DateFormat("dd/MM/yyyy").format(time);

    return date;
  }

  static String getDate(DateTime dateTime){
    late String date;
    date = DateFormat("dd/MM/yyyy").format(dateTime);

    return date;
  }

  static String? formatTime(String dateTime){
    late String date;
    DateTime time = DateTime.parse(dateTime);
    date = DateFormat("hh:mm a").format(time.toLocal());


    return date;
  }

  static Future<String> showErrorMessage(http.Response response)async{
    String status = "Fail";
    dynamic temp = jsonDecode(response.body);

    switch(response.statusCode){
      case 200:
        status = "Success";
        break;
      case 201:
        status = "Success";
        break;
      case 401:
        Fluttertoast.showToast(
          msg: "${temp["message"]}",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 403:
        Fluttertoast.showToast(
          msg: "${temp["message"]}",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 404:
        Fluttertoast.showToast(
          msg: "Api Not Found!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 405:
        Fluttertoast.showToast(
          msg: "Method Not Allowed!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 422:
        print("422 error");
        // print(response.body);
        dynamic errorResponse = jsonDecode(response.body);
        String error = errorResponse["errors"]["email"].first;
        print(error);
        Fluttertoast.showToast(
          msg: error,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        // try{
        //   MySharedPreferences().addErrorData(response.body);
        // }catch(error){
        //   print("unprocess: $error");
        // }

        break;
      case 500:
        Fluttertoast.showToast(
          msg: "Server error. Please try later!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Something went wrong. Please try later!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;

    }

    return status;

  }

}