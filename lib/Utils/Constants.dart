import 'package:flutter/material.dart';

class Constants{
  static String? apiBaseUrl;
  static Color? baseThemeColor;

  initialize(String? baseUrl, Color themeColor){
    apiBaseUrl = baseUrl;
    baseThemeColor = themeColor;
  }

  //
  // static String apiImageUrl = "http://birlasoft.no-queue.in/uploads/";

}