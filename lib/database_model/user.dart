import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:cinemates/model/custom_list.dart';
import 'package:cinemates/model/favorite.dart';
import 'package:cinemates/model/movie.dart';
import 'package:cinemates/session/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:string_validator/string_validator.dart';
import 'package:cinemates/database_model/feed.dart';

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
      int idUser = await retrieveIdUserByEmail(_email);
      print(idUser);
      createFavoriteList(idUser);
    }
  }

  Future<int> retrieveIdUserByEmail(String _email) async {
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

  Future<int> retrieveIdUserByUsername(String _username) async {
    int idUser;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from user where username = ? ', ['$_username']);
    for (var row in result) {
      idUser = row['id'];
    }
    await db.conn.close(); //chiusura connessione
    return idUser;
  }

  Future<String> retrieveUsernameById(int idUser) async {
    String username;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select username from user where id = ? ', ['$idUser']);
    for (var row in result) {
      username = row['username'];
    }
    await db.conn.close(); //chiusura connessione
    return username;
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
      Feed().newCustomListFeed(_title);
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
  void addMovieToFavorites(
      int _idMovie, String _title, String _poster, int _idList) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into favmovie (id_movie,title,poster,id_list) values (?, ?, ?, ?)',
        ['$_idMovie', '$_title', '$_poster', '$_idList']);
    Feed().addMovieToFavoritesFeed(_idMovie);
    await db.conn.close(); //chiusura connessione
  }

  void addMovieToCustomList(int _idMovie, String _title, String _poster, String _titleList) async {
    int _idList = await retrieveSingleListIdByTitle(_titleList);
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into favmovie (id_movie,title,poster,id_list) values (?, ?, ?, ?)',
        ['$_idMovie', '$_title', '$_poster', '$_idList']);
    Feed().addMovieToCustomFeed(_idMovie, _idList);
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

  void removeMovieCustomList(int _idMovie, String _title) async {
    int _idList = await retrieveSingleListIdByTitle(_title);
    var db = new DatabaseConnection();
    await db.initConnection();
    var delete = await db.conn.query(
        'DELETE FROM favmovie where id_list = ? AND id_movie = ?',
        ['$_idList', '$_idMovie']);
    await db.conn.close();
  }

  Future<List<int>> retrieveMoviesIdFromList(int _userId) async {
    List<int> movies;
    int idList;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query = await db.conn
        .query('select id from list where id_user = ?', ['$_userId']);
    for (var row in query) {
      idList = row['id'];
    }
    var result = await db.conn
        .query('select id_movie from favmovie where id_list = ?', ['$idList']);
    for (var row in result) {
      movies.add(row['id_movie']);
    }

    await db.conn.close();

    return movies;
  }

  Future<List<int>> retrieveMoviesIdFromFavorites(int _userId) async {
    List<int> movies = [];
    int idList;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query = await db.conn.query(
        'select id from list where id_user = ? and isFavorites = 1',
        ['$_userId']);
    for (var row in query) {
      idList = row['id'];
    }
    var result = await db.conn
        .query('select id_movie from favmovie where id_list = ?', ['$idList']);
    for (var row in result) {
      movies.add(row['id_movie']);
    }

    await db.conn.close();

    return movies;
  }

  Future<String> retrieveMovieTitleById(int _movieId) async {
    String movieTitle;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select title from favmovie where id_movie = ? LIMIT 1',
        ['$_movieId']);
    for (var row in result) {
      movieTitle = row['title'];
    }
    return movieTitle;
  }

  Future<List<int>> retrieveListId(int _userId) async {
    List<int> customLists;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from list where id_user = ?', ['$_userId']);
    for (var row in result) {
      customLists.add(row['id']);
    }

    await db.conn.close();

    return customLists;
  }

  Future<String> retrieveListDescription(int idList) async {
    String description;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select description from list where id = ?', ['$idList']);
    for (var row in result) {
      description = (row['description']);
    }

    await db.conn.close();

    return description;
  }

  Future<List<String>> retrieveListTitles(int _userId) async {
    List<String> titles = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result =
        await db.conn.query('select title from list where id_user = ?', ['$_userId']);
    for (var row in result) {
      titles.add(row['title']);
    }

    await db.conn.close();

    return titles;
  }
  
  Future<List<Favorite>> retrieveFavorites(int _userId) async {
    int movieId;
    String title;
    String poster;
    List<Favorite> favorites = [];
    int idList;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query =
        await db.conn.query('select id from list where id_user = ? and isFavorites = 1', ['$_userId']);
    for (var row in query) {
      idList = row['id'];
    }
    var result = await db.conn
        .query('select id_movie,title,poster from favmovie where id_list = ?', ['$idList']);
    for (var row in result) {
      movieId = row['id_movie'];
      title = row['title'];
      poster = row['poster'];
      Favorite movie = new Favorite(movieId, title, poster);
      favorites.add(movie);
    }
    return favorites;
  }

  Future<List<CustomList>> retrieveCustomLists(int _userId) async {
    int idList;
    String title;
    String description;
    List<CustomList> customLists = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result =
        await db.conn.query('select id,description,title from list where id_user = ? and isFavorites = 0', ['$_userId']);
    for (var row in result) {
      idList = row['id'];
      description = row['description'];
      title = row['title'];
      CustomList list = new CustomList(idList, title, description);
      customLists.add(list);
    }
    return customLists;
  }

  Future<List<Favorite>> retrieveMovieFromCustomList(int _userId, String _title) async {
    int movieId;
    String title;
    String poster;
    List<Favorite> favorites = [];
    int idList;
    var db = new DatabaseConnection();
    await db.initConnection();
    var query =
        await db.conn.query('select id from list where id_user = ? and title = ?', ['$_userId', '$_title']);
    for (var row in query) {
      idList = row['id'];
    }
    var result = await db.conn
        .query('select id_movie,title,poster from favmovie where id_list = ?', ['$idList']);
    for (var row in result) {
      movieId = row['id_movie'];
      title = row['title'];
      poster = row['poster'];
      Favorite movie = new Favorite(movieId, title, poster);
      favorites.add(movie);
    }
    return favorites;

  }

  Future<int> retrieveSingleListIdByTitle(String _titleList) async {
    int idList;
    int userId = await FlutterSession().get('token');
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from list where title = ? and id_user = ?', ['$_titleList', '$userId']);
    for (var row in result) {
      idList = row['id'];
    }
    await db.conn.close();
    return idList;
  }

  Future<String> retrieveSingleListTitleById(int _idList) async {
    String titleList;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select title from list where id = ?', ['$_idList']);
    for (var row in result) {
      titleList = row['title'];
    }
    await db.conn.close();
    return titleList;
  }
}
