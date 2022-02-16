import 'package:authentication_package/Utils/PMAPConstants.dart';
import 'package:flutter/material.dart';

class PMAPConfigOptions{
  static String? apiBaseUrl;
  static String? _logoUrl;
  // static String? apiToken;
  static Color? _baseThemeColor;

  initialize({
    required String? baseUrl,
    required Color? themeColor,
    String? logo,
    String? token}){

      apiBaseUrl = baseUrl;
      _baseThemeColor = themeColor;
      _logoUrl = logo ?? "";
      // apiToken = token ?? "";

  }

  void setApiBaseUrl(String? url){
    apiBaseUrl = url;
  }

  String? getApiBaseUrl(){
    return apiBaseUrl;
  }

  void setBaseThemeColor(Color? color){
    _baseThemeColor = color;
  }

  Color? getBaseThemeColor(){
    return _baseThemeColor;
  }

  void setLogoUrl(String? logo){
    _logoUrl = logo;
  }

  String? getLogoUrl(){
    return _logoUrl;
  }

  // void setApiToken(String? token){
  //   apiToken = token;
  // }
  //
  // String? getApiToken(){
  //   return apiToken;
  // }


}