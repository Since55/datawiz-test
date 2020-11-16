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

  var invalidData = Text('');

  final loginFocus = FocusNode();
  final passwordFocus = FocusNode(); // to change focus after submitting login
  final lgButtonFocus = FocusNode();

  @override
  Widget build(BuildContext context) {

    LoginApi loginApi = new LoginApi();
    // Login input field
    final login = TextFormField(
      focusNode: loginFocus,
      keyboardType: TextInputType.emailAddress,
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
        setState(() {
          _login = value;
          print('changed');
        });
//        _login = value;
        print(_login);
      },
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, loginFocus, passwordFocus);
      },
    );
// Password input field
    final password = TextFormField(
      focusNode: passwordFocus,
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
        setState(() {
          _password = value;
        });
      },
      onFieldSubmitted: (value){

        _fieldFocusChange(context, passwordFocus, lgButtonFocus);
      },
    );



    final loginButton = RaisedButton(
      splashColor: Colors.white,
      focusNode: lgButtonFocus,
      color: Colors.black,
      textColor: Colors.white,
      child: Text('Login'),
      onPressed: (){
        print('Logging in');
        _formKey.currentState.save();
        if(util.isNullEmpty(_login) || util.isNullEmpty(_password)) {
          print('empty');
          setState(() {
            invalidData = Text('Login and password can\'t be empty', style:
              TextStyle(
                fontSize: 15,
                color: Colors.deepOrange
              ),
            );
          });

        } else {
          loginApi.login(_login, _password, context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
      ),
      body:
          ListView(
            children: <Widget>[
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
                      invalidData,
                      loginButton,
                    ],
                  ),
                ),


              )
            ],
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