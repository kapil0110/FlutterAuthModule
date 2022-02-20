part of authentication_package;

class PMAPRegister extends StatefulWidget {
  final onRegister;
  final onLoginLink;
  final PMAPRegisterConfigOptions? registerScreenConfigOptions;
  // final Map<String, String> socialData;

  const PMAPRegister({Key? key,
    required this.onLoginLink,
    required this.onRegister,
    required this.registerScreenConfigOptions,
    // required this.socialData,
  }) : super(key: key);

  @override
  _PMAPRegisterState createState() => _PMAPRegisterState();
}

class _PMAPRegisterState extends State<PMAPRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late ProgressDialog pr;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool termsConditions = false;
  bool isVisible = false;
  bool buttonClicked = false;
  late ProgressDialog pr;
  final _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    // print(widget.socialData);
    _focusNode.addListener(() {
      print(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
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
        setState(() {
          buttonClicked = true;
        });
        pr.style(
          child: const CircularProgressIndicator(),
          // message: "Logging In",
        );
        pr.show();
        Map<String, dynamic> data = {};
        List<String> split = fullNameController.text.toString().split(" ");
        data["first_name"] = firstNameController.text;
        data["last_name"] = lastNameController.text;
        data["email"] = emailController.text;
        data["country_code"] =
            countryCodeController.text;
        data["mobile_number"] =
            mobileController.text;
        data["password"] = passwordController.text;
        data["password_confirmation"] = passwordController.text;
        data["intrest"] = "Both";

        String? result = await ApiProvider().register(widget.registerScreenConfigOptions!.apiName, data);
        // await Future.delayed(const Duration(seconds: 2));

        if (result != "None") {
          print(result);

          if (pr.isShowing()) pr.hide();
          return widget.onRegister(result);
        } else {
          print("sdfds");
          pr.hide();
          setState(() {
            buttonClicked = false;
          });
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
          decoration: BoxDecoration(
            color: widget.registerScreenConfigOptions!.backgroundColor,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                SvgPicture.network(PMAPConstants.logoUrl!,
                  height: (MediaQuery.of(context).size.height / 100) * 10,),
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                Text(widget.registerScreenConfigOptions!.title!,
                    style: TextStyle(
                      fontSize: widget.registerScreenConfigOptions!.titleFontSize! < 20
                          || widget.registerScreenConfigOptions!.titleFontSize! > 40
                          ? 20 : widget.registerScreenConfigOptions!.titleFontSize,
                      color: widget.registerScreenConfigOptions!.titleFontColor,
                      fontWeight: widget.registerScreenConfigOptions!.titleFontWeight,
                      fontStyle: widget.registerScreenConfigOptions!.titleFontStyle,
                      decoration: widget.registerScreenConfigOptions!.titleUnderline
                          ? TextDecoration.underline : TextDecoration.none,
                    )                ),
                SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                const Text("All fields are mandatory", style: TextStyle(fontSize: 16,),),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.v3,),
                          Row(
                            children: [
                              Expanded(
                                child: Focus(
                                  onFocusChange: (hasFocus){
                                    print(hasFocus);
                                  },
                                  child: TextFormField(
                                    controller: firstNameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        hintText: "First Name",
                                        labelText: "First Name",
                                        labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                        )
                                    ),
                                    validator: (value) => MyValidator.validateNameField(value),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Last Name",
                                      labelText: "Last Name",
                                      labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                      )
                                  ),
                                  validator: (value) => MyValidator.validateNameField(value),
                                ),
                              ),
                            ],
                          ),

                          // TextFormField(
                          //   controller: fullNameController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: InputDecoration(
                          //       border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10)
                          //       ),
                          //       hintText: "First and Last Name",
                          //       labelText: "First and Last Name",
                          //       labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                          //       )
                          //   ),
                          //   validator: (value) => MyValidator.validateNameField(value),
                          // ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Email ID",
                                labelText: "Email ID",
                                labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                )
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
                                      labelText: "Code",
                                      labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                      )
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
                                      labelText: "Mobile number",
                                      labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                      )
                                  ),
                                  validator: (value) => MyValidator.validateMobile(value),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !isVisible,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Password",
                                labelText: "Password",
                                labelStyle: TextStyle(color: PMAPConstants.baseThemeColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PMAPConstants.baseThemeColor!)
                                ),
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: isVisible
                                    ? Icon(Icons.visibility, color: PMAPConstants.baseThemeColor,)
                                    : Icon(Icons.visibility_off, color: PMAPConstants.baseThemeColor,),
                              )
                            ),
                            validator: (value) => MyValidator.validatePassword(value),
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                          CheckboxListTile(
                              value: termsConditions,
                              controlAffinity: ListTileControlAffinity.leading,
                              checkColor: Colors.white,
                              activeColor: PMAPConstants.baseThemeColor,
                              title: RichText(
                                text: TextSpan(
                                    text: "I agree to all the ",
                                    style: const TextStyle(color: Colors.black,),
                                    children: [
                                      TextSpan(
                                          text: "Terms & Privacy policy",
                                          style: TextStyle(color: PMAPConstants.baseThemeColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
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
                            color: buttonClicked ? Colors.grey[400]: PMAPConstants.baseThemeColor,
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