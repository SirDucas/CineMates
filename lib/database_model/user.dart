import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';

class User {
  void userRegistration(
      String _username, String _email, String _password) async {
    if (_username.isEmpty || _email.isEmpty || _password.isEmpty) {
      print("errore"); //tutti i print vanno sostituiti con un alert!
      return;
    } else if (Check().checkLength(_username) == false) {
      print("Username deve essere compreso tra i 3 e gli 8 caratteri.");
      return;
    } else if (Check().checkLength(_password) == false) {
      print("Password deve essere compresa tra i 3 e gli 8 caratteri.");
    } else if (Check().checkEmail(_email) == false) {
      print("Email non valida!");
    } else {
      _password = Check().generateMd5(_password); //converto password a MD5.
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into user (username,email,password) values (?, ?, ?)',
          ['$_username', '$_email', '$_password']);
      await db.conn.close(); //chiusura connessione
    }
  }

}
