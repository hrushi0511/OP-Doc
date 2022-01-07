import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/models.dart';

class DoctorHome extends StatelessWidget {
  String my_id;
  DoctorHome(this.my_id);
  Future<List<PatientDetails>> getAppointments() async {
    List appointmentlist = [];
    List<PatientDetails> appointments = [];
    var response = await http.post(get_appointments_url, body: {'id': my_id});
    appointmentlist = json.decode(response.body);

    for (var i = 0; i < appointmentlist.length; i++) {
      response = await http
          .post(profile_url, body: {'id': appointmentlist[i]['patient_id']});
      var details = json.decode(response.body);
      // print(details);
      appointments.add(PatientDetails(appointmentlist[i]['appointment_no'],
          details['name'], details['phone_no'], appointmentlist[i]['date']));
    }
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getAppointments(),
            builder: (context, AsyncSnapshot<List<PatientDetails>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('Loading...'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  int appointment_no = snapshot.data[index].appointment_no;
                  String name = snapshot.data[index].name;
                  String date =snapshot.data[index].date;
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
                                Text("${appointment_no}"),
                          ),
                        ],
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text('${snapshot.data[index].phone_no}\nDate:${snapshot.data[index].date}'),
                    ),
                  );
                },
              );
            }));
  }
}
