import 'package:clean_login/Tabs/article_screen.dart';
import 'package:clean_login/Tabs/profile_screen.dart';
import 'package:clean_login/Tabs/video_screen.dart';
import 'package:flutter/material.dart';

import 'package:clean_login/theme/routes.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.video_library_rounded),
                      ),
                      Tab(
                        icon: Icon(Icons.insert_drive_file_sharp),
                      ),
                      Tab(icon: Icon(Icons.account_circle_sharp)),
                    ],
                    labelColor: Colors.blueAccent,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.blue, width: 4.0),
                      insets: EdgeInsets.only(bottom: 44),
                    ),
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
                body: TabBarView(
                  children: [
                    VideoScreen(),
                    ArticleScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
