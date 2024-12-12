import 'package:flutter/material.dart';
import 'dataControl.dart';

class ElementList extends StatefulWidget {
  final String? value;

  ElementList({this.value});

  @override
  _ElementListState createState() => _ElementListState();
}

class _ElementListState extends State<ElementList> {
  final DataControl dc = DataControl();
  final TextStyle biggerFont = const TextStyle(fontSize: 28.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список элементов"),
      ),
      body: _buildList(context), // Вызываем метод для построения списка
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _btnPress(context); // Вызываем метод при нажатии на кнопку
        },
        label: Text("Press"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightGreenAccent,
        foregroundColor: Colors.black54,
        elevation: 10,
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dc.getLength(),
      itemBuilder: (BuildContext context, int position) {
        return _listRow(context, position);
      },
    );
  }

  Widget _listRow(BuildContext context, int index) {
    return ListTile(
      title: Text("${dc.getItem(index)['login']}", style: biggerFont),
      onTap: () => Navigator.pushNamed(context, "/elementForm/$index"),
    );
  }

  void _btnPress(BuildContext context) async {
    await dc.addItem("Новый человек", "123","123","123@"); // Добавляем новый элемент
    setState(() {}); // Обновляем состояние виджета
  }
}










