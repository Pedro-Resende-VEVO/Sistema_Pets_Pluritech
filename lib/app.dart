import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    _fillTable();
    super.initState();
  }

  Future<void> _fillTable() async {
    http.Response response = await http.get(
      Uri.parse('http://192.168.0.121:3000/api'),
    );
    final List<dynamic> decodeJson = jsonDecode(response.body);
    setState(() {
      data = (decodeJson).map((item) => item as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(),
          columns: const [
            DataColumn(label: Text('Responsável')),
            DataColumn(label: Text('Espécie')),
            DataColumn(label: Text('Raça')),
            DataColumn(label: Text('Data início')),
            DataColumn(label: Text('Data Saída')),
          ],
          rows: data.map((item) {
            return DataRow(
              cells: [
                DataCell(Text('${item['tutor']}')),
                DataCell(Text('${item['species']}')),
                DataCell(Text('${item['race']}')),
                DataCell(Text('${item['entry_date']}')),
                DataCell(Text('${item['exit_date']}')),
              ],
            );
          }).toList(),
        ),
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
