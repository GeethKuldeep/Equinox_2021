import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/authentication.dart';
import 'landing_page.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context)=> Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Equinox2021',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: LandingPage(
        ),
      ),
    );
  }
}