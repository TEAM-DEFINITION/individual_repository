import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var titleSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("K Shield Junior",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            Text("Project study_kimjuwon",
                style: TextStyle(color: Colors.grey, fontSize: 26)),
          ],
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Icon(Icons.star, size: 35, color: Colors.amber),
        Text(
          '41',
          style: TextStyle(fontSize: 30),
        )
      ],
    );

    var buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.call, size: 45, color: Colors.lightBlue),
            Text('CALL', style: TextStyle(color: Colors.lightBlue))
          ],
        ),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(
          children: <Widget>[
            Icon(Icons.near_me, size: 45, color: Colors.lightBlue),
            Text('ROUTE', style: TextStyle(color: Colors.lightBlue))
          ],
        ),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(
          children: <Widget>[
            Icon(Icons.share, size: 45, color: Colors.lightBlue),
            Text('SHARE', style: TextStyle(color: Colors.lightBlue))
          ],
        )
      ],
    );
    var textSection = Container(
      child: Text(
        '???????????? ????????????? : '
        '?????????????????????????????? ????????????, ??????????????????????????? ???????????? ????????????.'
        '?????? ???????????? ?????? ?????? ??? ??????????????? ?????? ????????? ??? ?????? ?????????'
        '???????????? ?????? ????????? ?????? ?????? ????????????.',
        style: TextStyle(fontSize: 20)),
      padding: EdgeInsets.all(30.0),
    );

    return Scaffold(
        body: Column(
      children: <Widget>[
        Image.network(
            "https://www.dailysecu.com/news/photo/201809/38334_30902_5027.jpg",
            height: 400,
            width: 600,
            fit: BoxFit.cover),
        Padding(padding: EdgeInsets.all(10.0)),
        titleSection,
        Padding(padding: EdgeInsets.all(10.0)),
        buttonSection,
        textSection
      ],
    ));
  }
}
