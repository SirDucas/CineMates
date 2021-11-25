import 'package:cinemates/database_model/user.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:cinemates/database_model/feed.dart';

class Friendship {
  void requestFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // mittente
    int _friendId =
        await User().retrieveIdUserByUsername(username); // ricevente
    bool _isFriend = await isFriend(_userId, _friendId);
    if (_isFriend == false) {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into friendship (id_user1,id_user2) values (?,?)',
          ['$_userId', '$_friendId']);
      Feed().addFriendFeed(_userId, _friendId);
      await db.conn.close();
    } else {
      print("amicizia già presente o sospesa"); // inserire un alert dialog
    }
  }

  void acceptFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // ricevente
    int _friendId = await User().retrieveIdUserByUsername(username); // mittente
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'update friendship set isSuspended = 0 where id_user1 = ? and id_user2 = ?',
        ['$_friendId', '$_userId']);
    await db.conn.close();
  }

  void rejectFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // ricevente
    int _friendId = await User().retrieveIdUserByUsername(username); // mittente
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'delete from friendship where (id_user1 = ? and id_user2 = ?) OR (id_user2 = ? and id_user1 = ?)',
        ['$_friendId', '$_userId', '$_friendId', '$_userId']);
    await db.conn.close();
  }

  Future<List<String>> retrieveFriendshipSuspended() async {
    String username;
    int _userId = await FlutterSession().get('token'); // ricevente
    List<String> friendship = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select id_user1 from friendship where id_user2 = ? and isSuspended = 1',
        ['$_userId']);
    for (var row in result) {
      username = await User().retrieveUsernameById(row['id_user1']);
      friendship.add(username);
    }
    return friendship;
  }

  Future<List<String>> retrieveFriendList() async {
    String username;
    int _userId = await FlutterSession().get('token'); // ricevente
    List<String> friendList = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select * from friendship where (id_user2 = ? OR id_user1 = ?) and isSuspended = 0',
        ['$_userId', '$_userId']);
    for (var row in result) {
      if (_userId == row['id_user1']) {
        username = await User().retrieveUsernameById(row['id_user2']);
      } else if (_userId == row['id_user2']) {
        username = await User().retrieveUsernameById(row['id_user1']);
      } else {
        print("error");
      }
      friendList.add(username);
    }
    return friendList;
  }

  Future<List<int>> retrieveFriendListIds() async {
    int _userId = await FlutterSession().get('token');
    int _friendId;
    List<int> friendList = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select * from friendship where (id_user2 = ? OR id_user1 = ?) and isSuspended = 0',
        ['$_userId', '$_userId']);
    for (var row in result) {
      if (_userId == row['id_user1']) {
        _friendId = row['id_user2'];
      } else if (_userId == row['id_user2']) {
        _friendId = row['id_user1'];
      } else {
        print("error");
      }
      friendList.add(_friendId);
    }
    return friendList;
  }

  Future<bool> isFriend(int _userId, int _friendId) async {
    bool flag = false;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select * from friendship where (id_user1 = ? and id_user2 = ?) OR (id_user2 = ? and id_user1 = ?)',
        ['$_friendId', '$_userId', '$_friendId', '$_userId']);
    for (var row in result) {
      if (_userId == row['id_user1'] && _friendId == row['id_user2']) {
        flag = true;
      } else if (_userId == row['id_user2'] && _friendId == row['id_user1']) {
        flag = true;
      } else {
        flag = false;
      }
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }
}
