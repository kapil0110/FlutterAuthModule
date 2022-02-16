part of authentication_package;


class PMAPSplash extends StatefulWidget {
  final MaterialColor? backgroundColor;
  final String? logoUrl;
  final String? apiToken;
  final double? logoHeight;
  final double? logoWidth;
  final Function(String?) onAuthenticated;
  final Function(String?) onForgotPassword;
  final Function(String?) onLogin;
  final Function(String?) onRegister;
  const PMAPSplash(
      {Key? key,
        this.backgroundColor,
        required this.logoUrl,
        required this.apiToken,
        required this.logoHeight,
        required this.logoWidth,
        required this.onAuthenticated,
        required this.onForgotPassword,
        required this.onLogin,
        required this.onRegister,
      })
      : super(key: key);

  @override
  State<PMAPSplash> createState() => _PMAPSplashState();
}

class _PMAPSplashState extends State<PMAPSplash> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){

      authenticateToken();

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> authenticateToken()async{
    String result = await ApiProvider().authenticate(widget.apiToken);
    if(result != "None"){
      return widget.onAuthenticated(result);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => PMAPLogin(
          logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
          onLogin: widget.onLogin,
          onForgotPassword: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PMAPForgotPassword(
                  logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
                  onLoginLink: () => Navigator.pop(context),
                  onForgotPassword: widget.onForgotPassword))),
          onRegister: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => PMAPRegister(
              onRegister: widget.onRegister,
              onLoginLink: () => Navigator.pop(context),
              logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
            )
          ))
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
          ),
          child: Center(
            child: SvgPicture.network(
              widget.logoUrl!,
              width: widget.logoWidth,
              height: widget.logoHeight,
            ),
          ),
        ));
  }
}
