import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  'Registrati su Cinemates',
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
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                cursorColor: Style.Colors.secondColor,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  hintText: "email",
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
            SizedBox(height: 10.0),
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
                  child: Text('Registrati'),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
