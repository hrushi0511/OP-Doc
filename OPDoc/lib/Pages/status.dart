import 'package:flutter/material.dart';

import '../Classes/models.dart';

class Status extends StatelessWidget {
  AppointmentsList appointment;
  var numbers = new List<int>.generate(50, (i) => i + 1);
  Status(this.appointment);
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
              'Status',
            )),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(4),
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: Container(
                            child: Image.asset(
                                'assets/images/doctor profile pic.png',
                                color: Colors.blue))),
                    title: Text(appointment.doctor),
                    subtitle: Text(
                        '${appointment.qualification}\n${appointment.hospital}\nDate:${appointment.date}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Your Appointment',
                              style: TextStyle(fontSize: 13)),
                          SizedBox(
                            height: 10,
                            width: 0,
                          ),
                          Text(appointment.appointment_no.toString(),
                              style: TextStyle(fontSize: 30))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 0,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Appointment',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 0,
                          ),
                          Text('37', style: TextStyle(fontSize: 30))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(width: 15,height: 15,color: Colors.blue,margin: EdgeInsets.all(8),),
                  Text('Completed'),
                ],
              ),
              Row(
                children: [
                  Container(width: 15,height: 15,color: Colors.grey[300],margin: EdgeInsets.all(8)),
                  Text('Waiting for doctor'),
                ],
              )

            ],
          ),
          Container(
            height: 400,
            child: SingleChildScrollView(
              child: Column(children: [
                for (int i = 0; i < numbers.length; i += 5)
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int j = i; j < i + 5 && j < numbers.length; j++)
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      j < 17 ? Colors.blue : Colors.grey[300],
                                  child: Text('${numbers[j]}'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  )
              ]),
            ),
          )
          //Apointment details should be shown
        ],
      ),
    );
  }
}
