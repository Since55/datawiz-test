import 'package:flutter/material.dart';
import 'package:test_app_r/models/user.dart';
import 'package:test_app_r/util.dart' as util;
import 'package:test_app_r/api.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _login,
         _password;
  User user;


  @override
  Widget build(BuildContext context) {
    final _loginFocus = FocusNode();
    final _passwordFocus = FocusNode(); // to change focus after submitting login
    LoginApi loginApi = new LoginApi();
    // Login input field
    final login = TextFormField(
      focusNode: _loginFocus,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Login',
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.black45
              )
          )
      ),
      onChanged: (value){
        _login = value;
        print(_login);
      },
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _loginFocus, _passwordFocus);
      },
    );
// Password input field
    final password = TextFormField(
      focusNode: _passwordFocus,
      autofocus: false,
      obscureText: true, // to hide password
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.black45
              )
          )
      ),
      onChanged: (value){
        _password = value;
      },
      onFieldSubmitted: (value){
        _passwordFocus.unfocus();

      },
    );

    var invalidData = Text('');

    final loginButton = RaisedButton(
      color: Colors.lightBlue,
      textColor: Colors.white,
      child: Text('Login'),
      onPressed: (){
        _formKey.currentState.save();
        if(util.isNullEmpty(_login) || util.isNullEmpty(_password)) {
          print('empty');
        } else {
          loginApi.login(_login, _password);
          if(loginApi.isLoginSuccessful()) {
            Navigator.pushNamed(context, '/home');
          } else {
            invalidData = Text('Invalid login or password');
          }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  login,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: password,
                  ),
                  Row(
                    children: <Widget>[
                      loginButton,
                      invalidData
                    ],
                  )
                ],
              ),
            ),


          )

      );



  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}




//http://app2.test.planohero.com/api/auth/token/get/