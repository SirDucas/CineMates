import 'package:cinemates/database_model/database_connection.dart';
import 'package:flutter_session/flutter_session.dart';

class Data {
  dynamic token;

  Future<List> retrieveMovieList(int _idList) async {
    List favMovies;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from favmovie where id_list = ?', ['$_idList']);
    for (var row in result) {
      favMovies.add(row);
    }
    await db.conn.close();
    return favMovies;
  }

  Future<List> retrieveIdList() async {
    token = await FlutterSession().get('token');
    List customLists;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id from list where id_user = ?', ['$token']);
    for (var row in result) {
      customLists.add(row);
    }
    await db.conn.close();
    return customLists;
  }

  Future<int> retrieveFavoritesList() async {
    int favoritesId;
    token = await FlutterSession().get('token');
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select id from list where id_user = ? and isFavorites = 1',
        ['$token']);
    for (var row in result) {
      favoritesId = row['id'];
    }
    await db.conn.close();
    return favoritesId;
  }
}
