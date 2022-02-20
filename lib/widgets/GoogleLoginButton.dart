import 'package:authentication_package/Utils/sizeConfig.dart';
import 'package:authentication_package/authentication_package.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends StatelessWidget {
  final onGoogleLogin;
  final String apiName;

  const GoogleLoginButton({
    Key? key,
    required this.onGoogleLogin,
    required this.apiName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final GoogleSignIn _googleSignIn = GoogleSignIn(
            scopes: [
              'email',
            ]
        );

        try{
          User? currentUser = _auth.currentUser;
          print("current user: ${currentUser!.displayName}");
          if(currentUser == null) {
            final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
            final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
            UserCredential userCredentials = await _auth.signInWithCredential(
                credential);
            Map<String, String> socialData = {};
            socialData["displayName"] = userCredentials.user!.displayName ?? "";
            socialData["email"] = userCredentials.user!.email ?? "";
            socialData["mobile"] = userCredentials.user!.phoneNumber ?? "";
            //Check if email in already  in database
            //if present get password and call login api
            //if not go to register

            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PMAPExtraINfoScreen(
                    apiName: apiName,
                    onGoogleLogin: onGoogleLogin,
                    socialData: socialData,
                  );
                }
            ));
          }else{
            print("already signed in: ${currentUser.email}");
            return onGoogleLogin(currentUser.email);
            //Check if email in already in database
            //if present get password and call login api
            //if not go to register
          }

        }catch(erro){
          print(erro);
        }
      },
      child: SizedBox(
        height: SizeConfig.h10,
        width: SizeConfig.h10,
        child: Image.asset("assets/google.png", package: "authentication_package", fit: BoxFit.contain,),
      ),
    );
  }
}
