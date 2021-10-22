import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:flutter_session/flutter_session.dart';

class User {

  Future<bool> userLogin (String _email, String _password) async {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'select id, password from user where email = ?', ['$_email']);
      for (var row in result) {
        if (Check().generateMd5(_password) == row[1]) {
          await db.conn.close(); //chiusura connessione
          await FlutterSession().set('token', row['id']);
          await FlutterSession().set('log', 'yes');
          return true;
        }
        else {
          await db.conn.close(); //chiusura connessione
          return false;
        }
      }
      await db.conn.close(); //chiusura connessione
      return false;
  }

  void userRegistration(
      String _username, String _email, String _password) async {
    if ((_username.isEmpty || _email.isEmpty || _password.isEmpty) ||
        (Check().checkUsernameLength(_username) == false) ||
        (Check().checkPasswordLength(_password) == false) ||
        (Check().checkEmail(_email) == false))
      return;
    else {
      _password = Check().generateMd5(_password); //converto password a MD5.
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into user (username,email,password) values (?, ?, ?)',
          ['$_username', '$_email', '$_password']);
      await db.conn.close(); //chiusura connessione
      if (result != null) {
        int idUser = await retrieveIdUser(_email);
        print(idUser);
        createFavoriteList(idUser);
      }
    }
  }

  Future<int> retrieveIdUser(String _email) async {
    int idUser;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select id from user where email = ? ',
        ['$_email']);
    for (var row in result) {
      idUser = row['id'];
    }
    await db.conn.close(); //chiusura connessione
    return idUser;
  }

  void createFavoriteList(var _idUser) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var favorites =  await db.conn.query(
        'insert into list (id_user,description,title,isFavoriteList) values (?, ?, ?, ?)',
        ['$_idUser', "La mia lista preferiti", "Preferiti", 1]);
    await db.conn.close();
    return;
  }

  Future<bool> testDuplicatedUsername(String _username) async {
    bool flag = true;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select username from user');
    for (var row in result) {
      if (_username == row[0]) {
        flag = false;
      }
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }

  Future<bool> testDuplicatedEmail(String _email) async {
    bool flag = true;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select email from user');
    for (var row in result) {
      if (_email == row[0]) {
        flag = false;
      }
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }

  void addMovieToFavorites(int _idMovie, int _idList) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into list (id,id_list) values (?, ?)',
        ['$_idMovie', '$_idList']);
    await db.conn.close(); //chiusura connessione
  }
}
