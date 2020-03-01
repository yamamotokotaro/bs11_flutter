import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class View_colony_fixed extends StatelessWidget {
  String title;
  int index;
  String photo;

  var list_body_cub = [
    'カブ隊では自然の中でキャンプや山登り、ロープワークなどの楽しい活動をしているよ！\n君も一緒に活動しよう！',
    '普段は日曜日に教会に集まり活動をします。活動によっては公園などに行きます。春・夏・秋・冬キャンプを行い、野外活動をします。',
    'カブ隊には大体20人くらいの指導者がいます。指導者は保護者を中心に構成されています。',
  ];

  View_colony_fixed(String title, int index, String photo) {
    this.title = title;
    this.index = index;
    this.photo = photo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          height: 300,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            Image.network(
              photo,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Hero(
                  tag: 'pic_colony_fixed' + index.toString(),
                  child: Image.network(
                    photo,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
          ]),
        ),
        Hero(
            tag: 'title_colony_fixed' + index.toString(),
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                    margin: const EdgeInsets.only(top: 16, left: 25, right: 25),
                    width: 575,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(title,
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          )),
                    )))),
        Container(
            margin: const EdgeInsets.only(top: 2.5, left: 25, right: 25),
            width: 575,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(list_body_cub[index],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  )),
            ))
      ])),
    );
  }
}
