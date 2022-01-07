import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opdoc/Classes/models.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  Function _status;
  Register(this._status);
  @override
  State<Register> createState() => _RegisterState(_status);
}

class _RegisterState extends State<Register> {
  Function _status;
  _RegisterState(this._status);
  bool _showPassword = true;
  bool _invalid = false;
  bool _exists = false;
  String accounttype;
  List accounts = ['General', 'Professional'];
  final name = TextEditingController();
  final email = TextEditingController();
  final phone_no = TextEditingController();
  final city = TextEditingController();
  final hospital = TextEditingController();
  final designation = TextEditingController();
  final password = TextEditingController();
  final confirmation = TextEditingController();

  bool validDetails() {
    if (name.text == '' ||
        email.text == '' ||
        phone_no.text == '' ||
        city.text == '' ||
        password.text == '' ||
        confirmation.text == '' ||
        accounttype == null) {
      setState(() {
        _invalid = true;
      });

      return false;
    }
    if (accounttype == 'Professional') {
      if (name.text == '' || designation.text == '') {
        setState(() {
          print('2');
          _invalid = true;
        });
        return false;
      }
    }
    return true;
  }

  register() async {
    _invalid = _exists = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (validDetails()) {
      final details = {
        "account": accounttype,
        "name": name.text,
        "phone number": phone_no.text,
        "email": email.text,
        'city': city.text,
        "password": password.text,
        "confirmation": confirmation.text,
        'designation': designation.text,
        'hospital': hospital.text
      };
      final response = await http.post(register_url, body: details);
      var result = await json.decode(response.body);
      if (result['status'] == false) {
        setState(() {
          _invalid = true;
        });
      } else if (result['exist'] == true) {
        setState(() {
          _exists = true;
        });
      } else {
 
        _invalid = false;
        prefs.setString('my_id', result['id']);
        prefs.setString('user_name', result['name']);
        prefs.setString('accounttype', accounttype);
        Navigator.pop(context);
        _status();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 120),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 0,
                ),
                Container(
                  width: 290,
                  height: 60,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8)),
                    hint: Text('Select Account Type'),
                    value: accounttype,
                    onChanged: (newvalue) {
                      setState(() {
                        accounttype = newvalue;
                      });
                    },
                    items: accounts.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                            label: Text("Name"), border: OutlineInputBorder())),
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder())),
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: phone_no,
                        decoration: InputDecoration(
                            label: Text("Phone no"),
                            border: OutlineInputBorder())),
                  ),
                ),
                accounttype == 'Professional'
                    ? Container(
                        width: 300,
                        height: 60,
                        child: Card(
                          elevation: 3,
                          child: TextField(
                              controller: hospital,
                              decoration: InputDecoration(
                                  label: Text("Hospital Name"),
                                  border: OutlineInputBorder())),
                        ),
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: city,
                        decoration: InputDecoration(
                            label: Text("City"), border: OutlineInputBorder())),
                  ),
                ),
                accounttype == 'Professional'
                    ? Container(
                        width: 300,
                        height: 60,
                        child: Card(
                          elevation: 3,
                          child: TextField(
                              controller: designation,
                              decoration: InputDecoration(
                                  label: Text("Designation"),
                                  border: OutlineInputBorder())),
                        ),
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: password,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: () => {
                                setState(() => {_showPassword = !_showPassword})
                              },
                            ))),
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  child: Card(
                    elevation: 3,
                    child: TextField(
                        controller: confirmation,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                            label: Text("Confirm Password"),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: () => {
                                setState(() => {_showPassword = !_showPassword})
                              },
                            ))),
                  ),
                ),
                Container(
                  child: _invalid
                      ? Text(
                          'Fill the valid Details!',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        )
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                ),
                Container(
                  child: _exists
                      ? Text(
                          'Account Exists!',
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
                        onPressed: () {
                          register();
                        },
                        child: Text("Sign Up"))),
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Had an account?"),
                      TextButton(
                          child: Text('Sign in'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
