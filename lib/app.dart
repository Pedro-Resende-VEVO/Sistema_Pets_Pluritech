// import 'dart:convert';
// import 'component/book.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // List<Book> _books = [];
  @override
  void initState() {
    super.initState();
    // _fetchBooks();
  }

  // Future<void> _fetchBooks() async {
  //   final response = await http.get(
  //     Uri(scheme: 'http', host: '127.0.0.1', path: '/', port: 3000),
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> json = jsonDecode(response.body);
  //     setState(() {
  //       _books = json.map((item) => Book.fromJson(item)).toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load books');
  //   }
  // }

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
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              Text('col 1'),
              Text('col 2'),
              Text('col 3'),
              Text('col 3'),
              Text('col 3'),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Colors.grey),
            children: <Widget>[
              Text('col 1'),
              Text('col 2'),
              Text('col 3'),
              Text('col 4'),
              Text('col 5'),
            ],
          ),
        ],
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
