import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:cinemates/widgets/new_friend.dart';
import 'package:cinemates/widgets/friend_list.dart';
import 'package:cinemates/widgets/recieved_requests.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Amici"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          NewFriend(),
          SizedBox(height: 15.0),
          Center(
              child:
              Text("Richieste di collegamento",
                style: TextStyle(color: Colors.white, fontSize: 18.0),)
          ),
          SizedBox(height: 5.0),
          RecievedRequests(),
          SizedBox(height: 15.0),
          Center(
              child:
              Text("Lista amici",
                style: TextStyle(color: Colors.white, fontSize: 18.0),)
          ),
          SizedBox(height: 5.0),
          FriendList(),
        ],
      ),
    );
  }
}
