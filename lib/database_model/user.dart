import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:string_validator/string_validator.dart';

class User {
  Future<bool> userLogin(String _email, String _password) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id, password from user where email = ?', ['$_email']);
    for (var row in result) {
      if (Check().generateMd5(_password) == row[1]) {
        await db.conn.close(); //chiusura connessione
        await FlutterSession().set('token', row['id']);
        await FlutterSession().set('log', 'yes');
        return true;
      } else {
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
      _username = escape(_username); //sicurezza su stringa username
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into user (username,email,password) values (?, ?, ?)',
          ['$_username', '$_email', '$_password']);
      await db.conn.close(); //chiusura connessione
      int idUser = await retrieveIdUser(_email);
      print(idUser);
      createFavoriteList(idUser);
    }
  }

  Future<int> retrieveIdUser(String _email) async {
    int idUser;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from user where email = ? ', ['$_email']);
    for (var row in result) {
      idUser = row['id'];
    }
    await db.conn.close(); //chiusura connessione
    return idUser;
  }

  void changePassword(String _newpassword, int _userID) async {
    if (_userID = await FlutterSession().get('token')) {
      if ((_newpassword.isEmpty) ||
          (Check().checkPasswordLength(_newpassword) == false))
        return;
      else {
        var db = new DatabaseConnection();
        await db.initConnection();
        _newpassword = Check().generateMd5(_newpassword); //converto password a MD5.
        var change= await db.conn.query(
            'UPDATE user SET password = ? WHERE id = ?',
            ['$_newpassword','$_userID']);
        await db.conn.close();
        return;
      }
    } else {
      return;
    }
  }

  //metodi di crazione liste e rimozione
  void createFavoriteList(int _idUser) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var favorites = await db.conn.query(
        'insert into list (id_user,description,title,isFavorites) values (?, ?, ?, ?)',
        ['$_idUser', "La mia lista preferiti", "Preferiti", 1]);
    await db.conn.close();
    return;
  }

  void createCustomList(int _idUser, String _description, String _title) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    if (_title.isEmpty) {
      print("errore il titolo è obbligatorio!"); // to-do alert
      return;
    } else {
      //con l'escape trasformo i caratteri speciali per maggior sicurezza
      _description = escape(_description);
      _title = escape(_title);
      var custom = await db.conn.query(
          'insert into list (id_user,description,title,isFavorites) values (?, ?, ?, ?)',
          ['$_idUser', '$_description', '$_title', 0]);
      await db.conn.close();
      return;
    }
  }

  //eliminazione customlist
  void deleteCustomList(int _idList) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    //cancello tutti i film dalla lista
    var delete = await db.conn
        .query('DELETE FROM favmovie where id_list = ?', ['$_idList']);
    //elimino la lista
    var deleteList =
        await db.conn.query('DELETE FROM list where id = ?', ['$_idList']);
    await db.conn.close();
    return;
  }

  //metodi di aggiunta favoriti
  void addMovieToFavorites(int _idMovie, int _idList) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into favmovie (id_movie,id_list) values (?, ?)',
        ['$_idMovie', '$_idList']);
    await db.conn.close(); //chiusura connessione
  }

  //metodi duplicati
  Future<bool> testDuplicateFavorite(int _idMovie, int _userId) async {
    bool flag = true;
    int idLista;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query = await db.conn.query(
        'select id from list where id_user = ? and isFavorites = 1',
        ['$_userId']);
    for (var row in query) {
      idLista = row['id'];
    }
    var querymovie = await db.conn
        .query('select id_movie from favmovie where id_list = ?', ['$idLista']);
    for (var row in querymovie) {
      if (_idMovie == row[0]) flag = false;
    }
    await db.conn.close();
    return flag;
  }

  Future<bool> testDuplicateCustom(int _idMovie, int _idList) async {
    bool flag = true;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query = await db.conn
        .query('select id_movie from favmovie where id_list = ?', ['$_idList']);
    for (var row in query) {
      if (_idMovie == row[0]) flag = false;
    }
    await db.conn.close();
    return flag;
  }

  Future<bool> testDuplicatedUsername(String _username) async {
    bool flag = true;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query('select username from user');
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
    var result = await db.conn.query('select email from user');
    for (var row in result) {
      if (_email == row[0]) {
        flag = false;
      }
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }

  //metodi rimozione
  void removeMovieFavorite(int _idMovie, int _userId) async {
    int idLista;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query = await db.conn.query(
        'select id from list where id_user = ? and isFavorites = 1',
        ['$_userId']);
    for (var row in query) {
      idLista = row['id'];
    }
    var delete = await db.conn.query(
        'DELETE FROM favmovie where id_list = ? AND id_movie = ?',
        ['$idLista', '$_idMovie']);

    await db.conn.close();
  }

  void removeMovieCustomList(int _idMovie, int _idList) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var delete = await db.conn.query(
        'DELETE FROM favmovie where id_list = ? AND id_movie = ?',
        ['$_idList', '$_idMovie']);
    await db.conn.close();
  }
}
