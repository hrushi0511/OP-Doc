import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Classes/models.dart';

class Comments extends StatefulWidget {
  List comment;
  String doc_id;
  Comments(this.comment, this.doc_id);

  @override
  State<Comments> createState() => _CommentsState(comment, doc_id);
}

class _CommentsState extends State<Comments> {
  List comment;
  String doc_id;
  final new_comment = TextEditingController();
  _CommentsState(this.comment, this.doc_id);

  addcomment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('user_name');
    final response = await http.post(addcomment_url,
        body: {'name': name, 'id': doc_id, 'comment': new_comment.text});
    setState(() {
      comment.add({'name': name, 'comment': new_comment.text});
      new_comment.clear();
    });
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
              'Comments',
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              child: ListView.builder(
                  itemCount: widget.comment.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[200],
                                  child: Container(
                                      child: Image.asset(
                                          'assets/images/user profile pic.png',
                                          color: Colors.blue))),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${comment[index]['name']}',
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(comment[index]['comment'],
                                style: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: new_comment,
                decoration: InputDecoration(
                  suffix: TextButton(
                    onPressed: addcomment,
                    child: Text('Post'),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text(
                    'Add Comment...',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
