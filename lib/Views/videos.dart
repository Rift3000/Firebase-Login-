import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  _VideoScreenState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Books').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.width / 6,
                    child: ListView(
                      children: [
                        Text("Title: " + document['title']),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Description: " + document['description']),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}




/*return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.width / 6,
                    child: Text("Title: " + document['title']),
                  ),
                );
              }).toList(),
            );*/