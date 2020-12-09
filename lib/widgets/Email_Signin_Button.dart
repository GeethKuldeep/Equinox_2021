import 'package:flutter/material.dart';

import 'custom_raised_button.dart';


class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 17.0),
    ),
    height: 44.0,
    color: Colors.yellowAccent[700],
    borderRadius: 20.0,
    onPressed: onPressed,
  );
}