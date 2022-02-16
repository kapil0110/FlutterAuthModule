import 'package:flutter/material.dart';

class PMAPConstants{
  static String? apiBaseUrl;
  static String? logoUrl;
  static Color? baseThemeColor;

  initialize({required String? baseUrl, required Color? themeColor, required String? logo}){
    apiBaseUrl = baseUrl;
    baseThemeColor = themeColor;
    logoUrl = logo;
  }

  //
  // static String apiImageUrl = "http://birlasoft.no-queue.in/uploads/";

}