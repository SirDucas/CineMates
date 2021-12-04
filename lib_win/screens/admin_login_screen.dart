import 'package:cinemates/alerts/alert_dialog_model.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        elevation: 0,
      ),
      backgroundColor: Style.Colors.mainColor,
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Cinemates for Administrators',
                    style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              SizedBox(height: 35.0),
              Container(
                height: 60.0,
                width: 400.0,
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
                    hintText: "Email associata",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0),
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
                height: 60.0,
                width: 400.0,
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
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
                  height: 50.0,
                  width: 200.0,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                      textColor: Style.Colors.mainColor,
                      color: Style.Colors.secondColor,
                      child: Text(
                        'Accedi alla dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          MyAlertDialogs().showDialogEmptyField(context);
                        }
                        else if (!Check().checkEmail(emailController.text)) {
                          MyAlertDialogs().showDialogInvalidLoginField(context);
                        }
                        else {
                          if (await User().userLogin(
                              emailController.text, passwordController.text) ==
                              true) {}
                          else {
                            MyAlertDialogs().showDialogFailedLogin(context);
                          }
                        }
                      }
                  )),
              SizedBox(height: 50.0),
            ],
          )),
    );
  }
}