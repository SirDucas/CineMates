import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/bloc/get_movie_search_bloc.dart';
import 'package:cinemates/widgets/movie_search.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:cinemates/model/movie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final textFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Ricerca titoli"),
        elevation: 10.0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: textFieldController,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                cursorColor: Style.Colors.secondColor,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  hintText: "Cerca per titolo...",
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 18.0),
                  prefixIcon: Icon(EvaIcons.searchOutline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(EvaIcons.arrowForward, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MovieSearch(query: textFieldController.text))
                      );
                    }
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Style.Colors.secondColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}


