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
  void authCurrentUser()async{
    user = await auth.currentUser();
  }

  bool verify =false;

  @override
  void initState(){
    authCurrentUser();

    timer= Timer.periodic(Duration(seconds: 5), (timer) {
      if(verify==false  &&  user !=null ){
        user.sendEmailVerification();
        print('email sent');
        verify =true;
      }

      checkEmailVerified();

    });
    super.initState();
  }


  Future<void> checkEmailVerified()async{

    user= await auth.currentUser();
    await user.reload();
    if(user.isEmailVerified && user != null){
      print('EMAIL VERIFIED');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please check your email'),
      ),
      body: Card(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(child: Text('Waiting for your email to be verified ')),
              SizedBox(height: 15),
              Center(child: CircularProgressIndicator()),

            ],
          ),
        ),
      )
    );
  }
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }
}
