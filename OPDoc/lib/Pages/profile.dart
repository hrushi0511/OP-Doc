import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/models.dart';

class Profile extends StatelessWidget {
  String my_id;
  Function _logout;
  Profile(this.my_id, this._logout);
  Future<ProfileDetails> getDetails() async {
    final response = await http.post(profile_url, body: {'id': my_id});
    final details = await json.decode(response.body);

    return ProfileDetails(
        details['name'], details['phone_no'], details['email']);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDetails(),
        builder: (context, AsyncSnapshot<ProfileDetails> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text('Loading...'),
            );
          }
          return Column(
            children: [
              Container(
                height: 100,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: Container(
                  child: Image.asset('assets/images/user profile pic.png',
                width: 90,
                height: 90,
                color: Colors.blue
                ),),
              ),
              Container(
                height: 10,
              ),
              Text(
                snapshot.data.name,
                style: TextStyle(fontSize: 20),
              ),
              Container(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10,
                  ),
                  Text('Contact', style: TextStyle(fontSize: 25)),
                  Container(
                    height: 10,
                  ),
                  Text(snapshot.data.phone_no),
                  Container(
                    height: 10,
                  ),
                  Text(snapshot.data.email),
                  ElevatedButton(
                      onPressed: () {
                        _logout();
                      },
                      child: Text('Log Out'))
                ],
              )
            ],
          );
        });
  }
}
