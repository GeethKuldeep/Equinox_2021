import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/widgets/Email_Signin_form.dart';

class EmailSigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const color = const Color(0xff0E1C36);
    var color1 = const Color(0xffFBD00D);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Image(image: AssetImage('images/Equinox Logo-02 4.png'),
                width: 350,
                height: 350,
              ),
              Divider(
                  color: color1,
                thickness: 6,
              ),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: EmailSignInForm(),
                  )
              ),
            ],
          )),
      backgroundColor: color,
    );
  }
}
