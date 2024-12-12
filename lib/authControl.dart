import 'package:shared_preferences/shared_preferences.dart';

class AuthControl {
  String authKey="userAuthid";
  static int status =0;
  static String userUid="";
  dataInit() async{
    if (status ==0){
      userUid = await _getData();
    }
    status =1;
  }
  String getItem(int index){
    return userUid;
  }
  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authKey) ?? "";
  }
  void printData (){
    print (userUid);
  }
  bool checkAuth(){
    return userUid !="";
  }
  makeAuth(String Uid) async {
    userUid = Uid;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(authKey, Uid);
  }

}
