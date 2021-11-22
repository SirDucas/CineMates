import 'package:crypto/crypto.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:convert';

import 'database_connection.dart';

class Check {
  //metodo per convertire stringa a codifica MD5
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  bool checkUsernameLength(String input) {
    if (input.length < 6 || input.length > 16) {
      return false;
    } else {
      return true;
    }
  }

  bool checkPasswordLength(String input) {
    if (input.length < 8 || input.length > 32) {
      return false;
    } else {
      return true;
    }
  }

  bool checkEmail(String input) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    return emailValid;
  }

  Future<bool> checkUsername(String username) async {
    bool flag = false;
    username = escape(username);
    var db = new DatabaseConnection();
    await db.initConnection();
    var result = await db.conn
        .query('select username from user where username = ?', ['$username']);
    for (var row in result) {
      if (username == row['username']) {
        flag = true;
      }
    }
    return flag;
  }
}
