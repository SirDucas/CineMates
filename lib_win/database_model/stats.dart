import 'package:cinemates/database_model/database_connection.dart';

class Stats {

  Future<int> countUsers() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM user');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countPreferiteList() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM list where isFavorite = 1');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countCustomList() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM list where isFavorite = 0');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countFriendship() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM friendship');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countFeed() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM feed');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countFavmovie() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM favmovie');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countAccess() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('SELECT COUNT(id) FROM access');

    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<int> countBestUser() async {
    int howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select id_user from access group by id_user order by count(*) desc limit 1'); //conta l'utente che è entrato di più
    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }

  Future<String> topFavoriteMovie() async {
    String howmany;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select title from favmovie group by title order by count(*) desc limit 1;'); //prende il titolo più inserito nei preferiti
    for (var row in result) {
      howmany = row[0];
    }
    print(howmany);
    return howmany;
  }


}