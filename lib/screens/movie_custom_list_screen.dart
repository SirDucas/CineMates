import 'package:cinemates/alerts/alert_dialog_model.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:cinemates/model/favorite.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:flutter_session/flutter_session.dart';

class MovieCustomListScreen extends StatefulWidget {
  final String title;
  const MovieCustomListScreen({Key key, @required this.title}) : super(key: key);

  @override
  _MovieCustomListScreenState createState() => _MovieCustomListScreenState(title);
}

class _MovieCustomListScreenState extends State<MovieCustomListScreen> {
  final String title;
  _MovieCustomListScreenState(this.title);
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
    return FutureBuilder<List<Favorite>>(
        future: _createFavorites(),
        builder: (context, AsyncSnapshot<List<Favorite>> snapshot) {
          if (snapshot.hasData) {
            return _buildCustomMoviesWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildCustomMoviesWidget(List<Favorite> data) {
    List<Favorite> favorites = [];
    favorites = List.from(data);
    if (favorites.length == 0) {
      return Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: AppBar(
            backgroundColor: Style.Colors.mainColor,
            centerTitle: true,
            title: Text(title),
            elevation: 10.0,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Non hai ancora aggiunto nessun titolo in questa lista',
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 20.0),
                  )),
              SizedBox(height: 15.0),
              Center(child: Icon(Icons.error, size: 50, color: Colors.grey))
            ]),
          ));
    } else {
      return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          title: Text(title),
          elevation: 10.0,
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15.0);
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      favorites[index].poster == null
                          ? Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle),
                        child: Column(
                          children: <Widget>[
                            Icon(EvaIcons.filmOutline,
                                color: Colors.white, size: 50.0)
                          ],
                        ),
                      )
                          : Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200" +
                                        favorites[index].poster),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 150.0,
                        child: Text(
                          favorites[index].title,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      IconButton(
                          onPressed: () async {
                            User().removeMovieCustomList(favorites[index].movieId, title);
                            await MyAlertDialogs().showDialogRemovedFromList(context);
                            setState(() {});
                          },
                          icon: Icon(Icons.highlight_remove), color: Style.Colors.secondColor),
                    ],
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
        title: Text(title),
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

  Future<List<Favorite>> _createFavorites() async {
    List<Favorite> favorites = [];
    int _userId = await FlutterSession().get('token');
    favorites = await User().retrieveMovieFromCustomList(_userId, title);
    return favorites;
  }
}
