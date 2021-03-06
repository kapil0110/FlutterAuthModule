import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_package/Utils/PMAPConstants.dart';
import 'package:authentication_package/Utils/helperMethods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  Future<String> login(String? apiName, String? userName, String? password) async {
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
      response = await http.post(Uri.parse("${PMAPConstants.apiBaseUrl}$apiName"),
          headers: headers, body: jsonEncode(data)).timeout(const Duration(seconds: 15));
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
        msg: "Connection Timed out",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;

    }


    return result;
  }

  Future<String> authenticate(String? apiName, String? apiToken) async {
    http.Response? response;
    String result= "None";

    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    try {
      response = await http.post(Uri.parse("${PMAPConstants.apiBaseUrl}$apiName"),
          headers: header).timeout(const Duration(seconds: 15));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Connection Timed out",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

  Future<String> register(String? apiName, Map<String, dynamic> data) async {
    http.Response? response;
    String result= "None";

    Map<String, String> header = {
      // "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };

    try {
      response = await http.post(Uri.parse("${PMAPConstants.apiBaseUrl}$apiName"),
          headers: header, body: jsonEncode(data)).timeout(const Duration(seconds: 15));

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      Fluttertoast.showToast(
        msg: "Connection Timed out",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

  Future<String> resetPassword(String? apiName, Map<String, dynamic> data) async {
    http.Response? response;
    String result= "None";

    Map<String, String> header = {
      // "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    print("${PMAPConstants.apiBaseUrl}$apiName");

    try {
      response = await http.post(Uri.parse("${PMAPConstants.apiBaseUrl}$apiName"),
          headers: header, body: jsonEncode(data)).timeout(const Duration(seconds: 15));
      print(response.statusCode);
      print(response.body);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      Fluttertoast.showToast(
        msg: "Connection Timed out",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

  Future<String> checkUser(Map<String, dynamic> data) async {
    http.Response? response;
    String result= "None";

    Map<String, String> header = {
      // "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };

    try {
      response = await http.post(Uri.parse("${PMAPConstants.apiBaseUrl}api_email_exists"),
          headers: header, body: jsonEncode(data)).timeout(const Duration(seconds: 15));
      print(response.statusCode);
      print(response.body);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      Fluttertoast.showToast(
        msg: "Connection Timed out",
        backgroundColor: PMAPConstants.baseThemeColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

}