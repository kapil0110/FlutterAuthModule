part of authentication_package;

class PMAPLoginConfigOptions{
  final String? apiName;

  final double? logoHeight;
  final double? logoWidth;
  final Color? backgroundColor;
  //App title customzation fields
  final String? title;
  final double? titleFontSize;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final FontStyle? titleFontStyle;
  final bool titleUnderline;


  PMAPLoginConfigOptions({
    required this.apiName,

    this.logoHeight = 120,
    this.logoWidth = 120,
    this.backgroundColor = Colors.white,
    this.title = "Sign In To Your Account",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.bold,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
  });


}