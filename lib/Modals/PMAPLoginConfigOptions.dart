part of authentication_package;

class PMAPLoginConfigOptions{

  final Color? backgroundColor;
  //App title customzation fields
  final String? title;
  final double? titleFontSize;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final FontStyle? titleFontStyle;
  final bool titleUnderline;


  PMAPLoginConfigOptions({

    this.backgroundColor = Colors.white,
    this.title = "Sign In To Your Account",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.bold,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
  });


}