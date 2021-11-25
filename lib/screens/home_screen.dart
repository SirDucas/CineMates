import 'package:cinemates/database_model/feed.dart';
import 'package:cinemates/screens/friend_screen.dart';
import 'package:cinemates/screens/lists_screen.dart';
import 'package:cinemates/screens/login_screen.dart';
import 'package:cinemates/screens/registration_screen.dart';
import 'package:cinemates/screens/search_screen.dart';
import 'package:cinemates/screens/favorites_screen.dart';
import 'package:cinemates/widgets/genres.dart';
import 'package:cinemates/widgets/now_playing.dart';
import 'package:cinemates/widgets/persons.dart';
import 'package:cinemates/widgets/top_movies.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:flutter_session/flutter_session.dart';

import 'activity_screen.dart';

dynamic token;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    if (token == 'yes') {
      print(token);
      return buildHomeScreenLogout(context);
    } else {
      return buildHomeScreenLogin(context);
    }
  }

  void getToken() async {
    token = await FlutterSession().get('log');
  }
}

Widget buildHomeScreenLogout(BuildContext context) {
  return Scaffold(
    backgroundColor: Style.Colors.mainColor,
    drawer: Theme(
      data: Theme.of(context).copyWith(canvasColor: Style.Colors.mainColor),
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: 100.0,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Style.Colors.mainColor,
                ),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Cinemates Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Preferiti",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Liste personalizzate",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListsScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Feed",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActivityScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Amici",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                token = await FlutterSession().set('log', 'no');
                await Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
              },
            ),
          ],
        ),
      ),
    ),
    appBar: AppBar(
      backgroundColor: Style.Colors.mainColor,
      centerTitle: true,
      title: Text("Cinemates"),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            }),
      ],
    ),
    body: ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        NowPlaying(),
        GenresScreen(),
        TopMovies(),
        PersonsList(),
      ],
    ),
  );
}

Widget buildHomeScreenLogin(BuildContext context) {
  return Scaffold(
    backgroundColor: Style.Colors.mainColor,
    drawer: Theme(
      data: Theme.of(context).copyWith(canvasColor: Style.Colors.mainColor),
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: 100.0,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Style.Colors.mainColor,
                ),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Cinemates Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Cerca Titoli",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              title: const Text(
                "Registrazione",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    ),
    appBar: AppBar(
      backgroundColor: Style.Colors.mainColor,
      centerTitle: true,
      title: Text("Cinemates"),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            }),
      ],
    ),
    body: ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        NowPlaying(),
        GenresScreen(),
        TopMovies(),
        PersonsList(),
      ],
    ),
  );
}
