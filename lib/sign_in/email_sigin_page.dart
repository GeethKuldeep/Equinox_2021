import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/widgets/Email_Signin_form.dart';


class EmailSigninPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 10.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInForm(),
          )
      ),
      backgroundColor: Colors.grey[200],

      );
  }


}
