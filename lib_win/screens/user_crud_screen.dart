import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import '../alerts_desktop/alert_desktop_model.dart';
import '../widgets/user_data_table.dart';
import 'activity_crud_screen.dart';
import 'dashboard_screen.dart';
import 'list_crud_screen.dart';

class UserCrudOperatorScreen extends StatefulWidget {
  const UserCrudOperatorScreen({Key key}) : super(key: key);

  @override
  _UserCrudOperatorScreenState createState() => _UserCrudOperatorScreenState();
}

class _UserCrudOperatorScreenState extends State<UserCrudOperatorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Data Table"),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      backgroundColor: Style.Colors.mainColor,
        drawer: Drawer(
          backgroundColor: Style.Colors.mainColor,
          child: ListView(
            children: [
              Container(
                height: 100.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Style.Colors.mainColor,
                  ),
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Pannello Admin",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard_rounded,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.table_chart_rounded,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "CRUD Operator",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UserCrudOperatorScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Impostazioni Profilo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Style.Colors.secondColor,
                ),
                title: const Text(
                  "Termina sessione",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 40.0,
                      padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: RaisedButton(
                          textColor: Style.Colors.mainColor,
                          color: Style.Colors.secondColor,
                          child: Text('Crea Utente'),
                          onPressed: () {
                            MyAlertDialogDesktop().showDialogUserCreate(context);
                          }
                      )),
                  Container(
                      height: 40.0,
                      padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: RaisedButton(
                          textColor: Style.Colors.mainColor,
                          color: Style.Colors.secondColor,
                          child: Text('Aggiorna Dati Utente'),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => UserCrudOperatorScreen()));
                          }
                      )),
                  Container(
                      height: 40.0,
                      padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: RaisedButton(
                          textColor: Style.Colors.mainColor,
                          color: Style.Colors.secondColor,
                          child: Text('Visualizza Dati Liste'),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => ListCrudOperatorScreen()));
                          }
                      )),
                  Container(
                      height: 40.0,
                      padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: RaisedButton(
                          textColor: Style.Colors.mainColor,
                          color: Style.Colors.secondColor,
                          child: Text('Visualizza Dati Attività'),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => ActivityCrudOperatorScreen()));
                          }
                      )
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                color: Style.Colors.mainColor,
                child: UserDataTable(),
              ),
            ],
          ),
        ));
  }
}
