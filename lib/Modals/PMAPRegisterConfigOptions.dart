part of authentication_package;

class PMAPRegisterConfigOptions{
  //Optional fields
  final Color? backgroundColor;

  //App title customzation fields
  final String? apiName;

  final String? title;
  final double? titleFontSize;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final FontStyle? titleFontStyle;
  final bool titleUnderline;

  PMAPRegisterConfigOptions({
    required this.apiName,

    this.backgroundColor = Colors.white,
    this.title = "Create Your Account",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
  });
}