import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import 'home_screen.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Feed recenti"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () async {
            await Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));
          },
        ),
      ),
    );
  }
}
