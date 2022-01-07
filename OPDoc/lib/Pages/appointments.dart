import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/models.dart';
import './status.dart';

class Appointments extends StatelessWidget {
  String my_id;
  Appointments(this.my_id);

  Future<List<AppointmentsList>> getAppointments() async {
    List appointmentlist = [];
    List<AppointmentsList> appointments = [];
    var response = await http.post(get_appointments_url, body: {'id': my_id});
    appointmentlist = json.decode(response.body);

    for (var i = 0; i < appointmentlist.length; i++) {
      response = await http
          .post(profile_url, body: {'id': appointmentlist[i]['doctor_id']});
      var details = json.decode(response.body);
      appointments.add(AppointmentsList(
          appointmentlist[i]['appointment_no'],
          details['name'],
          details['designation'],
          details['hospital_name'],
          appointmentlist[i]['date']));
    }
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getAppointments(),
            builder: (context, AsyncSnapshot<List<AppointmentsList>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('Loading...'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  String name = snapshot.data[index].doctor;
                  String qualification = snapshot.data[index].qualification;
                  String date = snapshot.data[index].date;
                  return Card(
                    child: ListTile(
                      leading: Column(
                        children: [
                          Text(
                            "Appointment No",
                            style: TextStyle(fontSize: 7),
                          ),
                          CircleAvatar(
                            child:
                                Text("${snapshot.data[index].appointment_no}"),
                          ),
                        ],
                      ),
                      title: Text(snapshot.data[index].hospital),
                      subtitle: Text("Dr.${name},${qualification}\n${date}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Status(snapshot.data[index])),
                        );
                      },
                    ),
                  );
                },
              );
            }));
  }
}
