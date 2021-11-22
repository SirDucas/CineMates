import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:cinemates/database_model/friendship.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key key}) : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _createFriendList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return _buildFriendListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildFriendListWidget(List<String> data) {
    List<String> friendList = [];
    friendList = List.from(data);
    if (friendList.length == 0) {
      return Center(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Non hai richieste di amicizia",
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            )),
      );
    } else {
      return Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 25.0);
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        friendList[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                      TextButton(
                        child: Text("Rimuovi"),
                        onPressed: () {
                          Friendship().rejectFriendship(friendList[index]);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              }));
    }
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text("Error occurred: $error")],
    ));
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ]));
  }

  Future<List<String>> _createFriendList() async {
    List<String> friendList = [];
    friendList = await Friendship().retrieveFriendList();
    return friendList;
  }
}
