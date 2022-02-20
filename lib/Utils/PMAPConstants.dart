import 'package:authentication_package/authentication_package.dart';
import 'package:flutter/material.dart';

class PMAPConstants{
  static String? apiBaseUrl;
  static String? logoUrl;
  static Color? baseThemeColor;
  static List<SocialMediaTypes>? socialMedias;

  initialize({required String? baseUrl, required Color? themeColor, required String? logo,
  List<SocialMediaTypes>? socialLogins}){
    apiBaseUrl = baseUrl;
    baseThemeColor = themeColor;
    logoUrl = logo;
    socialMedias = socialLogins ?? [];

  }

  //
  // static String apiImageUrl = "http://birlasoft.no-queue.in/uploads/";

}