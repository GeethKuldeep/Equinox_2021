
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/services/authentication.dart';
import 'package:provider/provider.dart';
import 'Email_Signin_Button.dart';
import 'email_verification.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {



  var _formkey =GlobalKey<FormState>();
  String confirmpassword = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _UsernameController = TextEditingController();
  final FocusNode _UsernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _password1FocusNode = FocusNode();
  final FocusNode _password2FocusNode = FocusNode();
  String get _Username => _UsernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  User authResult;


  void _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context);
      if (_formType == EmailSignInFormType.signIn) {
        authResult = await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(_email, _password);
        await Firestore.instance.collection('users').document(authResult.uid).setData({
          'username': _Username,
          'email': _email,
        });
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }



  void _UsernameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }
  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_password1FocusNode);
  }
  void _passwordEditingComplete(){
    FocusScope.of(context).requestFocus(_password2FocusNode);
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
          ? 'Login in'
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
              if(_formType == EmailSignInFormType.register)
              TextFormField(
                key: ValueKey("UseName"),
                validator: (value){
                  if (value.isEmpty){
                    return 'Enter your Name';
                  }
                  return null;
                },
                controller: _UsernameController,
                focusNode: _UsernameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Enter your Name',
                ),
                autocorrect: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onEditingComplete: _UsernameEditingComplete,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                key: ValueKey("email"),
                validator: (value){
                  if (value.isEmpty || !value.contains('@vitstudent.ac.in')){
                    return 'Please enter a valid email';
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
                key: ValueKey("password1"),
                validator: (value){
                  confirmpassword =value;
                  if (value.isEmpty || value.length<7){
                    return 'Password must be at least 7 characters long';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                controller: _passwordController,
                focusNode: _password1FocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: _passwordEditingComplete,
                obscureText: true,
              ),


              if(_formType == EmailSignInFormType.register)
                TextFormField(
                  key: ValueKey("password2"),
                  validator: (value){
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                    }
                      if(confirmpassword != value){
                        return 'Password not matched please enter again';
                      }
                    return null;
                  },
                  focusNode: _password2FocusNode,
                  decoration: InputDecoration(
                    labelText: 'Confirm your Password',
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onEditingComplete: _submit,
                ),


              SizedBox(height: 8.0),
              FormSubmitButton(
                text: primaryText,
                onPressed:(){
                    if (_formkey.currentState.validate() == true) {
                        _submit();
                      if (_formType == EmailSignInFormType.register) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Verified()));
                      }
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