import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DataControl {
  static const datakey = 'membersData';
  static var _members = [];
  static int status = 0;

  dataInit() async {
    if (status == 0) {
      _members = json.decode(await _getData());
    }
    status = 1;
  }

  getItem(int i) {
    return _members[i]; // Return the element at the specified index
  }

  int getLength() {
    return _members.length;
  }

  Future<void> saveItem(int i, String login, String pasw, String name, String email) async {
    if (i >= 0 && i < _members.length) {
      _members[i]["login"] = login;
      _members[i]["pasw"] = pasw;
      _members[i]["name"] = name;
      _members[i]["email"] = email;
    }
    await _saveData();
  }

  Future<void> addItem(String login, String pasw, String name, String email) async {
    var uid = const Uuid();
    Map item = {
      "UID": uid.v1(),
      "login": login,
      "pasw": pasw,
      "name": name,
      "email": email
    };
    _members.add(item);
    await _saveData();
  }

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(datakey) ?? "[]";
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(datakey, jsonEncode(_members));
  }

  void printData() {
    print(_members);
  }

  String checkUser(String login, String pasw) {
    for (int i = 0; i < _members.length; i++) {
      if (_members[i]["login"] == login && _members[i]["pasw"] == pasw) {
        return _members[i]["UID"];
      }
    }
    return "";
  }

  Future<String> getStringInfo(String Key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Key) ?? "";
  }

  Future<void> setStringInfo(String Key, String Value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Key, Value);
  }
}
