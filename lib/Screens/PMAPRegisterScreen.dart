part of authentication_package;

class PMAPRegister extends StatefulWidget {
  final String? logoUrl;
  final Function(String?) onRegister;
  final onLoginLink;

  const PMAPRegister({Key? key,
    required this.logoUrl,
    required this.onLoginLink,
    required this.onRegister,
  }) : super(key: key);

  @override
  _PMAPRegisterState createState() => _PMAPRegisterState();
}

class _PMAPRegisterState extends State<PMAPRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late ProgressDialog pr;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool termsConditions = false;
  late ProgressDialog pr;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    countryCodeController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String?> registerUser()async{
      FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate()) {
      if (termsConditions) {
        pr.style(
          child: const CircularProgressIndicator(),
          // message: "Logging In",
        );
        pr.show();
        Map<String, dynamic> data = {};
        List<String> split = fullNameController.text.toString().split(" ");
        data["first_name"] = split.elementAt(0);
        data["last_name"] = split.elementAt(1);
        data["email"] = emailController.text;
        data["country_code"] =
            countryCodeController.text;
        data["mobile_number"] =
            mobileController.text;
        data["password"] = passwordController.text;
        data["password_confirmation"] = passwordController.text;
        data["intrest"] = "Both";

        String? result = await ApiProvider().register(data);
        if (result != "None") {
          if (pr.isShowing()) pr.hide();

          return widget.onRegister(result);
        } else {
          if (pr.isShowing()) pr.hide();
          return widget.onRegister("");
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please accept Terms & Conditions!",
          backgroundColor: PMAPConstants.baseThemeColor,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                SvgPicture.network(widget.logoUrl!, height: (MediaQuery.of(context).size.height / 100) * 5,),
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                const Text("Create Your Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),),
                const Text("All fields are mandatory", style: TextStyle(fontSize: 16,),),
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 3,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fullNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "First and Last Name",
                                // labelText: "Full Name"
                            ),
                            validator: (value) => MyValidator.validateNameField(value),
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Email ID",
                                labelText: "Email ID"
                            ),
                            validator: (value) => MyValidator.validateEmail(value),
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextFormField(
                                  controller: countryCodeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Code",
                                      labelText: "Code"
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty) {
                                      return "Country code can not be empty";
                                    }
                                    if(value.length > 6) {
                                      return "Country code can not be more than 6 digits";
                                    }

                                  },
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: TextFormField(
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Mobile number",
                                      labelText: "Mobile number"
                                  ),
                                  validator: (value) => MyValidator.validateMobile(value),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Password",
                                labelText: "Password"
                            ),
                            validator: (value) => MyValidator.validatePassword(value),
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          CheckboxListTile(
                              value: termsConditions,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: RichText(
                                text: const TextSpan(
                                    text: "I agree to all the ",
                                    style: TextStyle(color: Colors.black,),
                                    children: [
                                      TextSpan(
                                          text: "Terms & Privacy policy",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
                                      )
                                    ]
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  termsConditions = value!;
                                });
                              }),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          MaterialButton(
                            onPressed: registerUser,
                            child: const Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            color: PMAPConstants.baseThemeColor,
                            height: 55,
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minWidth: MediaQuery.of(context).size.width,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 2, width: MediaQuery.of(context).size.width, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: RichText(
                    text: TextSpan(
                        text: "Already Have an Account? ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: "SIGN IN",
                              recognizer: TapGestureRecognizer()..onTap = widget.onLoginLink,
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
    );
  }
}