part of authentication_package;

class PMAPExtraINfoScreen extends StatefulWidget {
  final onGoogleLogin;
  final Map<String, String> socialData;
  final String? apiName;

  const PMAPExtraINfoScreen({Key? key,
    required this.onGoogleLogin,
    required this.socialData,
    required this.apiName,
  }) : super(key: key);

  @override
  _PMAPExtraINfoScreenState createState() => _PMAPExtraINfoScreenState();
}

class _PMAPExtraINfoScreenState extends State<PMAPExtraINfoScreen> {
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
  late ProgressDialog pr;
  final _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    print(widget.socialData);
    if(widget.socialData["displayName"]!.isNotEmpty){
      List<String> split = widget.socialData["displayName"]!.split(" ");
      firstNameController.text = split[0];
      lastNameController.text = split[1];
    }
    if(widget.socialData["email"]!.isNotEmpty){
      emailController.text = widget.socialData["email"]!;
    }
    if(widget.socialData["mobile"]!.isNotEmpty){
      mobileController.text = widget.socialData["mobile"]!;
    }
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

        String? result = await ApiProvider().register(widget.apiName, data);
        if (result != "None") {
          if (pr.isShowing()) pr.hide();
          return widget.onGoogleLogin(result);
        } else {
          if (pr.isShowing()) pr.hide();
          return widget.onGoogleLogin("");
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
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                  SvgPicture.network(PMAPConstants.logoUrl!,
                    height: (MediaQuery.of(context).size.height / 100) * 10,),
                  SizedBox(height: (MediaQuery.of(context).size.height / 100) * 2,),
                  Text("Please fill the remaining details to gain access to App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: PMAPConstants.baseThemeColor,
                      )
                  ),
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
                                      enabled: widget.socialData["displayName"]!.isNotEmpty ? false : true,
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
                                    enabled: widget.socialData["displayName"]!.isNotEmpty ? false : true,
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
                              enabled: widget.socialData["email"]!.isNotEmpty ? false : true,
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
                                    enabled: widget.socialData["mobile"]!.isNotEmpty ? false : true,

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
                                    enabled: widget.socialData["mobile"]!.isNotEmpty ? false : true,
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
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.pop(context);
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
    );
  }
}