import 'package:cinemates/alerts/alert_dialog_model.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:cinemates/model/custom_list.dart';
import 'package:cinemates/model/favorite.dart';
import 'package:cinemates/screens/movie_custom_list_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:flutter_session/flutter_session.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({Key key}) : super(key: key);

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
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
      future: _createCustomLists(),
      builder: (context, AsyncSnapshot<List<CustomList>> snapshot) {
        if (snapshot.hasData) {
          return _buildCustomListsWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildCustomListsWidget(List<CustomList> data) {
    List<CustomList> customLists = [];
    customLists = List.from(data);
    if (customLists.length == 0) {
      return Scaffold(
          backgroundColor: Style.Colors.mainColor,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text("Crea lista"),
              backgroundColor: Style.Colors.secondColor,
              onPressed: () {
                MyAlertDialogs().showDialogCreateCustomListForm(context);
                setState(() {});
              },
            ),
          ),
          appBar: AppBar(
            backgroundColor: Style.Colors.mainColor,
            centerTitle: true,
            title: Text("Le tue liste"),
            elevation: 10.0,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Non hai ancora creato nessuna lista',
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 20.0),
                  )),
              SizedBox(height: 15.0),
              Center(child: Icon(Icons.error, size: 50, color: Colors.grey))
            ]),
          ));
    } else {
      return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("Crea lista"),
            backgroundColor: Style.Colors.secondColor,
            onPressed: () {
              MyAlertDialogs().showDialogCreateCustomListForm(context);
              setState(() {});
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          title: Text("Le tue liste"),
          elevation: 10.0,
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 25.0);
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: customLists.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: Colors.black38,
                        //   ),
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customLists[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(height: 12.0),
                                Text(
                                  customLists[index].description,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10.0
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieCustomListScreen(title: customLists[index].title)));
                                },
                                icon: Icon(Icons.arrow_forward),
                                color: CupertinoColors.white,
                            ),
                          ],
                        ),
                      ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieCustomListScreen(title: customLists[index].title)));
                    },
                  );
                })),
      );
    }
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text("Error occurred: $error")],
    ));
  }

  Widget _buildLoadingWidget() {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Le tue liste"),
        elevation: 10.0,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ])),
    );
  }

  Future<List<CustomList>> _createCustomLists() async {
    List<CustomList> customLists = [];
    int _userId = await FlutterSession().get('token');
    customLists = await User().retrieveCustomLists(_userId);
    return customLists;
  }
}
