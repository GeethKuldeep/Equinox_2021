import 'package:flutter/material.dart';
import 'package:google_sigin/services/authentication.dart';
import 'package:provider/provider.dart';
import 'Email_Signin_Button.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  var _formkey =GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }
  void _toggleFormType() {
      setState(() {
        _formType = _formType == EmailSignInFormType.signIn ?
        EmailSignInFormType.register : EmailSignInFormType.signIn;
      });
      _emailController.clear();
      _passwordController.clear();
    }


    @override
    Widget build(BuildContext context) {
      final primaryText = _formType == EmailSignInFormType.signIn
          ? 'Sign in'
          : 'Create an account';
      final secondaryText = _formType == EmailSignInFormType.signIn
          ? 'Need an account? Register'
          : 'Have an account? Sign in';
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: ValueKey("email"),
                validator: (value){
                  if (value.isEmpty || !value.contains('@vitstudent.ac.in')){
                    return 'Hey Asshole enter a valid email';
                  }
                  return null;
                },
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'xxxxx@vitstudent.ac.in',
                ),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,

                textInputAction: TextInputAction.next,
                onEditingComplete: _emailEditingComplete,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                key: ValueKey("password"),
                validator: (value){
                  if (value.isEmpty || value.length<7){
                    return 'Password must be at least 7 characters long';
                  }
                  return null;
                },
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                textInputAction: TextInputAction.done,
                obscureText: true,

                onEditingComplete: _submit,
              ),
              SizedBox(height: 8.0),
              FormSubmitButton(
                text: primaryText,
                onPressed:(){
                  if(_formkey.currentState.validate()== true){
                    return _submit();
                  }
                },
              ),
              SizedBox(height: 8.0),
              FlatButton(
                child: Text(secondaryText),
                onPressed: _toggleFormType,
              ),
            ],
          ),
        ),
      );
    }
}