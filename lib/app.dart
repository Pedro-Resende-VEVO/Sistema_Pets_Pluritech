import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:teste/form_modal.dart';
import 'package:teste/snack_info.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Map<String, dynamic>> data = [];
  String apiUrl = 'http://192.168.0.121:3000/api';

  @override
  void initState() {
    _fillTable();
    super.initState();
  }

  Future<void> _fillTable() async {
    http.Response response = await http.get(Uri.parse(apiUrl));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    List<Map<String, dynamic>> tempData = (decodeJson)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    tempData.forEach((element) {
      addBtns(element);
    });

    setState(() {
      data = tempData;
    });
  }

  void addBtns(Map<String, dynamic> element) {
    element['edit_btn'] = ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => FormModal(
            titleText: 'Editar Cliente',
            func: editItem,
            data: element,
          ),
        );
      },
      child: Icon(Icons.edit),
    );

    element['delete_btn'] = ElevatedButton(
      onPressed: () => {deleteItem(element)},
      child: Icon(Icons.delete),
    );
  }

  void createItem(Map<String, dynamic> formData) async {
    String message = '';
    http.Response response = await http.post(
      Uri(
        scheme: 'http',
        host: '192.168.0.121',
        port: 3000,
        path: '/api',
        queryParameters: formData,
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      formData['id'] = jsonResponse['id'];
      addBtns(formData);

      setState(() => data.add(formData));
      message = jsonResponse['message'];
    } else {
      message =
          'Erro na crição do item: ERRO ${response.statusCode}\n${response.body}';
    }
    SnackInfo(context: context, title: message);
  }

  void editItem(Map<String, dynamic> formData) async {
    String message = '';

    Map<String, dynamic> tempData = Map.from(formData);
    tempData.remove('edit_btn');
    tempData.remove('delete_btn');
    tempData['id'] = tempData['id'].toString();
    
    http.Response response = await http.put(
      Uri(
        scheme: 'http',
        host: '192.168.0.121',
        port: 3000,
        path: '/api',
        queryParameters: tempData,
      ),
    );

    if (response.statusCode == 200) {
      int pos = data.indexOf(formData);
      setState(() => data[pos] = formData);
      message = response.body;
    } else {
      message =
          'Erro na remoção do item: ERRO ${response.statusCode}\n${response.body}';
    }
    SnackInfo(context: context, title: message);
  }

  void deleteItem(Map<String, dynamic> elementData) async {
    String message = '';
    int id = elementData['id'];

    http.Response response = await http.delete(
      Uri.parse('$apiUrl?id=${id.toString()}'),
    );

    if (response.statusCode == 200) {
      setState(() => data.remove(elementData));
      message = response.body;
    } else {
      message =
          'Erro na remoção do item: ERRO ${response.statusCode}\n${response.body}';
    }
    SnackInfo(context: context, title: message);
  }

  Map<String, dynamic>? findRow(id) {
    for (var row in data) {
      if (row['id'] == id) {
        return row;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Hotel Pet - PluriTech')),
      appBar: AppBar(title: Text('')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(),
          columns: const [
            DataColumn(label: Text('')),
            DataColumn(label: Text('')),
            DataColumn(label: Text('Responsável')),
            DataColumn(label: Text('Espécie')),
            DataColumn(label: Text('Raça')),
            DataColumn(label: Text('Data início')),
            DataColumn(label: Text('Data Saída')),
          ],
          rows: data.map((item) {
            return DataRow(
              cells: [
                DataCell(item['delete_btn']),
                DataCell(item['edit_btn']),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) =>
                FormModal(titleText: 'Adcionar Cliente', func: createItem),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
