// import 'dart:convert';
//
// import 'package:authentication_package/Network/ApiProvider.dart';
// import 'package:authentication_package/Utils/sizeConfig.dart';
// import 'package:authentication_package/authentication_package.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
//
// class GoogleLoginButton extends StatelessWidget {
//   final onGoogleLogin;
//   final String apiName;
//
//   const GoogleLoginButton({
//     Key? key,
//     required this.onGoogleLogin,
//     required this.apiName
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);
//     pr.style(message: "Please wait", child: const CircularProgressIndicator());
//
//
//     return GestureDetector(
//       onTap: ()async{
//         final FirebaseAuth _auth = FirebaseAuth.instance;
//         final GoogleSignIn _googleSignIn = GoogleSignIn(
//             scopes: [
//               'email',
//             ]
//         );
//
//         try{
//           // User? currentUser = _auth.currentUser;
//           // if(currentUser == null) {
//           if(await _googleSignIn.isSignedIn()){
//             _googleSignIn.signOut();
//             _auth.signOut();
//           }
//           final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//           final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;
//           final AuthCredential credential = GoogleAuthProvider.credential(
//             accessToken: googleSignInAuthentication.accessToken,
//             idToken: googleSignInAuthentication.idToken,
//           );
//           UserCredential userCredentials = await _auth.signInWithCredential(
//               credential);
//           Map<String, String> socialData = {};
//           socialData["displayName"] = userCredentials.user!.displayName ?? "";
//           socialData["email"] = userCredentials.user!.email ?? "";
//           socialData["mobile"] = userCredentials.user!.phoneNumber ?? "";
//           //Check if email already exists in database
//           //if not go to register
//           pr.show();
//
//           String result = await ApiProvider().checkUser({"email" : socialData["email"]});
//           dynamic data = jsonDecode(result);
//           if(data["message"] == "Email exists"){
//             if(pr.isShowing()) pr.hide();
//             Fluttertoast.showToast(
//               msg: "Email already registered. Please login using your credentials.",
//               backgroundColor: Colors.redAccent,
//               textColor: Colors.white,
//               gravity: ToastGravity.BOTTOM,
//               toastLength: Toast.LENGTH_LONG,
//             );
//           }else {
//             if(pr.isShowing()) pr.hide();
//             Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return PMAPExtraINfoScreen(
//                     apiName: apiName,
//                     onGoogleLogin: onGoogleLogin,
//                     socialData: socialData,
//                   );
//                 }
//             ));
//           }
//
//           // else{
//           //   print("already signed in: ${currentUser.email}");
//           //   //Check if email in already in database
//           //   //if present get password and call login api
//           //   //if not go to register
//           // }
//
//         }catch(erro){
//           print(erro);
//         }
//       },
//       child: SizedBox(
//         height: SizeConfig.h10,
//         width: SizeConfig.h10,
//         child: Image.asset("assets/google.png", package: "authentication_package", fit: BoxFit.contain,),
//       ),
//     );
//   }
// }
