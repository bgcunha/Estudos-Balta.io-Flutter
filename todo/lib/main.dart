import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'models/item.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  var items = <Item>[];
  HomePage() {
    items = [];
    // itens.add(Item(title: 'Banana', done: false));
    // itens.add(Item(title: 'Abacate', done: true));
    // itens.add(Item(title: 'Laranja', done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text.isEmpty) return;

    setState(() {
      widget.items.add(
        Item(
          title: newTaskCtrl.text,
          done: false,
        ),
      );
      newTaskCtrl.text = '';
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != '') {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJason(x)).toList();

      // List<Item> result = <Item>[];
      // result.add(Item(title: 'teste01', done: false));
      // result.add(Item(title: 'teste02', done: true));
      // result.add(Item(title: 'teste03', done: false));

      // for (var item in decoded) {
      //   result.add(item);
      //}

      setState(() {
        widget.items = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("data", jsonEncode(widget.items));
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Text('Bem Vindo!'),
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
              labelText: 'Informe uma nova tarefa',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        // actions: <Widget>[
        //   Icon(Icons.plus_one),
        // ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  if (value == true)
                    item.done = true;
                  else
                    item.done = false;

                  save();
                });
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              print(direction);
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent.shade400,
      ),
    );
  }
}
