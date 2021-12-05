import 'package:cinemates/database_model/check.dart';
import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/model/user.dart';
import 'package:cinemates/session/session_model.dart';

class Admin {

  Future<bool> createUser(String username, String email, String password,) async {
    if (!Check().checkUsernameLength(username)
        || !Check().checkPasswordLength(password)
        || !Check().checkEmail(email)) {
      return false;
    }
    else {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('insert into user (username,email,password) values (?, ?, ?)',
          ['$username', '$email', '$password']);
      await db.conn.close();
      return true;
    }
  }

  Future<bool> deleteUser(String username) async {
    if (Check().checkUsername(username) == true) {
      return false;
    }
    else {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('delete from user where username = ?',
          ['$username']);
      await db.conn.close();
      return true;
    }
  }

  Future<bool> updateUsername(String username, String newUsername) async {
    if (Check().checkUsername(username) == true) {
      return false;
    }
    else {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('update user set username = ? where username = ?',
          ['$newUsername', '$username']);
      await db.conn.close();
      return true;
    }
  }

  Future<bool> updateEmail(String username, String newEmail) async {
    if (Check().checkUsername(username) == true) {
      return false;
    }
    else {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('update user set email = ? where username = ?',
          ['$newEmail', '$username']);
      await db.conn.close();
      return true;
    }
  }

  Future<bool> updatePassword(String username, String newPassword) async {
    if (Check().checkUsername(username) == true) {
      return false;
    }
    else {
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('update user set password = ? where username = ?',
          ['$newPassword', '$username']);
      await db.conn.close();
      return true;
    }
  }

  Future<List<User>> retrieveAllUserData() async {
    List<User> data = [];
    User user;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query("select * from user");
    for (var row in result) {
      user = new User(row['id'], row['username'], row['email'], row['password'], row['create_time'], row['isAdmin']);
      data.add(user);
    }
    return data;
  }

}