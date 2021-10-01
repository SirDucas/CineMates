import 'package:cinemates/model/movie.dart';
import 'dart:async';
import 'package:cinemates/database_model/database_connection.dart';

class User {
  int id;
  String username;
  String email;
  String password;
  List<Movie> favorites;

  void userRegistration(String _username, String _email, String _password) async {

    if (_username.isEmpty || _email.isEmpty || _password.isEmpty) {
      print("errore");
      return;
    } else {

      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into user (username,email,password) values (?, ?, ?)',
          ['$_username', '$_email', '$_password']
      );
      await db.conn.close();
    }
  }
}
