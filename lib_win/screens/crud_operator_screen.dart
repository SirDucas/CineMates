import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import '../widgets/user_data_table.dart';
import 'dashboard_screen.dart';

class CrudOperatorScreen extends StatefulWidget {
  const CrudOperatorScreen({Key key}) : super(key: key);

  @override
  _CrudOperatorScreenState createState() => _CrudOperatorScreenState();
}

class _CrudOperatorScreenState extends State<CrudOperatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              }),
        ),
        body: Container(
          color: Style.Colors.mainColor,
          child: UserDataTable(),
        ));
  }
}
