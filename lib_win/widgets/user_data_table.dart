import 'package:cinemates/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../alerts_desktop/alert_desktop_model.dart';
import '../database_model/admin.dart';

class UserDataTable extends StatefulWidget {
  const UserDataTable({Key key}) : super(key: key);

  @override
  _UserDataTableState createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  String dropdownValue = "Username";
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
    return FutureBuilder<List<UserModel>>(
      future: _generateUserData(),
      builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
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

  Widget _buildUserDataTable(List<UserModel> data) {
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
            DataColumn(label: Text("Username")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Data Iscrizione")),
            DataColumn(label: Text("Elimina")),
            DataColumn(
                label: Row(
              children: [
                Text("Modifica"),
                SizedBox(width: 5.0),
                DropdownButton<String>(
                  dropdownColor: Style.Colors.mainColor,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward,
                      color: Style.Colors.secondColor),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Style.Colors.secondColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Username', 'Email', 'Password']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            )),
            DataColumn(label: Text("è Admin"))
          ],
          rows: data
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text(e.id.toString(),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.username.toString(),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(e.email.toString(),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Text(
                        e.createTime
                            .toString()
                            .substring(0, e.createTime.toString().length - 5),
                        style: TextStyle(color: Colors.white))),
                    DataCell(Center(
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.blueGrey,
                            onPressed: () {
                              MyAlertDialogDesktop()
                                  .showDialogConfirmUserDelete(
                                      context, e.username);
                              setState(() {});
                            }))),
                    DataCell(Center(
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blueGrey,
                          onPressed: () {
                            MyAlertDialogDesktop().showDialogUpdateUser(context,
                                dropdownValue, e.username, e.email, e.password);
                          }),
                    )),
                    DataCell(Text(e.isAdmin.toString(),
                        style: TextStyle(color: Colors.white))),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  Future<List<UserModel>> _generateUserData() async {
    List<UserModel> result = await Admin().retrieveAllUserData();
    return result;
  }
}
