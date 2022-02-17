part of authentication_package;

class PMAPForgotPasswordConfigOptions{
  //Optional fields
  final Color? backgroundColor;

  //App title customzation fields
  final String? title;
  final String? subTitle;
  final double? titleFontSize;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final FontStyle? titleFontStyle;
  final bool titleUnderline;

  PMAPForgotPasswordConfigOptions({

    this.backgroundColor = Colors.white,
    this.title = "Reset Password",
    this.subTitle = "Enter your registered Email address and we will send you Password Reset link.",
    this.titleFontSize = 20,
    this.titleFontColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.titleFontStyle = FontStyle.normal,
    this.titleUnderline = false,
  });
}