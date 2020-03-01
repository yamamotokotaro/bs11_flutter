import 'dart:ui';

import 'package:bs11_flutter/view/view_colony/fixed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../list_posts.dart';

class View_colony extends StatelessWidget {
  String title;
  int index;
  String photo;

  View_colony(String title, String photo, int index) {
    this.title = title;
    this.photo = photo;
    this.index = index;
  }

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: Stack(
              children: <Widget>[
                Container(
                    height: 250,
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Image.network(
                        photo,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                      ),
                      Center(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 700),
                              child: Hero(
                                tag: 'pic_colony' + index.toString(),
                                child: Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              )))
                    ])),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13),
            child: Container(
              height: 65,
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('colony_fixed')
                      /*.where('colony', isEqualTo: title)*/
                      .orderBy('order')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final int messageCount = snapshot.data.documents.length;
                      return ListView.builder(
                          itemCount: messageCount,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];
                            final dynamic title = document['title'];
                            final dynamic photo = document['photo'];
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute<Null>(
                                          settings: const RouteSettings(
                                              name: "/detail_colony_fixed"),
                                          builder: (BuildContext context) =>
                                              new View_colony_fixed(
                                                  title, index, photo)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Container(
                                        height: 58,
                                        child: ClipRRect(
                                            child: Hero(
                                          tag: 'pic_colony_fixed' +
                                              index.toString(),
                                          child: Container(
                                              width: 58,
                                              decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: new NetworkImage(
                                                          photo)))),
                                        )),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Hero(
                                          tag: 'title_colony_fixed' +
                                              index.toString(),
                                          child: Material(
                                              type: MaterialType.transparency,
                                              child: Text(title,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ))),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: Text('エラーが発生しました'));
                    }
                  }),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Text(
                      '最近の' + title + 'の活動',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                  ]))),
          List_Post(title)
        ],
      )),
    );
  }
}
