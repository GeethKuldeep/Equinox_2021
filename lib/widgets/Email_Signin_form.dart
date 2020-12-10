
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _UsernameController = TextEditingController();
  final FocusNode _UsernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _password1FocusNode = FocusNode();
  String get _Username => _UsernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  User authResult;
  var color1 = const Color(0xffFBD00D);
  bool _passwordVisible;


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

      //Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  void initState() {
    _passwordVisible = false;
  }

  void _UsernameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }
  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_password1FocusNode);
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
          ? 'SIGN IN'
          : 'Create an account';
      final secondaryText = _formType == EmailSignInFormType.signIn
          ? 'Need an account? Register'
          : 'Have an account? Sign in';
      return Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(_formType == EmailSignInFormType.register)
                TextFormField(
                  style: TextStyle(color: color1),
                    cursorColor: Colors.white,
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
                    labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                    contentPadding: const EdgeInsets.all(8.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'UserName',
                    errorStyle: TextStyle(
                        color: color1,
                    ),

                  ),
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: _UsernameEditingComplete,
                  ),

              SizedBox(height: MediaQuery.of(context).size.width*0.07,),


             TextFormField(
               style: TextStyle(color:color1),
               cursorColor: Colors.white,
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
                 labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                 contentPadding: const EdgeInsets.all(8.0),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: Colors.white,
                     width: 2.0,
                   ),
                   borderRadius: BorderRadius.circular(12.0),
                 ),
                 labelText: 'Email ID',
                 errorStyle: TextStyle(
                   color: color1,
                 ),

               ),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: _emailEditingComplete,
                ),


              SizedBox(height: MediaQuery.of(context).size.width*0.07,),

              TextFormField(
                style: TextStyle(color: color1),
                  cursorColor: Colors.white,
                  key: ValueKey("password1"),
                  validator: (value){
                    if (value.isEmpty || value.length<7){
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                  contentPadding: const EdgeInsets.all(8.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'Password',
                  errorStyle: TextStyle(
                    color: color1,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                  controller: _passwordController,
                  focusNode: _password1FocusNode,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                  obscureText: !_passwordVisible,
                ),

              SizedBox(height: MediaQuery.of(context).size.width*0.07,),

              FormSubmitButton(
                text: primaryText,

                onPressed:(){
                    if (_formkey.currentState.validate() == true) {
                        _submit();
                      if (_formType == EmailSignInFormType.register) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Verified()));
                      }
                    }
                },
              ),


              SizedBox(height: MediaQuery.of(context).size.width*0.02,),


              FlatButton(
                child: Text(secondaryText,style: TextStyle(color: Colors.white),),
                onPressed: _toggleFormType,
              ),
            ],
          ),
        );

    }
}