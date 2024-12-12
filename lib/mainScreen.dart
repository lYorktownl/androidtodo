import 'package:flutter/material.dart';
import 'authControl.dart';
import 'dataControl.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController paswController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DataControl dc = DataControl();
  final AuthControl ac = AuthControl();

  @override
  Widget build(BuildContext context) {
    final isAuth = ac.checkAuth();
    return isAuth ? showMenu(context) : showAuthForm(context);
  }

  Widget showMenu(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главное окно')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/secondScreen'),
              child: Text('Открыть 2 окно'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/screen3'),
              child: Text('Открыть третье окно'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/elementList'),
              child: Text('User List'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/elementForm'),
              child: Text('Element Form'),
            ),
            ElevatedButton(
              onPressed: () {
                ac.makeAuth("");
                Navigator.pushReplacementNamed(context, "/");
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget showAuthForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Авторизация"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                checkLogin(context, loginController.text, paswController.text);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face),
              hintText: "Login",
            ),
            controller: loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Login is empty";
              }
              if (value.length < 3) {
                return "Login must contain more than 3 symbols";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.password),
              hintText: "Password",
            ),
            controller: paswController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is empty";
              }
              if (value.length < 3) {
                return "Password must contain more than 3 symbols";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkLogin(context, loginController.text, paswController.text),
            child: Text("Sign in"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }

  void checkLogin(BuildContext context, String login, String password) {
    print("$login $password");
    String res = dc.checkUser(login, password);
    print(">>> $res");
    if (res.isNotEmpty) {
      ac.makeAuth(res);
      Navigator.pushReplacementNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Неправильный логин или пароль')),
      );
    }
  }
}
