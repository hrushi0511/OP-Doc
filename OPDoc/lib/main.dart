//Dart library imports
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//Local Imports
import 'Pages/login.dart';
import 'Pages/appointments.dart';
import './Pages/home.dart';
import './Pages/profile.dart';
import './Pages/search.dart';
import 'Pages/doctorhome.dart';
import './Pages/doctorprofile.dart';
import '../Classes/models.dart';

//URLS for http requests
String my_id = '';
String user_name = '';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loginstatus = false;
  String account = '';

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('loginstatus');
    if (status == null) {
      prefs.setBool('loginstatus', false);
    }
    setState(() {
      _loginstatus = prefs.getBool('loginstatus');
      if (_loginstatus) {
        user_name = prefs.getString('user_name');
        my_id = prefs.getString('my_id');
        account = prefs.getString('accounttype');
      }
    });
  }

  _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_name = prefs.getString('user_name');
      my_id = prefs.getString('my_id');
      account = prefs.getString('accounttype');
      _loginstatus = true;
    });
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('my_id');
    prefs.remove('user_name');
    prefs.remove('accounttype');
    setState(() {
      user_name = prefs.getString('user_name');
      my_id = prefs.getString('my_id');
      account = prefs.getString('accounttype');
      _loginstatus = false;
    });
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _loginstatus && account == 'General'
          ? MyHomePage(_logout)
          : _loginstatus && account == 'Professional'
              ? DoctorPage(_logout)
              : Login(_login),
      // home:MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  Function logoutfunction;
  MyHomePage(this.logoutfunction);
  @override
  _MyHomePageState createState() => _MyHomePageState(logoutfunction);
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Function logoutfunction;
  _MyHomePageState(this.logoutfunction);
  // String my_id = '-Ms0uhrIStzivMSMbyhx';
  String searchvalue = '';
  final search_input = TextEditingController();

  _pageChange(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  _searchtext(String text) {
    setState(() {
      searchvalue = text;
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 1
          ? AppBar(
              title: Image.asset(
                'assets/images/Logo.png',
                width: 100,
                height: 100,
                color: Colors.white,
              ),
            )
          : AppBar(
              actions: [
                Container(
                  height: 10,
                    width: 390,
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      controller: search_input,
                      onChanged: (value) {
                        _searchtext(value);
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          label: Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                          suffix: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () =>
                                  {_searchtext(search_input.text)})),
                    ))
              ],
            ),
      body: _selectedIndex == 0
          ? Home(user_name, _pageChange)
          : _selectedIndex == 1 && searchvalue == ''
              ? Text('Search for Doctor')
              : _selectedIndex == 1 && searchvalue != ''
                  ? Searchbody(searchvalue, _pageChange, my_id)
                  : _selectedIndex == 2
                      ? Appointments(my_id)
                      : _selectedIndex == 3
                          ? Profile(my_id, logoutfunction)
                          : Text('Something Went Wrong!'),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 33,
        backgroundColor: Colors.blue,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: 'Appointment'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        selectedItemColor: Colors.white,
        onTap: (value) => _pageChange(value),
      ),
    );
  }
}

class DoctorPage extends StatefulWidget {
  Function _logout;
  DoctorPage(this._logout);

  @override
  _DoctorPageState createState() => _DoctorPageState(_logout);
}

class _DoctorPageState extends State<DoctorPage> {
  int _selectedIndex = 0;
  Function _logout;
  _DoctorPageState(this._logout);

  _pageChange(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo.png',
          width: 90,
          height: 90,
          color: Colors.white,
        ),
      ),
      body: _selectedIndex == 0
          ? DoctorHome(my_id)
          : _selectedIndex == 1
              ? DocProfile(my_id, _logout)
              : Text('Something Went Wrong!'),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 33,
        backgroundColor: Colors.blue,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: 'Appointment'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        selectedItemColor: Colors.white,
        onTap: (value) => _pageChange(value),
      ),
    );
  }
}
