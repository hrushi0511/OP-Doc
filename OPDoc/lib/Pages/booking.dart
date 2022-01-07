import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/models.dart';
import 'appointments.dart';
import 'comments.dart';

String date = null;

class Booking extends StatelessWidget {
  String doctor_id;
  String my_id;
  Function pageChange;
  Booking(this.doctor_id, this.pageChange, this.my_id);
  CreateDailougeBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("No Appointments"),
            content: Text('No Appointments on Date'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  SelectDateDailougeBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select the date!"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  bookappointment(context) async {
    if (date == null) {
      SelectDateDailougeBox(context);
      return;
    }
    final response = await http.post(bookappointment_url,
        body: {'doctor_id': doctor_id, 'patient_id': my_id, 'date': date});
    var result = await json.decode(response.body);
    if (result['status']) {
      Navigator.pop(context);
      pageChange(2);
    } else {
      CreateDailougeBox(context);
    }
  }

  Future<Doctorprofile> _getdoctor() async {
    final response = await http.post(profile_url, body: {'id': doctor_id});
    final result = await json.decode(response.body);
    return Doctorprofile(
        result['name'],
        result['hospital_name'],
        result['designation'],
        result['phone_no'],
        result['email'],
        result['comments']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Transform(
              transform: Matrix4.translationValues(-20, 0.0, 0.0),
              child: Text(
                'Profile',
              )),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: _getdoctor(),
              builder: (context, AsyncSnapshot<Doctorprofile> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
                List comments = snapshot.data.comments;
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 3,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            child: Container(
                              child: Image.asset(
                                  'assets/images/doctor profile pic.png',
                                  width: 90,
                                  height: 90,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data.name,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(snapshot.data.designation,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              Text(snapshot.data.hospital_name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(snapshot.data.phone_no,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                            Text(snapshot.data.email,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DateButton(),
                          ElevatedButton(
                              onPressed: () {
                                bookappointment(context);
                              },
                              child: Text('Book Appointment')),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Comments(comments, doctor_id)),
                            );
                          },
                          child: Text(
                            'Comments(${comments == null ? 0 : comments.length})',
                            style: TextStyle(fontSize: 17),
                          )),
                      comments != null
                          ? Column(
                              children: [
                                for (var i = 0;
                                    i < 2 && i < comments.length;
                                    i++)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Container(
                                                    child: Image.asset(
                                                        'assets/images/user profile pic.png',
                                                        color: Colors.blue))),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('${comments[i]['name']}',
                                                style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(comments[i]['comment'],
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          : Center(
                              child: Text('No comments yet!'),
                            ),
                    ],
                  ),
                );
              }),
        ));
  }
}

class DateButton extends StatefulWidget {
  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  String _buttonvalue = 'Choose date';

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 2)))
        .then((value) {
      setState(() {
        if (value == null) {
          _buttonvalue = 'Choose date';
          date = null;
        } else {
          _buttonvalue = DateFormat('dd/MM/yyyy').format(value);
          date = _buttonvalue;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _presentDatePicker, child: Text(_buttonvalue));
  }
}
