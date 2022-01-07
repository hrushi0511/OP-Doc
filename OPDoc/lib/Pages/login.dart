import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './register.dart';
import '../Classes/models.dart';

class Login extends StatefulWidget {
  Function _status;
  Login(this._status);
  @override
  State<Login> createState() => _LoginState(_status);
}

class _LoginState extends State<Login> {
  Function _status;
  bool invalid = false;
  _LoginState(this._status);
  bool _showPassword = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  logIn(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .post(login_url, body: {'email': email, 'password': password});
    var result = await json.decode(response.body);

    if (result['status'] == true) {
      invalid = false;
      prefs.setString('my_id', result['id']);
      prefs.setString('user_name', result['name']);
      prefs.setString('accounttype', result['account']);
      _status();
    } else {
      setState(() {
        invalid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 0,
          ),
          Container(width: 200, child: Image.asset('assets/images/Logo.png')),
          Container(
            margin: EdgeInsets.all(2),
            width: 300,
            height: 60,
            child: Card(
              elevation: 3,
              child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      label: Text("Email"), border: OutlineInputBorder())),
            ),
          ),
          Container(
            width: 300,
            height: 60,
            margin: EdgeInsets.all(2),
            child: Card(
              elevation: 3,
              child: TextField(
                controller: _password,
                obscureText: _showPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this._showPassword ? Colors.grey : Colors.blue,
                    ),
                    onPressed: () => {
                      setState(() => {_showPassword = !_showPassword})
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: invalid
                ? Text(
                    'Invalid Credentials!',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ),
          Container(
              width: 290,
              height: 45,
              margin: EdgeInsets.all(6),
              child: ElevatedButton(
                  onPressed: () => logIn(_email.text, _password.text),
                  child: Text("Log In"))),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  child: Text('Sign up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register(_status)),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
