import 'package:flutter/material.dart';
class SecondScreen extends StatelessWidget {
  var _value;

  SecondScreen({var value}) :_value = value;
  TextEditingController textarea = TextEditingController(text: "hi");

  @override
// void initState() {
// textarea.text = "Hello World";
//}
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Окно редактирвоания')),
      body: Center (child: Column (children: [
        Text('редактирование'),
        ElevatedButton (onPressed: () {Navigator.pushNamed (context, '/thirdScreen'); },
            child: Text('Oткрыть 3 окно')),
        ElevatedButton (onPressed: () {Navigator.pushNamed (context, '/');},
            child: Text('Открыть главное окно')),
        ElevatedButton (onPressed: () {
          Navigator.pop(context);
        }, child: Text("Haзaд")),
      ],)

      ),
    );
  }
}