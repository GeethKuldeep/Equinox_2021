

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/home_page.dart';
import 'package:google_sigin/services/authentication.dart';

import 'package:google_sigin/sign_in/sign_in_page.dart';
import 'package:google_sigin/widgets/email_verification.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final auth =FirebaseAuth.instance;
  FirebaseUser geeth;

  void authCurrentUser()async{
    geeth = await auth.currentUser();
  }

  void initState(){
    authCurrentUser();
    super.initState();
  }

  Future<void> checkEmailVerified()async{
    geeth= await auth.currentUser();
    await geeth.reload();
    if(geeth.isEmailVerified){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
      print('EMAIL VERIFIED');
    }
  }


  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage();
            }
            return HomePage();
          }
          else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}