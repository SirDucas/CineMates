import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:cinemates/database_model/friendship.dart';

class RecievedRequests extends StatefulWidget {
  const RecievedRequests({Key key}) : super(key: key);

  @override
  _RecievedRequestsState createState() => _RecievedRequestsState();
}

class _RecievedRequestsState extends State<RecievedRequests> {
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
      future: _createRecievedRequests(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return _buildRecievedRequestsWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildRecievedRequestsWidget(List<String> data) {
    List<String> recievedRequests = [];
    recievedRequests = List.from(data);
    if (recievedRequests.length == 0) {
      return Center(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text("Non hai richieste di amicizia",
              style: TextStyle(fontSize: 10.0, color: Colors.white),)
        ),
      );
    }
    else {
      return Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 25.0);
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: recievedRequests.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          recievedRequests[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                        Container(
                          child: Row(
                            children: [
                              TextButton(
                                child: Text("Accetta"),
                                onPressed: () async {
                                  Friendship()
                                      .acceptFriendship(recievedRequests[index]);
                                  setState(() {});
                                },
                              ),
                              TextButton(
                                child: Text("Rifiuta"),
                                onPressed: () {
                                  Friendship()
                                      .rejectFriendship(recievedRequests[index]);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        )
                      ]),
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

  Future<List<String>> _createRecievedRequests() async {
    List<String> recievedRequests = [];
    recievedRequests = await Friendship().retrieveFriendshipSuspended();
    return recievedRequests;
  }
}
