import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/sign_in/sign_in_page.dart';

import 'home_page.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    FirebaseUser _user;

    _updateUser(FirebaseUser user){
      setState(() {
        _user=user;
      });
    }
    if(_user==null) {
      return SignInPage(_updateUser);
    }
    else {
      return HomePage(null);
    }
  }
}
