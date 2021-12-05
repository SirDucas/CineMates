import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/stats.dart';

class UserCountStatistics extends StatefulWidget {
  const UserCountStatistics({Key key}) : super(key: key);

  @override
  _UserCountStatisticsState createState() => _UserCountStatisticsState();
}

class _UserCountStatisticsState extends State<UserCountStatistics> {
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
      future: _createTotalUsersInteger(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return _buildTotalUsersInteger(snapshot.data);
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

  Widget _buildTotalUsersInteger(int data) {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.person_outline_rounded,
              color: Style.Colors.secondColor,
              size: 50.0,
            ),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "Numero di utenti registrati sulla nostra app",
              maxLines: 3,
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

  Future<int> _createTotalUsersInteger() async {
    int result = await Stats().countUsers();
    return result;
  }
}
