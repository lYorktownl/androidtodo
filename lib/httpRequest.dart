import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Requests'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sendGetRequest,
              child: Text('Send GET Request'),
            ),
            ElevatedButton(
              onPressed: _sendPostRequest,
              child: Text('Send POST Request'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendGetRequest() async {
    try {
      final response = await http.get(Uri.parse('https://localhost/api.php'));
      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending GET request: $error');
    }
  }

  void _sendPostRequest() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com'),
        body: jsonEncode({'key': 'value'}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }
}
