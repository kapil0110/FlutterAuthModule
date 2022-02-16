import 'package:flutter/material.dart';

class PMAPConstants{
  static String? apiBaseUrl;
  static Color? baseThemeColor;

  initialize(String? baseUrl, Color themeColor){
    apiBaseUrl = baseUrl;
    baseThemeColor = themeColor;
  }

  //
  // static String apiImageUrl = "http://birlasoft.no-queue.in/uploads/";

}