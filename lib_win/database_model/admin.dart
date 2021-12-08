import 'package:cinemates/database_model/check.dart';
import 'package:cinemates/database_model/database_connection.dart';
import 'package:cinemates/model/activity.dart';
import 'package:cinemates/model/custom_list.dart';
import 'package:cinemates/model/user.dart';
import 'package:cinemates/session/session_model.dart';
import 'package:cinemates/database_model/user.dart';
import 'package:cinemates/model/user.dart';

class Admin {

  Future<bool> createUser(String _username, String _email, String _password,) async {
    bool userAlreadyExists = await Check().checkUsername(_username);
    if (userAlreadyExists)
      return false;
    if (!Check().checkUsernameLength(_username)
        || !Check().checkPasswordLength(_password)
        || !Check().checkEmail(_email)) {
      return false;
    }
    else {
      _password = Check().generateMd5(_password);
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('insert into user (username,email,password) values (?, ?, ?)',
          ['$_username', '$_email', '$_password']);
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
      newPassword = Check().generateMd5(newPassword);
      var db = new DatabaseConnection();
      await db.initConnection();
      var result = await db.conn
          .query('update user set password = ? where username = ?',
          ['$newPassword', '$username']);
      await db.conn.close();
      return true;
    }
  }

  Future<List<UserModel>> retrieveAllUserData() async {
    List<UserModel> data = [];
    UserModel user;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query("select * from user");
    for (var row in result) {
      user = new UserModel(row['id'], row['username'], row['email'], row['password'], row['create_time'], row['isAdmin']);
      data.add(user);
    }
    return data;
  }

  Future<List<Activity>> generateActivityList() async {
    List<Activity> data = [];
    Activity activity;
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn.query("select * from feed");
    for (var row in result) {
      activity = new Activity(row['id'], row['id_user'].toString(), row['type'], row['create_time'], row['content'].toString(), row['id_list'].toString(), "");
      data.add(activity);
    }
    return data;
  }

  Future<List<CustomList>> generateCustomListData() async {
    int idList;
    String title;
    String description;
    List<CustomList> customLists = [];
    var db = new DatabaseConnection();
    await db.initConnection();
    var result =
        await db.conn.query('select * from list');
    for (var row in result) {
      idList = row['id'];
      description = row['description'];
      title = row['title'];
      CustomList list = new CustomList(idList, title, description);
      customLists.add(list);
    }
    return customLists;
  }
}