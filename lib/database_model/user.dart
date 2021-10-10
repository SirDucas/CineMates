import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';

class User {

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
    }
  }

  Future<bool> testDuplicatedUsername(String _username) async {
    bool flag = true;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select username from user');
    for (var row in result) {
      if (_username == row[0]) {
        print('username $_username già presente!!!!!!!!!');
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
        print('email $_email già presente!!!!!!!!!');
        flag = false;
      }
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }

}
