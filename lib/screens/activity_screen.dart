import 'package:cinemates/database_model/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
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
    return FutureBuilder<List<String>> (
      future: _createPersonalFeedList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return _buildPersonalFeedListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildPersonalFeedListWidget(List<String> data) {
    List<String> personalFeed = [];
    personalFeed = List.from(data);
    if (personalFeed.length == 0) {
      return Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: AppBar(
            backgroundColor: Style.Colors.mainColor,
            centerTitle: true,
            title: Text("Feed"),
            elevation: 10.0,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Non ci sono attività recenti al momento. Torna più tardi!',
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 20.0),
                  )),
              SizedBox(height: 15.0),
              Center(child: Icon(Icons.volunteer_activism, size: 50, color: Colors.grey))
            ]),
          ));
    } else {
      return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          title: Text("Feed"),
          elevation: 10.0,
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 25.0);
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: personalFeed.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(personalFeed[index], style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  );
                })),
      );
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
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Feed"),
        elevation: 10.0,
      ),
      body: Center(
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
              ])),
    );
  }

  Future<List<String>> _createPersonalFeedList() async {
    List<String> personalFeed = [];
    personalFeed = await Feed().personalFeedList();
    return personalFeed;
  }
}
