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
        if(temp["message"] != "Unauthenticated.") {
          Fluttertoast.showToast(
            msg: "${temp["message"]}",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
        }
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
        Map<String, dynamic> errorResponse = jsonDecode(response.body)["errors"];

        await showDialog(context: myContext, builder: (_){
          return AlertDialog(
            elevation: 1,
            title: const Text("Error", style: TextStyle(fontSize: 18,),),
            contentPadding: const EdgeInsets.all(8),
            actions: [
              TextButton(onPressed: (){Navigator.pop(myContext);}, child: const Text("OK")),
            ],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(errorResponse.length, (index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(errorResponse.keys.elementAt(index).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: List.generate(errorResponse.values.elementAt(index).length, (i){
                        return Text("${errorResponse.values.elementAt(index).elementAt(i)}");
                      }),
                    )
                  ],
                );
              }),
            ),
          );
        });
        // String error = errorResponse["errors"]["email"].first;
        // print(error);
        // Fluttertoast.showToast(
        //   msg: error,
        //   backgroundColor: Colors.redAccent,
        //   textColor: Colors.white,
        //   gravity: ToastGravity.BOTTOM,
        //   toastLength: Toast.LENGTH_LONG,
        // );
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