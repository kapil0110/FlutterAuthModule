part of authentication_package;


class PMAPSplash extends StatefulWidget {
  //For Splash Screen
  final PMAPSplashConfigOptions? splashScreenConfigOptions;

  //For Login Screen
  final PMAPLoginConfigOptions? loginScreenConfigOptions;

  // //For Login Screen
  // final PMAPLoginConfigOptions? loginScreenConfigOptions;


  const PMAPSplash(
      {Key? key,
        this.loginScreenConfigOptions,
        required this.splashScreenConfigOptions,

      })
      : super(key: key);

  @override
  State<PMAPSplash> createState() => _PMAPSplashState();
}

class _PMAPSplashState extends State<PMAPSplash> {

  @override
  void initState() {
    super.initState();

/*-------------Add 2 seconds delay to call Authentication Api -------------*/
    Future.delayed(const Duration(seconds: 2), (){
      //Future method for calling Authentication Api
      authenticateToken();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> authenticateToken()async{
    String result = await ApiProvider().authenticate(widget.splashScreenConfigOptions!.apiToken);
    if(result != "None"){
      return widget.splashScreenConfigOptions!.onAuthenticated(result);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => PMAPLogin(
          loginScreenConfigOptions: PMAPLoginConfigOptions(),
          logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
          onLogin: widget.splashScreenConfigOptions!.onLogin,
          onForgotPassword: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PMAPForgotPassword(
                  logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
                  onLoginLink: () => Navigator.pop(context),
                  onForgotPassword: widget.splashScreenConfigOptions!.onForgotPassword))),
          onRegister: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => PMAPRegister(
              onRegister: widget.splashScreenConfigOptions!.onRegister,
              onLoginLink: () => Navigator.pop(context),
              logoUrl: "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg",
            )
          ))
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: widget.splashScreenConfigOptions!.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.splashScreenConfigOptions!.title!.isNotEmpty
                    ? Text(widget.splashScreenConfigOptions!.title!,
                          style: TextStyle(
                          fontSize: widget.splashScreenConfigOptions!.titleFontSize! < 20
                              || widget.splashScreenConfigOptions!.titleFontSize! > 40
                              ? 20 : widget.splashScreenConfigOptions!.titleFontSize,
                          color: widget.splashScreenConfigOptions!.titleFontColor,
                          fontWeight: widget.splashScreenConfigOptions!.titleFontWeight,
                          fontStyle: widget.splashScreenConfigOptions!.titleFontStyle,
                          decoration: widget.splashScreenConfigOptions!.titleUnderline
                              ? TextDecoration.underline : TextDecoration.none,
                        )
                      )
                    : Container(),
                widget.splashScreenConfigOptions!.title!.isNotEmpty
                    ? SizedBox(height: SizeConfig.v10,)
                    : Container(),
                SvgPicture.network(
                  PMAPConstants.logoUrl!,
                  width: widget.splashScreenConfigOptions!.logoWidth,
                  height: widget.splashScreenConfigOptions!.logoHeight,
                ),
                SizedBox(height: SizeConfig.h20,),
                CircularProgressIndicator(color: PMAPConstants.baseThemeColor,)
              ],
            ),
          ),
        ));
  }
}
