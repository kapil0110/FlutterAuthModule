library authentication_package;
import 'dart:convert';

import 'package:authentication_package/Classes/TwitterKeys.dart';
import 'package:authentication_package/Network/ApiProvider.dart';
import 'package:authentication_package/Utils/PMAPConfigOptions.dart';
import 'package:authentication_package/Utils/PMAPConstants.dart';
import 'package:authentication_package/Utils/MyValidator.dart';
import 'package:authentication_package/Utils/helperMethods.dart';
import 'package:authentication_package/Utils/sizeConfig.dart';
import 'package:authentication_package/widgets/GoogleLoginButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:twitter_login/twitter_login.dart';


part 'Screens/PMAPSplashScreen.dart';
part 'Screens/PMAPLoginScreen.dart';
part 'Screens/PMAPForgotPassword.dart';
part 'Screens/PMAPRegisterScreen.dart';
part 'Modals/PMAPLoginConfigOptions.dart';
part 'Modals/PMAPSplashConfigOptions.dart';
part 'Modals/PMAPRegisterConfigOptions.dart';
part 'Modals/PMAPForgotPasswordConfigOptions.dart';
part 'Classes/SocialMediaTypes.dart';
part 'Screens/PMAPExtraInfoScreen.dart';
// part 'Modals/PMAPSocialLoginOptions.dart';

