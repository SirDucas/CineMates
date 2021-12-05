import 'package:cinemates/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/admin.dart';
import '../database_model/stats.dart';

class UserDataTable extends StatefulWidget {
  const UserDataTable({Key key}) : super(key: key);

  @override
  _UserDataTableState createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
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
    return FutureBuilder<List<User>>(
      future: _generateUserData(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          return _buildUserDataTable(snapshot.data);
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

  Widget _buildUserDataTable(List<User> data) {
    return Container(
        padding: EdgeInsets.all(10.0),
        color: Style.Colors.mainColor,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Id", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Username", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Data Iscrizione", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ],
          rows: data.map(
                  (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(e.id.toString(), style: TextStyle(color: Colors.white))),
                        DataCell(Text(e.username.toString(), style: TextStyle(color: Colors.white))),
                        DataCell(Text(e.email.toString(), style: TextStyle(color: Colors.white))),
                        DataCell(Text(e.createTime.toString(), style: TextStyle(color: Colors.white))),
                      ])).toList(),
        ),
    );
  }

  Future<List<User>> _generateUserData() async {
    List<User> result = await Admin().retrieveAllUserData();
    return result;
  }
}
