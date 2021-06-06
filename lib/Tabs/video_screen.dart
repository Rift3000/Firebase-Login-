import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Youtube').snapshots(),
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
                var url = document['url'];

                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(url),
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: true,
                    disableDragSeek: false,
                    isLive: true,
                    forceHD: false,
                  ),
                );

                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            document['title'],
                            style:
                                GoogleFonts.lato(fontStyle: FontStyle.italic),
                          ),
                        ),
                        YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        ),
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
