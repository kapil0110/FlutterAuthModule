part of authentication_package;


class PMAPForgotPassword extends StatefulWidget {
  final onLoginLink;
  final Function(String?) onForgotPassword;
  final PMAPForgotPasswordConfigOptions? forgotPasswordConfigOptions;

  const PMAPForgotPassword({Key? key,
    required this.onLoginLink,
    required this.onForgotPassword,
    required this.forgotPasswordConfigOptions,
  }) : super(key: key);

  @override
  _PMAPForgotPasswordState createState() => _PMAPForgotPasswordState();
}

class _PMAPForgotPasswordState extends State<PMAPForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String? email = "";
  late ProgressDialog pr;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<String?> resetPassword()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()) {
        pr.style(
          child: const CircularProgressIndicator(),
          // message: "Logging In",
        );
        pr.show();
        Map<String, dynamic> data = {};
        data["email"] = emailController.text;

        String? result = await ApiProvider().resetPassword(widget.forgotPasswordConfigOptions!.apiName, data);
        if (result != "None") {
          if (pr.isShowing()) pr.hide();
          Navigator.pop(context);
          return widget.onForgotPassword(result);
        } else {
          if (pr.isShowing()) pr.hide();
          return widget.onForgotPassword("");
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
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.forgotPasswordConfigOptions!.backgroundColor,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 15,),
                      SvgPicture.network(PMAPConstants.logoUrl!, height: 55, width: 55,),
                      SizedBox(height: SizeConfig.v2),
                      Text(widget.forgotPasswordConfigOptions!.title!,
                        style: TextStyle(
                            fontSize: widget.forgotPasswordConfigOptions!.titleFontSize! < 24
                                || widget.forgotPasswordConfigOptions!.titleFontSize! > 54
                                ? 24 : widget.forgotPasswordConfigOptions!.titleFontSize,
                          fontWeight: widget.forgotPasswordConfigOptions!.titleFontWeight,
                          color: widget.forgotPasswordConfigOptions!.titleFontColor,
                          fontStyle: widget.forgotPasswordConfigOptions!.titleFontStyle,
                          decoration: widget.forgotPasswordConfigOptions!.titleUnderline
                              ? TextDecoration.underline : TextDecoration.none,
                        ),),
                      SizedBox(height: SizeConfig.v2,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.h4),
                        child: Text(widget.forgotPasswordConfigOptions!.subTitle!,
                          style: const TextStyle(fontSize: 18,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                      TextFormField(
                        controller: emailController,
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
                          email = value;
                        },
                        validator: (value) => MyValidator.validateEmail(value),
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                      MaterialButton(
                        onPressed: resetPassword,
                        child: const Text("Send Reset Password Link", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                        color: PMAPConstants.baseThemeColor,
                        height: 55,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 3,),
                      Expanded(child: Container(),),
                      Container(height: 2, width: MediaQuery.of(context).size.width, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child:InkWell(
                          onTap: widget.onLoginLink,
                          child: Text("BACK TO SIGN IN",
                            style: TextStyle(fontSize: 18, color: PMAPConstants.baseThemeColor, decoration: TextDecoration.underline),),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}