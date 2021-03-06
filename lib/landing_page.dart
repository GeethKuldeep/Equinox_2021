

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/home_page.dart';
import 'package:google_sigin/services/authentication.dart';
import 'package:google_sigin/sign_in/email_sigin_page.dart';
//import 'package:google_sigin/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final auth =FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user != null) {
              print('HomePage called 2');
              return HomePage();
            }
            return EmailSigninPage();
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