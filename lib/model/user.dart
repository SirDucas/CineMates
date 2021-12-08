import 'package:flutter/material.dart';

class UserModel {

  int _id;
  String _username;
  String _email;
  String _password;
  DateTime _createTime;
  int _isAdmin;

  UserModel(this._id, this._username, this._email, this._password, this._createTime,
      this._isAdmin);

  set isAdmin(int value) {
    _isAdmin = value;
  }

  set createTime(DateTime value) {
    _createTime = value;
  }

  set password(String value) {
    _password = value;
  }

  set email(String value) {
    _email = value;
  }

  set username(String value) {
    _username = value;
  }

  set id(int value) {
    _id = value;
  }

  int get isAdmin => _isAdmin;

  DateTime get createTime => _createTime;

  String get password => _password;

  String get email => _email;

  String get username => _username;

  int get id => _id;
}