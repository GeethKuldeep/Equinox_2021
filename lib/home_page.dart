import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage(@required this.onsign_out);
  final VoidCallback onsign_out;

  Future<void> _SignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onsign_out();
    }catch(e){
      print(e.string());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("U are in")),
        actions: [
          FlatButton(
            child: Text('Logout',style: TextStyle(fontSize: 18.0,color: Colors.white),),
            onPressed: (){
              _SignOut();
            },

          )
        ],
      ),
    );
  }
}
