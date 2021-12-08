import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import '../widgets/count_accesses_stats.dart';
import '../widgets/count_activities_stats.dart';
import '../widgets/count_favmovies_stats.dart';
import '../widgets/count_friendship_stats.dart';
import '../widgets/count_users_stats.dart';
import '../widgets/top_favorite_widget.dart';
import 'user_crud_screen.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      backgroundColor: Style.Colors.mainColor,
      drawer: Drawer(
        backgroundColor: Style.Colors.mainColor,
        child: ListView(
          children: [
            Container(
              height: 100.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Style.Colors.mainColor,
                ),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Pannello Admin",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard_rounded,
                color: Style.Colors.secondColor,
              ),
              title: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.table_chart_rounded,
                color: Style.Colors.secondColor,
              ),
              title: const Text(
                "CRUD Operator",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserCrudOperatorScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Style.Colors.secondColor,
              ),
              title: const Text(
                "Impostazioni Profilo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Style.Colors.secondColor,
              ),
              title: const Text(
                "Termina sessione",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Style.Colors.mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Statistiche principali: ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Material(
                  color: Style.Colors.mainColor,
                  child: UserCountStatistics(),
                ),
                SizedBox(width: 20.0),
                Material(
                  color: Style.Colors.mainColor,
                  child: TopFavoriteMovieStatistics(),
                ),
                Material(
                  color: Style.Colors.mainColor,
                  child: AccessCountStatistics(),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Material(
                  color: Style.Colors.mainColor,
                  child: FavoriteTitlesCountStatistics(),
                ),
                Material(
                  color: Style.Colors.mainColor,
                  child: ActivityCountStatistics(),
                ),
                Material(
                  color: Style.Colors.mainColor,
                  child: FriendshipCountStatistics(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 15.0,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        elevation: 1.0,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        Flexible(
          flex: 5,
          child: Drawer(
            backgroundColor: Style.Colors.mainColor,
            child: ListView(children: [
              ListTile(
                leading: Icon(
                  Icons.dashboard_rounded,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.table_chart_rounded,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "CRUD Operator",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CrudOperatorScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Impostazioni Profilo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Termina sessione",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {},
              ),
            ]),
          ),
        ),
        Expanded(
          flex: 15,
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Style.Colors.mainColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Statistiche principali: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      color: Style.Colors.mainColor,
                      child: UserCountStatistics(),
                    ),
                    SizedBox(width: 20.0),
                    Material(
                      color: Style.Colors.mainColor,
                      child: TopFavoriteMovieStatistics(),
                    ),
                    Material(
                      color: Style.Colors.mainColor,
                      child: AccessCountStatistics(),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      color: Style.Colors.mainColor,
                      child: FavoriteTitlesCountStatistics(),
                    ),
                    Material(
                      color: Style.Colors.mainColor,
                      child: ActivityCountStatistics(),
                    ),
                    Material(
                      color: Style.Colors.mainColor,
                      child: FriendshipCountStatistics(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
    */

