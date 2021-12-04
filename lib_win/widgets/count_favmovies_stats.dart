import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/stats.dart';

class FavoriteTitlesCountStatistics extends StatefulWidget {
  const FavoriteTitlesCountStatistics({Key key}) : super(key: key);

  @override
  _FavoriteTitlesCountStatisticsState createState() => _FavoriteTitlesCountStatisticsState();
}

class _FavoriteTitlesCountStatisticsState extends State<FavoriteTitlesCountStatistics> {
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
    return FutureBuilder<int>(
      future: _createTotalFavMovieInteger(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return _buildTotalFavMovieInteger(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
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
      child: SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 4.0,
        ),
      ),
    );
  }

  Widget _buildTotalFavMovieInteger(int data) {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Style.Colors.secondColor,
            size: 50.0,
          ),
          Text(
            data.toString(),
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            "Numero totale dei film salvati nelle liste preferiti e personalizzate",
            maxLines: 3,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<int> _createTotalFavMovieInteger() async {
    int result = await Stats().countFavmovie();
    return result;
  }
}
