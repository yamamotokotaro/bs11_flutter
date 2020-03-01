import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_post/main.dart';

class List_Post extends StatelessWidget {
  String filter;
  String filter_key;
  String filter_colony;

  List_Post(String filter) {
    this.filter = filter;
  }

  @override
  Widget build(BuildContext context) {
    var wid = 0.0;
    var padding_wid = 0.0;
    var crossCount = 1;
    if (MediaQuery.of(context).size.width < 800) {
      wid = MediaQuery.of(context).size.width;
      crossCount = 1;
      padding_wid = 8.0;
    } else if (MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1000) {
      wid = MediaQuery.of(context).size.width;
      crossCount = 2;
      padding_wid = 0.0;
    } else if (MediaQuery.of(context).size.width > 1000) {
      wid = 1000.0;
      crossCount = 2;
      padding_wid = 0.0;
    }

    var query = Firestore.instance
        .collection('post')
        .where('colony', isEqualTo: filter)
        .where('visibility', isEqualTo: 'true');

    if (filter == 'all') {
      query = Firestore.instance
          .collection('post')
          .where('visibility', isEqualTo: 'true');
    }

    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final int postCount = snapshot.data.documents.length;
              if (postCount == 1) {
                crossCount = 1;
                padding_wid = 8.0;
              }
              return Center(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossCount,
                              childAspectRatio: (wid / crossCount) / 260),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: postCount,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot document =
                            snapshot.data.documents[index];
                        final dynamic title = document['title'];
                        final dynamic body = document['body'];
                        final dynamic colony = document['colony'];
                        final dynamic photo = document['photo'];
                        return Container(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute<Null>(
                                          settings: const RouteSettings(
                                              name: "/detail"),
                                          builder: (BuildContext context) =>
                                              new View_post(title, body, index,
                                                  photo, filter)));
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0,
                                        bottom: 0.0,
                                        left: 5.0,
                                        right: 5.0),
                                    child: Center(
                                        child: Column(
                                      children: <Widget>[
                                        Stack(children: <Widget>[
                                          Center(
                                            child: Container(
                                              height: 200,
                                              width: wid - 25,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Hero(
                                                      tag: 'pic_posts' +
                                                          filter +
                                                          index.toString(),
                                                      child: Image.network(
                                                        photo,
                                                        fit: BoxFit.cover,
                                                      ))),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: padding_wid),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: DecoratedBox(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFF047A3F),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      colony,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ]),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Hero(
                                              tag: 'title_posts' +
                                                  filter +
                                                  index.toString(),
                                              child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: Text(title,
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ))),
                                            ))
                                      ],
                                    )))));
                      }));
            } else {
              return Center(child: Text('エラーが発生しました'));
            }
          },
        ));
  }
}
