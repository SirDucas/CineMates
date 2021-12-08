import 'package:cinemates/model/activity.dart';
import 'package:cinemates/model/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import '../database_model/admin.dart';

class ListDataTable extends StatefulWidget {
  const ListDataTable({Key key}) : super(key: key);

  @override
  _ListDataTableState createState() => _ListDataTableState();
}

class _ListDataTableState extends State<ListDataTable> {
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
    return FutureBuilder<List<CustomList>>(
      future: _generateListData(),
      builder: (context, AsyncSnapshot<List<CustomList>> snapshot) {
        if (snapshot.hasData) {
          return _buildListDataTable(snapshot.data);
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

  Widget _buildListDataTable(List<CustomList> data) {
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
            DataColumn(label: Text("Id")),
            DataColumn(label: Text("Titolo")),
            DataColumn(label: Text("Descrizione")),
          ],
          rows: data
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text(e.idList.toString(), style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.title, style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.description.toString(), style: TextStyle(color: Colors.white))),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  Future<List<CustomList>> _generateListData() async {
    List<CustomList> result = await Admin().generateCustomListData();
    return result;
  }
}
