part of authentication_package;


class PMAPForgotPassword extends StatefulWidget {
  final String? logoUrl;
  final onLoginLink;
  final Function(String?) onForgotPassword;

  const PMAPForgotPassword({Key? key,
    required this.logoUrl,
    required this.onLoginLink,
    required this.onForgotPassword,
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

        String? result = await ApiProvider().resetPassword(data);
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
                      SvgPicture.network(widget.logoUrl!, height: 55, width: 55,),
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                      const Text("Reset Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),),
                      SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Email Id",
                            labelText: "Email Id"
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