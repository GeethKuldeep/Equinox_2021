import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/authentication.dart';


class HomePage extends StatelessWidget {


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth=Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed:(){
              _signOut(context);
            },
          ),
        ],
      ),
      body: Row(
          children: [
            SizedBox(height: 50),
            Container(
              child: Text('Hey participant...you have successfully signed in',textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: Colors.lightGreenAccent,
            ),
        ],

      ),

      );
  }
}