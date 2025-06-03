import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<TableRow> tables = [];
  List<List<Widget>> _rows = [];

  @override
  void initState() {
    super.initState();
    _fillTable();

  }

  Future<void> _fillTable() async {
    final response = await http.get(Uri.parse('http://192.168.18.11:3000/api'));

    if (response.statusCode == 200) {
      final List<dynamic> decodeJson = jsonDecode(response.body);
      final Iterable<dynamic> ids = decodeJson
          .map((e) => e.remove('id'))
          .toList();

      print(decodeJson);

      if (decodeJson.isNotEmpty) {
        List<Widget> _columns = [];
        decodeJson[0].forEach((key, value) => _columns.add(Text(key)));

        _rows.add(_columns);
        _rows = decodeJson.map((e) {
          List<Widget> a = [];
          e.forEach((key, value) => a.add(Text(value.toString())));
          return a;
        }).toList();
        print(_rows);

        _rows.forEach((e) => tables.add(TableRow(children: e)));
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(64),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: tables
        // children: <TableRow>[
        //   TableRow(
        //     children: <Widget>[
        //       Text('col 1'),
        //       Text('col 2'),
        //       Text('col 3'),
        //       Text('col 3'),
        //       Text('col 3'),
        //     ],
        //   ),
        // ],
      ),
      // body: ListView.builder(
      //   itemCount: _books.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       title: Text(_books[index].title),
      //       subtitle: Text(_books[index].author),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
