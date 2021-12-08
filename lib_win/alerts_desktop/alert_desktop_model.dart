import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

import '../database_model/admin.dart';

class MyAlertDialogDesktop {
  showDialogConfirmUserDelete(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Style.Colors.mainColor,
              title: Text("Rimozione utente",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              content: Text("L'utente $username verrà cancellato. Sei sicuro?",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              actions: [
                TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Rimuovi utente"),
                  onPressed: () async {
                    Admin().deleteUser(username);
                    Navigator.pop(context);
                  },
                ),
              ]);
        });
  }

  showDialogSomethingsWrongCreateUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Style.Colors.mainColor,
              title: Text("Errore in creazione utente",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              content: Text(
                  "Qualcosa sembra essere andato storto.\n"
                  "Assicurati che:\n"
                  "- lo username inserito sia un identificatore unico\n"
                  "- non esista altro utente con la email inserita\n"
                  "- l'utente non sia stato già creato (visualizza dati in Crud Operator)",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              actions: [
                TextButton(
                  child: Text("Capito!"),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ]);
        });
  }

  showDialogUserCreate(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Style.Colors.mainColor,
              title: Text("Creazione nuovo utente",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      cursorColor: Style.Colors.secondColor,
                      cursorWidth: 1.5,
                      decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Style.Colors.secondColor),
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
                      controller: _emailController,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      cursorColor: Style.Colors.secondColor,
                      cursorWidth: 1.5,
                      decoration: InputDecoration(
                        hintText: "email",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Style.Colors.secondColor),
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
                      controller: _passwordController,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      cursorColor: Style.Colors.secondColor,
                      cursorWidth: 1.5,
                      decoration: InputDecoration(
                        hintText: "password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Style.Colors.secondColor),
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
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Crea utente"),
                  onPressed: () async {
                    if (!await Admin().createUser(_usernameController.text,
                        _emailController.text, _passwordController.text)) {
                      showDialogSomethingsWrongCreateUser(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ]);
        });
  }

  showDialogUpdateUser(BuildContext context, String dropdownValue, String username, String email, String password) {
    TextEditingController _stringController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Style.Colors.mainColor,
              title: Text("Modifica utente -> $dropdownValue",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Inserisci nuova stringa", style: TextStyle(color: Colors.white)),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _stringController,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      cursorColor: Style.Colors.secondColor,
                      cursorWidth: 1.5,
                      decoration: InputDecoration(
                        hintText: "nuova stringa",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Style.Colors.secondColor),
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
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Modifica utente"),
                  onPressed: () async {
                    if (dropdownValue == "Username") {
                      Admin().updateUsername(username, _stringController.text);
                      Navigator.pop(context);
                    }
                    else if (dropdownValue == "Email") {
                      Admin().updateEmail(username, _stringController.text);
                      Navigator.pop(context);
                    }
                    else if (dropdownValue == "Password") {
                      Admin().updatePassword(username, _stringController.text);
                      Navigator.pop(context);
                    }
                    else {
                      print("error");
                    }
                  },
                ),
              ]);
        });
  }
}
