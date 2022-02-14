import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_package/Utils/helperMethods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  Future<String> login(String? url, String? userName, String? password) async {
    http.Response? response;
    String result= "None";
    Map<String, String> headers = {
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    Map<String, dynamic> data = {};
    data["email"] = userName;
    data["password"] = password;
    try {
      response = await http.post(Uri.parse(url!), headers: headers, body: jsonEncode(data)).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      // result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;

    } on TimeoutException{
      // result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;

    }


    return result;
  }

}