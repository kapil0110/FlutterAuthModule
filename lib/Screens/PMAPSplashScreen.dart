part of authentication_package;


class PMAPSplash extends StatefulWidget {
  //Mandatory fields

  final String? apiToken;
  final double? logoHeight;
  final double? logoWidth;

  final Function(String?) onAuthenticated;
  final Function(String?) onLogin;
  final Function(String?) onForgotPassword;
  final Function(String?) onRegister;
  final Function(String?)? onGoogleLogin;

  //For Splash Screen
  final PMAPSplashConfigOptions? splashScreenConfigOptions;

  //For Login Screen
  final PMAPLoginConfigOptions? loginScreenConfigOptions;

  // //For Register Screen
  final PMAPRegisterConfigOptions? registerScreenConfigOptions;

  // For Forgot Password Screen
  final PMAPForgotPasswordConfigOptions? forgotPasswordScreenConfigOptions;


  const PMAPSplash(
      {Key? key,
        required this.loginScreenConfigOptions,
        required this.splashScreenConfigOptions,
        required this.registerScreenConfigOptions,
        required this.forgotPasswordScreenConfigOptions,
        required this.onAuthenticated,
        this.onGoogleLogin,
        required this.onLogin,
        required this.onRegister,
        required this.onForgotPassword,
        required this.apiToken,
        required this.logoHeight,
        required this.logoWidth,

      })
      : super(key: key);

  @override
  State<PMAPSplash> createState() => _PMAPSplashState();
}

class _PMAPSplashState extends State<PMAPSplash> {

  @override
  void initState() {
    super.initState();
    HelperMethods().init(context);
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
    String result = await ApiProvider().authenticate(widget.splashScreenConfigOptions!.apiName, widget.apiToken);
    if(result != "None"){
      return widget.onAuthenticated(result);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => PMAPLogin(
          loginScreenConfigOptions: PMAPLoginConfigOptions(
            apiName: widget.loginScreenConfigOptions!.apiName,
          ),
          registerScreenConfigOptions: widget.registerScreenConfigOptions,
          onLogin: widget.onLogin,
          onGoogleLogin: widget.onGoogleLogin,
          onForgotPassword: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PMAPForgotPassword(
                  onLoginLink: () => Navigator.pop(context),
                  onForgotPassword: widget.onForgotPassword,
                  forgotPasswordConfigOptions: widget.forgotPasswordScreenConfigOptions,
              ))),
          onRegister: (value) => Navigator.push(context, MaterialPageRoute(
          builder: (context) => PMAPRegister(
            onRegister: widget.onRegister,
            onLoginLink: () => Navigator.pop(context),
            registerScreenConfigOptions: widget.registerScreenConfigOptions,
            // socialData: {},
          )
      )),
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
                  width: widget.logoWidth,
                  height: widget.logoHeight,
                ),
                SizedBox(height: SizeConfig.h20,),
                CircularProgressIndicator(color: PMAPConstants.baseThemeColor,)
              ],
            ),
          ),
        ));
  }
}
