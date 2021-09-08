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

  String urlSignUp = "https://www.themoviedb.org/signup?language=it-IT";
  String urlForgotPassword = "https://www.themoviedb.org/reset-password";

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
                      prefixIcon:
                      Icon(EvaIcons.person, color: Colors.grey),
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
                      prefixIcon:
                      Icon(EvaIcons.person, color: Colors.grey),
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
                FlatButton(
                  padding: EdgeInsets.fromLTRB(200.0, 10.0, 10.0, 10.0),
                  onPressed: _launchURLForgotPassword,
                  textColor: Style.Colors.titleColor,
                  child: Text(
                      'Reset Password', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Style.Colors.mainColor,
                      color: Style.Colors.secondColor,
                      child: Text('Login'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Non hai un account?',
                          style: TextStyle(color: Colors.white),),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Registrati',
                            style: TextStyle(
                                fontSize: 20, color: Style.Colors.secondColor),
                          ),
                          onPressed: _launchURLSignUp,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }

  void _launchURLSignUp() async =>
    await canLaunch(urlSignUp) ? await launch(urlSignUp) : throw 'Could not launch $urlSignUp';

  void _launchURLForgotPassword() async =>
      await canLaunch(urlForgotPassword) ? await launch(urlForgotPassword) : throw 'Could not launch $urlForgotPassword';

}
