part of authentication_package;

class PMAPSplashConfigOptions{
  //Mandatory fields

  final String? apiToken;
  final double? logoHeight;
  final double? logoWidth;
  final Function(String?) onAuthenticated;
  final Function(String?) onLogin;
  final Function(String?) onForgotPassword;
  final Function(String?) onRegister;

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
    required this.apiToken,
    required this.logoHeight,
    required this.logoWidth,
    required this.onAuthenticated,
    required this.onLogin,
    required this.onRegister,
    required this.onForgotPassword,

    this.backgroundColor = Colors.white,
    this.title = "",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
});
}