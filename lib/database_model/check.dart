import 'package:crypto/crypto.dart';
import 'dart:convert';

class Check {
  //metodo per convertire stringa a codifica MD5
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  bool checkLength(String input) {
    if (input.length <= 2 || input.length >= 11) {
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
}
