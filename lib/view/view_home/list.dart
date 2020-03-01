import 'package:flutter/material.dart';
import 'package:bs11_flutter/view/view_colony/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../list_posts.dart';

class ListState extends StatelessWidget {
  var list_photos = [
    'https://storage.googleapis.com/customlens/icons/サイトのアイコン_circle.png',
    'https://storage.googleapis.com/customlens/icons/icon-mail.png',
    'https://storage.googleapis.com/customlens/icons/icon-info.png'
  ];
  var list_title = ['杉並11団について', 'お問い合わせ', 'このページについて'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ボーイスカウト杉並11団'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    height: 60,
                    child: ListView.builder(
                        itemCount: list_title.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: InkWell(
                              onTap: () async {
                                switch (index) {
                                  case 0:
                                    launch(
                                        'https://www.scout.or.jp/tokyo/suginami11/');
                                    break;
                                  case 1:
                                    launch(
                                        'https://www.scout.or.jp/tokyo/suginami11-contact/');
                                    break;
                                  case 2:
                                    await showDialog<int>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "ボーイスカウト杉並11団ホームページ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            content: SingleChildScrollView(
                                              child: Text(
                                                "このホームページ上のスカウト運動に関する事項は、ボーイスカウト日本連盟ホームページ掲載「ボーイスカウト関係のホームページ開設」に沿って、ボーイスカウト杉並 11団団委員長佐藤武信(連絡先　東京都杉並区井草２-３１-２５　カトリック下井草教会気付)の責任のもとに掲載しています。\n\n© 2020 11th Suginami Group, Tokyo Scout Council, SAJ",
                                                style: TextStyle(
                                                    fontSize: 16, height: 1.2),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('閉じる'),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              )
                                            ],
                                          );
                                        });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Container(
                                      height: 53,
                                      child: ClipRRect(
                                        child: Container(
                                            width: 53,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: new NetworkImage(
                                                        list_photos[index])))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Material(
                                        type: MaterialType.transparency,
                                        child: Text(list_title[index],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                            ))),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5, top: 4),
                          child: Icon(
                            Icons.flag,
                            color: Theme.of(context).accentColor,
                            size: 32,
                          ),
                        ),
                        Text(
                          '各隊の紹介',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                      ]))),
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 10),
                child: Container(
                  height: 170,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('colony')
                        .orderBy("order")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final int colonyCount = snapshot.data.documents.length;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];
                            final dynamic name = document['name'];
                            final dynamic age = document['age'];
                            final dynamic photo = document['photo'];
                            return Container(
                              width: 250,
                              child: Card(
                                elevation: 4,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute<Null>(
                                              settings: const RouteSettings(
                                                  name: "/detail_colony"),
                                              builder: (BuildContext context) =>
                                                  new View_colony(
                                                      name, photo, index)));
                                    },
                                    child:
                                        Stack(fit: StackFit.expand, children: <
                                            Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Hero(
                                              tag: 'pic_colony' +
                                                  index.toString(),
                                              child: Image.network(
                                                photo,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ))),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontSize: 27.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    age,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )
                                    ])),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.all(10),
                              ),
                            );
                          },
                          itemCount: colonyCount,
                        );
                      } else {
                        return Center(child: Text('エラーが発生しました'));
                      }
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 6, top: 3),
                          child: Icon(
                            Icons.assignment,
                            color: Theme.of(context).accentColor,
                            size: 31,
                          ),
                        ),
                        Text(
                          '最近の活動',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                      ]))),
              List_Post('all')
            ],
          ),
        ),
      ),
    );
  }
}
