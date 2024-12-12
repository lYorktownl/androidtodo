import 'package:flutter/material.dart';
import 'text_content.dart';
import 'dart:convert';

import 'dataControl.dart';
import 'authControl.dart';
import 'registerScreen.dart';
import 'mainScreen.dart';
import 'secondScreen.dart';
import 'thirdScreen.dart';
import 'httpRequest.dart';
import 'elementList.dart';
import 'elementForm.dart';

void main() async {
  DataControl dc = new DataControl();
  AuthControl ac = new AuthControl();

  await dc.dataInit();
  await ac.dataInit();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MainScreen(),
      '/register': (context) => RegisterScreen(),
      '/secondScreen': (BuildContext context) => SecondScreen(),
      '/thirdScreen': (BuildContext context) => ThirdScreen(),
      '/elementList': (BuildContext context) => ElementList(),
      '/httpRequests': (context) => HttpRequests(),
      '/elementForm': (BuildContext context) => ElementForm(),
    },
    onGenerateRoute: (routeSettings) {
      var path = [];
      String rname = routeSettings.name.toString();
      path = rname.split('/');

      if (path.length > 1) {
        switch (path[1]) {
          case "second":
            return MaterialPageRoute(
              builder: (context) => SecondScreen(value: path.length > 2 ? path[2] : null),
              settings: routeSettings,
            );
          case "screen3":
            return MaterialPageRoute(
              builder: (context) => ThirdScreen(value: path.length > 2 ? path[2] : null),
              settings: routeSettings,
            );
          case "elementList":
            return MaterialPageRoute(
              builder: (context) => ElementList(value: path.length > 2 ? path[2] : null),
              settings: routeSettings,
            );
          case "elementForm":
            return MaterialPageRoute(
              builder: (context) => ElementForm(value: path.length > 2 ? path[2] : null),
              settings: routeSettings,
            );
        }
      }
      return null; // Return null if no match is found
    },
  ));
}
