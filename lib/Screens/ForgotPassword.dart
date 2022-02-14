part of authentication_package;


class ForgotPasswordScreen extends StatefulWidget {
  final String? logoUrl;
  final onLoginLink;
  final onForgotPassword;

  const ForgotPasswordScreen({Key? key,
    required this.logoUrl,
    required this.onLoginLink,
    required this.onForgotPassword,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  String? email = "";
  // late ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
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
                      // validator: (value) => MyValidator.validateEmail(value),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height / 100) * 5,),
                    MaterialButton(
                      onPressed: widget.onForgotPassword,
                      child: const Text("Send Reset Password Link", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      color: Constants.baseThemeColor,
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
                          style: TextStyle(fontSize: 18, color: Constants.baseThemeColor, decoration: TextDecoration.underline),),
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