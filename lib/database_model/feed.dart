import 'package:cinemates/database_model/friendship.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cinemates/database_model/database_connection.dart';

class Feed {

  void addFriendFeed(int _userId, int _friendId) async {
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into feed (id_user, type, content) values (?, ?, ?)',
        ['$_userId',0, '$_friendId']);
    await db.conn.close();
  }

  void addMovieToFavoritesFeed(int _idMovie) async {
    int _userId = await FlutterSession().get('token');
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into feed (id_user, type, content) values (?, ?, ?)',
        ['$_userId',1,'$_idMovie']);
    await db.conn.close();
  }

  void addMovieToCustomFeed(int _idMovie, int _idList) async {
    int _userId = await FlutterSession().get('token');
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'insert into feed (id_user, type, content, id_list) values (?, ?, ?, ?)',
        ['$_userId',2,'$_idMovie','$_idList']);
    await db.conn.close();
  }

  void newCustomListFeed(String _title) async {
    int _idList;
    int _userId = await FlutterSession().get('token');
    var db = new DatabaseConnection();
    await db.initConnection();
    var title = await db.conn.query(
        'select id from list where title = ? and id_user = ? LIMIT 1',
        ['$_title','$_userId']);
    for (var row in title) {
      _idList = row[0];
    }
    var result = await db.conn.query(
        'insert into feed (id_user,type,id_list) values (?, ?, ?)',
        ['$_userId',3,'$_idList']);
    await db.conn.close();
  }

  Future<List<String>> personalFeedList() async {
    String username, friendUsername, movieTitle, listTitle, stringToAdd;
    List<int> friendList = [];
    List<String> activities = [];
    friendList = await Friendship().retrieveFriendListIds();
    print(friendList);
    var db = new DatabaseConnection();
    await db.initConnection();
    if (friendList.length == 1) {
      int index = friendList[0];
      var db = new DatabaseConnection();
      await db.initConnection();
      var resulta = await db.conn.query(
          'select * from feed where id_user = ? ORDER BY create_time DESC',
          [index]
      );
      for (var row in resulta) {
        if (row[2] == 0) {
          username = await User().retrieveUsernameById(row['id_user']);
          friendUsername = await User().retrieveUsernameById(row['content']);
          stringToAdd = (username + " ha aggiunto come amico " + friendUsername + "!");
          activities.add(stringToAdd);
        }
        else if (row[2] == 1) {
          username = await User().retrieveUsernameById(row['id_user']);
          movieTitle = await User().retrieveMovieTitleById(row['content']);
          stringToAdd = (username + " ha appena aggiunto il titolo " + movieTitle + " ai suoi preferiti!");
          activities.add(stringToAdd);
        }
        else if (row[2] == 2) {
          username = await User().retrieveUsernameById(row['id_user']);
          movieTitle = await User().retrieveMovieTitleById(row['content']);
          listTitle = await User().retrieveSingleListTitleById(row['id_list']);
          stringToAdd = (username + " ha appena aggiunto il titolo " + movieTitle + " alla sua lista personalizzata " + listTitle + "!");
          activities.add(stringToAdd);
        }
        else if (row[2] == 3) {
          username = await User().retrieveUsernameById(row['id_user']);
          listTitle = await User().retrieveSingleListTitleById(row['id_list']);
          stringToAdd = (username + " ha appena creato una nuova lista con il titolo " + listTitle);
          activities.add(stringToAdd);
        }
        else {
          print("errore");
        }
      }
    }
    else {
      int iteretor = 0;
      int length = friendList.length;
      while (iteretor <= length-1) {
        int index = friendList[iteretor];
        print(index);
        var results = await db.conn.query(
            'select * from feed where id_user = ?',
            [index]
        );
        for (var row in results) {
          print(row[2]);
          if (row[2] == 0) {
            username = await User().retrieveUsernameById(row['id_user']);
            friendUsername = await User().retrieveUsernameById(row['content']);
            stringToAdd = (username + "ha aggiunto come amico" + friendUsername + "!");
            activities.add(stringToAdd);
          }
          else if (row[2] == 1) {
            username = await User().retrieveUsernameById(row['id_user']);
            movieTitle = await User().retrieveMovieTitleById(row['content']);
            stringToAdd = (username + "ha appena aggiunto il titolo" + movieTitle);
            activities.add(stringToAdd);
          }
          else if (row[2] == 2) {
            username = await User().retrieveUsernameById(row['id_user']);
            movieTitle = await User().retrieveMovieTitleById(row['content']);
            listTitle = await User().retrieveSingleListTitleById(row['id_list']);
            stringToAdd = (username + "ha appena aggiunto il titolo" + movieTitle + "alla sua lista personalizzata " + listTitle + "!");
            activities.add(stringToAdd);
          }
          else if (row [2] == 3) {
            username = await User().retrieveUsernameById(row['id_user']);
            listTitle = await User().retrieveSingleListTitleById(row['id_list']);
            stringToAdd = (username + "ha appena creato una nuova lista con il titolo " + listTitle + "!");
            activities.add(stringToAdd);
          }
          else {
            print("errore");
          }
        }
        iteretor++;
      }
    }
    await db.conn.close();
    return activities;
  }

}
