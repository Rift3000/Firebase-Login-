import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleScreen extends StatefulWidget {
  ArticleScreen({Key key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Articles').snapshots(),
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

            return Scrollbar(
              isAlwaysShown: true,
              thickness: 10.0,
              radius: Radius.circular(10.0),
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _launchURL(document['url']);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                document['title'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: document["image"],
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
