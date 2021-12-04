import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/stats.dart';

class AccessCountStatistics extends StatefulWidget {
  const AccessCountStatistics({Key key}) : super(key: key);

  @override
  _AccessCountStatisticsState createState() => _AccessCountStatisticsState();
}

class _AccessCountStatisticsState extends State<AccessCountStatistics> {
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
      future: _createAccessCountStatistics(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return _buildAccessCountStatistics(snapshot.data);
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

  Widget _buildAccessCountStatistics(int data) {
    return Container(
      width: 200.0,
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.login,
            color: Style.Colors.secondColor,
            size: 50.0,
          ),
          Text(
            data.toString(),
            style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Text(
            "Numero totale di accessi effettuati",
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

  Future<int> _createAccessCountStatistics() async {
    int result = await Stats().countAccess();
    return result;
  }
}
