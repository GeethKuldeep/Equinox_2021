import 'package:flutter/material.dart';

import 'authentication.dart';
import 'landing_page.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equinox2021',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}