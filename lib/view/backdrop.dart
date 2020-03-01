import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class backdrop extends StatelessWidget {
  var list_title = [
    '杉並11団について',
    'お問い合わせ',
    'このホームページについて',
    'この表示が酷すぎるのは自覚しています'
  ];
  var list_url = [
    'https://www.scout.or.jp/tokyo/suginami11/',
    'https://www.scout.or.jp/tokyo/suginami11/',
  ];

  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
    itemCount: 4 ,
    itemBuilder: (BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () async {
          if(index == 0 || index == 1){
            launch(list_url[index]);
          } else if(index == 2 || context != null){

          }
    },
        child: Text(list_title[index]),
    )
    );
    }
    );
  }
}
