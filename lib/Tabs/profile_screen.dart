import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_login/Views/custom_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenState();

  String displayName = "";
  String myAvatar;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString("displayName");
    });
  }

  Widget build(BuildContext context) {
    void showAvatarEditor() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                myAvatar = "avatar2.png";
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                child: Image.asset(
                                  "image/avatar2.png",
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                myAvatar = "avatar1.png";
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                child: Image.asset(
                                  "image/avatar1.png",
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                myAvatar = "avatar3.png";
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                child: Image.asset(
                                  "image/avatar3.png",
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        child: Text(
                          "Close",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    String myImages() {
      if (myAvatar == null) {
        return "avatar1.png";
      } else {
        return myAvatar;
      }
    }

    Future<Widget> _getImage(BuildContext context, String imageName) async {
      Image image;
      await FireStorageService.loadImage(context, imageName).then((value) {
        image = Image.network(
          value.toString(),
          fit: BoxFit.scaleDown,
        );
      });
      return image;
    }

    listCell(title, url) {
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 18)),
                CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  imageUrl: url,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
        ],
      );
    }

    return Scaffold(
      floatingActionButton: null,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 5,
            child: Material(
              color: Color(0xff8c52ff),
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Hey: $displayName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "Member: 36 Weeks",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 50,
                              bottom: 100,
                            ),
                            child: Column(
                              children: <Widget>[
                                listCell("test1",
                                    "https://miro.medium.com/max/700/1*X6pU3XP7Yr6-CW9AIu3xyg.jpeg"),
                                listCell("test2",
                                    "https://miro.medium.com/max/700/1*X6pU3XP7Yr6-CW9AIu3xyg.jpeg"),
                                listCell("test3",
                                    "https://miro.medium.com/max/700/1*X6pU3XP7Yr6-CW9AIu3xyg.jpeg"),
                                listCell("test4",
                                    "https://miro.medium.com/max/700/1*X6pU3XP7Yr6-CW9AIu3xyg.jpeg"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.8,
            top: MediaQuery.of(context).size.height / 7,
            child: Material(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                child: FutureBuilder(
                    future: _getImage(context, myImages()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.width / 1.2,
                          child: snapshot.data,
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.width / 1.2,
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Container();
                    }),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 25,
            child: MaterialButton(
              onPressed: () {
                showAvatarEditor();
              },
              child: Container(
                height: MediaQuery.of(context).size.width / 6.5,
                width: MediaQuery.of(context).size.width / 6.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black26,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
