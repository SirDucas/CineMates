import 'package:cinemates/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String urlTmdb = "https://www.themoviedb.org/?language=it-IT";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Style.Colors.mainColor, elevation: 0),
      backgroundColor: Style.Colors.mainColor,
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Cinemates Login',
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 30),
                  )),
              SizedBox(height: 35.0),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  cursorColor: Style.Colors.secondColor,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    hintText: "username",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0),
                    prefixIcon: Icon(EvaIcons.person, color: Colors.grey),
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  cursorColor: Style.Colors.secondColor,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0),
                    prefixIcon: Icon(EvaIcons.person, color: Colors.grey),
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
              SizedBox(height: 25.0),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Style.Colors.mainColor,
                    color: Style.Colors.secondColor,
                    child: Text('Login'),
                    onPressed: () {},
                  )),
              SizedBox(height: 50.0),
              Container(
                child: Center(
                    child: Text(
                  'Non hai un account?',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                )),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Center(
                    child: RaisedButton(
                  textColor: Style.Colors.mainColor,
                  color: Style.Colors.secondColor,
                  child: Text('Registrati qui'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                )),
              ),
            ],
          )),
    );
  }

  void _launchUrl() async => await canLaunch(urlTmdb)
      ? await launch(urlTmdb)
      : throw 'Could not launch $urlTmdb';
}
