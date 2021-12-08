import 'package:cinemates/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import '../database_model/admin.dart';

class ActivityDataTable extends StatefulWidget {
  const ActivityDataTable({Key key}) : super(key: key);

  @override
  _ActivityDataTableState createState() => _ActivityDataTableState();
}

class _ActivityDataTableState extends State<ActivityDataTable> {
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
      future: _generateActivityData(),
      builder: (context, AsyncSnapshot<List<Activity>> snapshot) {
        if (snapshot.hasData) {
          return _buildActivityDataTable(snapshot.data);
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

  Widget _buildActivityDataTable(List<Activity> data) {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Style.Colors.mainColor,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(width: 0.2),
          dataTextStyle: TextStyle(color: Colors.white),
          headingRowHeight: 40.0,
          headingTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          dataRowHeight: 35.0,
          showCheckboxColumn: true,
          dividerThickness: 3.0,
          columns: [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Utente ID")),
            DataColumn(label: Text("Tipo")),
            DataColumn(label: Text("Data Creazione")),
            DataColumn(label: Text("Contenuto ID")),
            DataColumn(label: Text("Lista ID")),
          ],
          rows: data
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text(e.id.toString(),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.username,
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.type.toString(),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.createTime.toString().substring(0, e.createTime.toString().length - 5),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.friendUsername,
                      style: TextStyle(color: Colors.white),
                    )),
                    DataCell(Text(e.movieTitle,
                      style: TextStyle(color: Colors.white),
                    )),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  Future<List<Activity>> _generateActivityData() async {
    List<Activity> result = await Admin().generateActivityList();
    return result;
  }
}
