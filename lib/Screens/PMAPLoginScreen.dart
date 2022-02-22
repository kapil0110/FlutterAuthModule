part of authentication_package;

class PMAPLogin extends StatefulWidget {
  final onForgotPassword;
  final Function(String?) onRegister;
  final Function(String?)? onGoogleLogin;
  final Function(String?)? onFacebookLogin;
  final Function(String?)? onTwitterLogin;
  final Function(String?) onLogin;
  final PMAPLoginConfigOptions? loginScreenConfigOptions;
  final PMAPRegisterConfigOptions? registerScreenConfigOptions;

  PMAPLogin({Key? key,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onRegister,
    this.onGoogleLogin,
    this.onFacebookLogin,
    this.onTwitterLogin,
    required this.loginScreenConfigOptions,
    required this.registerScreenConfigOptions,
  }) : super(key: key);




  @override
  _PMAPLoginState createState() => _PMAPLoginState();
}

class _PMAPLoginState extends State<PMAPLogin> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // late ProgressDialog pr;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userName = "";
  String? password = "";
  late bool result;
  late ProgressDialog pr;
  bool buttonClicked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ]
  );

  final FacebookAuth _fbAuth = FacebookAuth.instance;

  Map<String, String> socialData = {
    "displayName" : "",
    "email" : "",
    "mobile" : "",
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String?> getData()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()) {
      setState(() {
        buttonClicked = true;
      });
      pr.style(
        child: const CircularProgressIndicator(),
        // message: "Logging In",
      );
      pr.show();

      String? result = await ApiProvider().login(
          widget.loginScreenConfigOptions!.apiName, userName, password);
      if (result != "None") {
        // dynamic json = jsonDecode(result);
        if (pr.isShowing()) pr.hide();

        return widget.onLogin(result);
      } else {
        if (pr.isShowing()) pr.hide();
        setState(() {
          buttonClicked = false;
        });
        return widget.onLogin("");
      }
    }

  }

  Future<void> signInWithGoogle([bool link = false, AuthCredential? authCredential])async{

    try{
      // User? currentUser = _auth.currentUser;
      // if(currentUser == null) {
      if(await _googleSignIn.isSignedIn()){
        _googleSignIn.signOut();
        _auth.signOut();
      }
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      print("google token: ${googleSignInAuthentication.accessToken}");
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredentials = await _auth.signInWithCredential(
          credential);
      if(link){
        await userCredentials.user!.linkWithCredential(authCredential!);
        showDialog(
            context: context,
            builder: (BuildContext builderContext) {
              return AlertDialog(
                title: const Text("Success"),
                content: const Text("Account linked with new sign in method. You can now use new sign in method."),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () async {
                      Navigator.of(builderContext).pop();
                    },
                  )
                ],
              );
            });
      }else {
        Map<String, String> socialData = {};
        socialData["displayName"] = userCredentials.user!.displayName ?? "";
        socialData["email"] = userCredentials.user!.email ?? "";
        socialData["mobile"] = userCredentials.user!.phoneNumber ?? "";
        //Check if email already exists in database
        //if not go to register
        pr.show();

        String result = await ApiProvider().checkUser(
            {"email": socialData["email"]});
        dynamic data = jsonDecode(result);
        if (data["message"] == "Email exists") {
          if (pr.isShowing()) pr.hide();
          Fluttertoast.showToast(
            msg: "Email already registered. Please login using your credentials.",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          if (pr.isShowing()) pr.hide();
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PMAPExtraINfoScreen(
                  apiName: widget.registerScreenConfigOptions!.apiName!,
                  onGoogleLogin: widget.onGoogleLogin,
                  socialData: socialData,
                );
              }
          ));
        }
      }
      // else{
      //   print("already signed in: ${currentUser.email}");
      //   //Check if email in already in database
      //   //if present get password and call login api
      //   //if not go to register
      // }

    }catch(erro){
      print(erro);
    }
  }

  Future<void> signInWithFacebook()async{
    try {
      await _fbAuth.logOut();
      final LoginResult result = await _fbAuth.login();
      print("result: ${result.status}");
      print("facebook token: ${result.accessToken!.token}");
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          print("fcred: ${facebookCredential}");
          final userCredential =
          await _auth.signInWithCredential(facebookCredential);
          print(userCredential.user!.email);
          print(userCredential.user!.displayName);
          print(userCredential.user!.phoneNumber);

          Map<String, String> socialData = {};
          socialData["displayName"] = userCredential.user!.displayName ?? "";
          socialData["email"] = userCredential.user!.email ?? "";
          socialData["mobile"] = userCredential.user!.phoneNumber ?? "";
          //Check if email already exists in database
          //if not go to register
          pr.show();

          String result1 = await ApiProvider().checkUser(
              {"email": socialData["email"]});
          dynamic data = jsonDecode(result1);
          if (data["message"] == "Email exists") {
            if (pr.isShowing()) pr.hide();
            Fluttertoast.showToast(
              msg: "Email already registered. Please login using your credentials.",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
            );
          } else {
            if (pr.isShowing()) pr.hide();
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PMAPExtraINfoScreen(
                    apiName: widget.registerScreenConfigOptions!.apiName!,
                    onGoogleLogin: widget.onGoogleLogin,
                    socialData: socialData,
                  );
                }
            ));
          }

          break;
        case LoginStatus.cancelled:
          print("cancelled");
          if (pr.isShowing()) pr.hide();

          break;
        case LoginStatus.failed:
          print("failed");
          if (pr.isShowing()) pr.hide();

          Fluttertoast.showToast(
            msg: "Login Failed.",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
          break;
        default:
          break;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext builderContext) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("An account already exists with the same email address but different sign-in method."
                  "Click ok to link this sign in method to email address."),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () async {
                    Navigator.of(builderContext).pop();
                    print(e.code);
                    if (e.code == 'account-exists-with-different-credential') {
                      List<String> emailList = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(e.email!);
                      if (emailList.first == "google.com") {
                        await signInWithGoogle(true, e.credential);

                      }
                    }
                  },
                )
              ],
            );
          });

    }
  }

  Future<void> signInWithTwitter()async{
    print(TwitterKeys.apiKey);
    print(TwitterKeys.apiKeySecret);
    print(TwitterKeys.redirectUri);
    final twitterLogin = TwitterLogin(
      apiKey: TwitterKeys.apiKey,
      apiSecretKey: TwitterKeys.apiKeySecret,
      redirectURI: TwitterKeys.redirectUri,
    );

    try {
      final authResult = await twitterLogin.login();

      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          final AuthCredential twitterAuthCredential =
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!);

          final userCredential =
          await _auth.signInWithCredential(twitterAuthCredential);

          break;
        case TwitterLoginStatus.cancelledByUser:
          if (pr.isShowing()) pr.hide();
          print("cancelled");
          break;
        case TwitterLoginStatus.error:
          print("failed");
          if (pr.isShowing()) pr.hide();
          Fluttertoast.showToast(
            msg: "Login Failed.",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
          break;
        default:
          break;
      }
    }on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext builderContext) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("An account already exists with the same email address but different sign-in method."
                  "Click ok to link this sign in method to email address."),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () async {
                    Navigator.of(builderContext).pop();
                    print(e.code);
                    if (e.code == 'account-exists-with-different-credential') {
                      List<String> emailList = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(e.email!);
                      if (emailList.first == "google.com") {
                        await signInWithGoogle(true, e.credential);

                      }
                    }
                  },
                )
              ],
            );
          });

    }
  }


  Widget getSocialButton(button){
    if(button == SocialMediaTypes.google){
      return GestureDetector(
        onTap: ()async{
          await signInWithGoogle();
        },
        child: SizedBox(
          height: SizeConfig.h10,
          width: SizeConfig.h10,
          child: Image.asset("assets/google.png", package: "authentication_package", fit: BoxFit.contain,),
        ),
      );
    }
    if(button == SocialMediaTypes.facebook){
      return GestureDetector(
        onTap: ()async{
          await signInWithFacebook();
        },
        child: SizedBox(
          height: SizeConfig.h10,
          width: SizeConfig.h10,
          child: Image.asset("assets/facebook.png", package: "authentication_package", fit: BoxFit.contain,),
        ),
      );
    }
    if(button == SocialMediaTypes.twitter){
      return GestureDetector(
        onTap: ()async{
          await signInWithTwitter();
        },
        child: SizedBox(
          height: SizeConfig.h10,
          width: SizeConfig.h10,
          child: Image.asset("assets/twitter.png", package: "authentication_package", fit: BoxFit.contain,),
        ),
      );
    }

    return Container();

  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: widget.loginScreenConfigOptions!.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                    SvgPicture.network(PMAPConstants.logoUrl!, height: 120, width: 130,),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                    Text(widget.loginScreenConfigOptions!.title!,
                      style: TextStyle(
                          fontSize: widget.loginScreenConfigOptions!.titleFontSize!,
                          fontWeight: widget.loginScreenConfigOptions!.titleFontWeight!,
                          fontStyle: widget.loginScreenConfigOptions!.titleFontStyle!,
                          decoration: widget.loginScreenConfigOptions!.titleUnderline
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                    TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Email Id",
                          labelText: "Email Id",
                          labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                          )
                      ),
                      onChanged: (value){
                        setState(() {
                          userName = value;
                        });
                      },
                      validator: (value) => MyValidator.validateEmail(value),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 3,),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Password",
                          labelText: "Password",
                          labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                          )
                      ),
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) => MyValidator.validatePassword(value),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                    MaterialButton(
                      onPressed: getData,
                      child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      color: buttonClicked ? Colors.grey[400]: PMAPConstants.baseThemeColor,
                      height: 55,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 3,),
                    InkWell(
                        onTap: (){
                          userNameController.clear();
                          passwordController.clear();
                          widget.onForgotPassword();
                        },
                        child: Text("Forgot Password?", style: TextStyle(fontSize: 18, color: PMAPConstants.baseThemeColor, decoration: TextDecoration.underline),)),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 4,),
                    PMAPConstants.socialMedias!.isNotEmpty
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(PMAPConstants.socialMedias!.length,
                              (index) => getSocialButton(PMAPConstants.socialMedias!.elementAt(index))),
                    ) : Container(),
                    Expanded(child: Container(),),
                    Container(height: 2, width: MediaQuery.of(context).size.width, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: RichText(
                        text: TextSpan(
                            text: "Don't Have an Account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "CREATE ACCOUNT",
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    userNameController.clear();
                                    passwordController.clear();
                                    print("dskhfbds");
                                    widget.onRegister;
                                  },
                                  style: TextStyle(color: PMAPConstants.baseThemeColor, decoration: TextDecoration.underline)
                              )
                            ]
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}