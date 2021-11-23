import 'package:cinemates/database_model/user.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';


class Friendship {

  void requestFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // mittente
    int _friendId = await User().retrieveIdUserByUsername(username); // ricevente
    bool _isFriend = await isFriend(_userId, _friendId);
    if (_isFriend == false) {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn.query(
          'insert into friendship (id_user1,id_user2) values (?,?)', ['$_userId', '$_friendId']
      );
      await db.conn.close();
    }
    else {
      print("amicizia già presente o sospesa");
    }
  }

  void acceptFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // ricevente
    int _friendId = await User().retrieveIdUserByUsername(username); // mittente
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'update friendship set isSuspended = 0 where id_user1 = ? and id_user2 = ?', ['$_friendId', '$_userId']
    );
    await db.conn.close();
  }

  void rejectFriendship(String username) async {
    int _userId = await FlutterSession().get('token'); // ricevente
    int _friendId = await User().retrieveIdUserByUsername(username); // mittente
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'delete from friendship where id_user1 = ? and id_user2 = ?', ['$_friendId', '$_userId']
    );
    await db.conn.close();
  }


  Future<List<String>> retrieveFriendshipSuspended() async {
    String username;
    int _friendId;
    int _userId = await FlutterSession().get('token'); // ricevente
    List<String> friendship = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select id_user1 from friendship where id_user2 = ? and isSuspended = 1', ['$_userId']
    );
    for (var row in result) {
      _friendId = row['id_user1'];
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
        'select * from friendship where id_user2 = ? OR id_user1 = ?  and isSuspended = 0', ['$_userId','$_userId']
    );
    for (var row in result) {
      if(row['id_user1'] == _userId){
        username = await User().retrieveUsernameById(row['id_user2']);
      } else {
        username = await User().retrieveUsernameById(row['id_user1']);
      }
      friendList.add(username);
    }
    return friendList;
  }

  Future<bool> isFriend(int _userId, int _friendId) async {
    bool flag = false;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query(
        'select id_user1 from friendship where id_user1 = ? and id_user2 = ?',
        ['$_userId', '$_friendId']);
    for (var row in result) {
      if (_userId == row[0])
        flag = true;
    }
    await db.conn.close(); //chiusura connessione
    return flag;
  }
}