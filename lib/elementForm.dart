import 'package:flutter/material.dart';
import 'dataControl.dart';

class ElementForm extends StatefulWidget {
  final String? value;
  ElementForm({this.value});

  @override
  _ElementFormState createState() => _ElementFormState();

  getValue() {
    return value;
  }
}

class _ElementFormState extends State<ElementForm> {
  DataControl dc = DataControl();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController paswController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      var item = dc.getItem(int.parse(widget.value!));
      loginController.text = item['login'] ?? '';
      paswController.text = item['pasw'] ?? '';
      nameController.text = item['name'] ?? '';
      emailController.text = item['email'] ?? '';
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактирование элемента"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _btnPress();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face),
              hintText: "Логин",
            ),
            controller: loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Логин пустой";
              }
              if (value.length < 3) {
                return "Логин должен быть не короче 3 символов";
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
              hintText: "Пароль",
            ),
            controller: paswController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Пароль пустой";
              }
              if (value.length < 3) {
                return "Пароль должен быть не короче 3 символов";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              hintText: "Имя",
            ),
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Имя пустое";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              hintText: "Email",
            ),
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email пустой";
              }
              if (!value.contains('@')) {
                return "Email должен содержать @";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Save'),
            onPressed: _btnPress,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void _btnPress() async {
    await dc.saveItem(
      int.parse(widget.value!),
      loginController.text,
      paswController.text,
      nameController.text,
      emailController.text,
    );
    Navigator.pop(context);
  }
}
