import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;
  static late double horizontalBlockSize;
  static late double verticalBlockSize;
  static late double h2;
  static late double v2;
  static late double h3;
  static late double v3;
  static late double h4;
  static late double v4;
  static late double h5;
  static late double v5;
  static late double h6;
  static late double v6;
  static late double h7;
  static late double v7;
  static late double h8;
  static late double v8;
  static late double h9;
  static late double v9;
  static late double h10;
  static late double v10;
  static late double h15;
  static late double v15;
  static late double h20;
  static late double v20;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    horizontalBlockSize = screenWidth / 100;
    verticalBlockSize = screenHeight / 100;
    h2 = horizontalBlockSize * 2;
    v2 = verticalBlockSize * 2;
    h3 = horizontalBlockSize * 3;
    v3 = verticalBlockSize * 3;
    h4 = horizontalBlockSize * 4;
    v4 = verticalBlockSize * 4;
    h5 = horizontalBlockSize * 5;
    v5 = verticalBlockSize * 5;
    h6 = horizontalBlockSize * 6;
    v6 = verticalBlockSize * 6;
    h7 = horizontalBlockSize * 7;
    v7 = verticalBlockSize * 7;
    h8 = horizontalBlockSize * 8;
    v8 = verticalBlockSize * 8;
    h9 = horizontalBlockSize * 9;
    v9 = verticalBlockSize * 9;
    h10 = horizontalBlockSize * 10;
    v10 = verticalBlockSize * 10;
    h15 = horizontalBlockSize * 15;
    v15 = verticalBlockSize * 15;
    h20 = horizontalBlockSize * 20;
    v20 = verticalBlockSize * 20;
  }
}