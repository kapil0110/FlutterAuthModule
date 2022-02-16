part of authentication_package;

class PMAPLogin extends StatefulWidget {
  final String? logoUrl;
  final onForgotPassword;
  final onRegister;
  final Function(String?) onLogin;
  final PMAPLoginConfigOptions? loginScreenConfigOptions;

  PMAPLogin({Key? key,
    required this.logoUrl,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onRegister,
    required this.loginScreenConfigOptions,
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
      pr.style(
        child: const CircularProgressIndicator(),
        // message: "Logging In",
      );
      pr.show();

      String? result = await ApiProvider().login(userName, password);
      if (result != "None") {
        // dynamic json = jsonDecode(result);
        if (pr.isShowing()) pr.hide();

        return widget.onLogin(result);
      } else {
        if (pr.isShowing()) pr.hide();

        return widget.onLogin("");
      }
    }

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
                          labelText: "Password"
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
                      color: PMAPConstants.baseThemeColor,
                      height: 55,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 3,),
                    InkWell(
                        onTap: widget.onForgotPassword,
                        child: Text("Forgot Password?", style: TextStyle(fontSize: 18, color: PMAPConstants.baseThemeColor, decoration: TextDecoration.underline),)),
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
                                  recognizer: TapGestureRecognizer()..onTap = widget.onRegister,
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