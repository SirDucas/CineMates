import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/stats.dart';

class TopFavoriteMovieStatistics extends StatefulWidget {
  const TopFavoriteMovieStatistics({Key key}) : super(key: key);

  @override
  _TopFavoriteMovieStatisticsState createState() => _TopFavoriteMovieStatisticsState();
}

class _TopFavoriteMovieStatisticsState extends State<TopFavoriteMovieStatistics> {
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
    return FutureBuilder<String>(
      future: _createTopFavoriteMovieStatistics(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return _buildTopFavoriteMovieStatistics(snapshot.data);
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

  Widget _buildTopFavoriteMovieStatistics(String data) {
    return Container(
      width: 200.0,
      height: 150.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.movie,
              color: Style.Colors.secondColor,
              size: 50.0,
            ),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
              ),
            ),
            Text(
              "Il titolo più inserito nei preferiti",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _createTopFavoriteMovieStatistics() async {
    String result = await Stats().topFavoriteMovie();
    return result;
  }
}
