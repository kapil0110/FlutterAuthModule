part of authentication_package;

class PMAPSplashConfigOptions{


  //Optional fields

  //For Splash Screen
  final Color? backgroundColor;

  //App title customzation fields
  final String? title;
  final double? titleFontSize;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final FontStyle? titleFontStyle;
  final bool titleUnderline;

  PMAPSplashConfigOptions({
    this.backgroundColor = Colors.white,
    this.title = "",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
});
}