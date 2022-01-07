import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/models.dart';

class DocProfile extends StatelessWidget {
  String my_id;
  Function _logout;
  DocProfile(this.my_id,this._logout);
  Future<Doctorprofile> get_Details() async {
    final response = await http.post(profile_url, body: {'id': my_id});
    final details = await json.decode(response.body);

    return Doctorprofile(details['name'], details['hospital_name'],
        details['designation'], details['phone_no'], details['email'],null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: get_Details(),
        builder: (context, AsyncSnapshot<Doctorprofile> snapshot) {
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
                child: Container(child: Image.asset('assets/images/doctor profile pic.png',
                width: 90,
                height: 90,
                color: Colors.blue),),
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
                  Text('About', style: TextStyle(fontSize: 25)),
                  Container(
                    height: 10,
                  ),
                  Text(snapshot.data.designation),
                  Container(
                    height: 10,
                  ),
                  Text(snapshot.data.hospital_name),
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
