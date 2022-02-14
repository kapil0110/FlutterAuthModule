part of authentication_package;


class SplashScreen extends StatelessWidget {
  final MaterialColor? backgroundColor;
  final String? logoUrl;
  final double? logoHeight;
  final double? logoWidth;

  const SplashScreen(
      {Key? key,
        this.backgroundColor,
        @required this.logoUrl,
        @required this.logoHeight,
        @required this.logoWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
          ),
          child: Center(
            child: SvgPicture.network(
              logoUrl!,
              width: logoWidth,
              height: logoHeight,
            ),
          ),
        ));
  }

}
