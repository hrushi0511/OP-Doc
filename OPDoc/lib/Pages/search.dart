import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:opdoc/Pages/booking.dart';
import '../Classes/models.dart';

class Searchbody extends StatelessWidget {
  String search_value;
  int count = null;
  Function pagechange;
  String my_id;
  Searchbody(this.search_value, this.pagechange, this.my_id);
  Future<List<SearchDetails>> searchresult() async {
    final response = await http.post(search_url, body: {'text': search_value});
    var result_details = await json.decode(response.body);
    List details = result_details['result'];
    count = result_details['count'];
    List<SearchDetails> result = [];
    for (var i = 0; i < details.length; i++) {
      var item = details[i];

      result.add(SearchDetails(item['Name'], item['Designation'],
          item['Hospital'], item['objectID']));
    }
    print(result.length);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: searchresult(),
          builder: (context, AsyncSnapshot<List<SearchDetails>> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text('Loading...'),
              );
            }

            print(snapshot.data.length);
            return count == 0
                ? Center(child: Text('No Results Found!'))
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data[index];
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Container(child: Image.asset('assets/images/doctor profile pic.png',
                color: Colors.blue))
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                              '${item.designation}\n${item.hospital_name}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Booking(
                                      item.doctor_id, pagechange, my_id)),
                            );
                          },
                        ),
                      );
                    });
          }),
    );
  }
}
