import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class View_post extends StatelessWidget {
  String title;
  String body;
  int index;
  String photo;
  String type;
  double padding_top;

  View_post(String title, String body, int index, String photo, String type) {
    this.title = title;
    this.body = body;
    this.index = index;
    this.photo = photo;
    this.type = type;
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 716) {
      padding_top = 0;
    } else if (MediaQuery.of(context).size.width > 716) {
      padding_top = 16;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: padding_top),
            child: Center(
                child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Container(
                height: 300,
                child: Hero(
                  tag: 'pic_posts' + type + index.toString(),
                  child: Image.network(
                    photo,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ))),
        Hero(
            tag: 'title_posts' + type + index.toString(),
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                    margin: const EdgeInsets.only(top: 16, left: 25, right: 25),
                    width: 685,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1900.0),
                          child: Text(title,
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              )),
                        ))))),
        Container(
            margin: const EdgeInsets.only(top: 2.5, left: 25, right: 25),
            width: 685,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(body,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  )),
            ))
      ])),
    );
  }
}
