import 'package:cinemates/database_model/feed.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:cinemates/model/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return FutureBuilder<List<Activity>>(
      future: _createPersonalFeedList(),
      builder: (context, AsyncSnapshot<List<Activity>> snapshot) {
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

  Widget _buildPersonalFeedListWidget(List<Activity> data) {
    List<Activity> personalFeed = [];
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
              Center(
                  child: Icon(Icons.volunteer_activism,
                      size: 50, color: Colors.grey))
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
                  return SizedBox(height: 50.0);
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: personalFeed.length,
                itemBuilder: (context, index) {
                  return _generateActivityCard(personalFeed[index]);
                  // return Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  //   child: Text(personalFeed[index].type.toString(), style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  // );
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

  Future<List<Activity>> _createPersonalFeedList() async {
    List<Activity> personalFeed = [];
    personalFeed = await Feed().generateActivityList();
    return personalFeed;
  }

  Widget _generateActivityCard(Activity activity) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(FontAwesomeIcons.user, color: Colors.white),
              SizedBox(width: 5.0),
              Text(
                "@" + activity.username,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                child: (() {
              if (activity.type == 0) {
                return Text(
                  "@" + activity.username +
                      " ha effettuato un nuovo collegamento con l'utente @" +
                      activity.friendUsername + ".",
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    // letterSpacing: 1.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }
              if (activity.type == 1) {
                return Text(
                  "@" + activity.username +
                    " ha aggiunto il titolo " + activity.movieTitle +
                    " alla sua lista dei Preferiti!",
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    // letterSpacing: 1.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }
              if (activity.type == 2) {
                return Text(
                  "@" + activity.username +
                      " ha aggiunto il titolo " + activity.movieTitle +
                      " alla sua lista personalizzata " +
                      activity.listTitle,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    // letterSpacing: 1.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }
              if (activity.type == 3) {
                return Text(
                  "@" + activity.username +
                      " ha creato una nuova lista con il titolo "
                      + activity.listTitle,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    // letterSpacing: 1.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }
            }())),
          ),
          SizedBox(height: 5.0),
          Text(
            "il " + activity.createTime.day.toString() +
            "/" + activity.createTime.month.toString() +
            " alle ore " + activity.createTime.hour.toString() + ":" + activity.createTime.minute.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
