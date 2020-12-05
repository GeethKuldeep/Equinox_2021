import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/home_page.dart';

class Verified extends StatefulWidget {
  @override
  _VerifiedState createState() => _VerifiedState();
}

class _VerifiedState extends State<Verified> {

  final auth =FirebaseAuth.instance;
  FirebaseUser user;
  Timer timer;

  @override
  void initState() async{
    user = await auth.currentUser();
    user.sendEmailVerification();
    timer= Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }
  Future<void> checkEmailVerified()async{
    user= await auth.currentUser();
    await user.reload();
    if(user.isEmailVerified){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Waiting for your email to be verified.PLease check your mail '),
          CircularProgressIndicator(),
        ],
      )
    );
  }
}
