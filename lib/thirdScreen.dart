import 'package:flutter/material.dart';
import 'httpRequest.dart';

class ThirdScreen extends StatefulWidget {
  final dynamic value;

  ThirdScreen({this.value});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController textarea = TextEditingController(text: "hi");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Окно редактирования')),
      body: Center(
        child: Column(
          children: [
            Text('HTTP'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreen');
              },
              child: Text('Oткрыть второе окно'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Открыть главное окно'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HttpRequests()),
                );
              },
              child: Text("Открыть HTTP Requests"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Haзaд"),
            ),
          ],
        ),
      ),
    );
  }
}
