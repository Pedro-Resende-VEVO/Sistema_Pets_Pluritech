import 'package:flutter/material.dart';

class FormModal extends StatefulWidget {
  final String titleText;
  final Function func;

  const FormModal({
    Key? key,
    required this.titleText,
    required this.func,
    Map<String, dynamic>? data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormModalState();
}

class _FormModalState extends State<FormModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formData = {
    'tutor': '',
    'species': '',
    'race': '',
    'entry_date': '',
    'exit_date': '',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.titleText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Responsável'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
              onSaved: (newValue) => formData['tutor'] = newValue.toString(),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Espécie do Pet'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
              onSaved: (newValue) => formData['species'] = newValue.toString(),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Raça'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
              onSaved: (newValue) => formData['race'] = newValue.toString(),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Data de entrada'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
              onSaved: (newValue) => formData['entry_date'] = newValue.toString(),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Data de saída prevista',
              ),
              onSaved: (newValue) => formData['exit_date'] = newValue.toString(),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.func(formData);
            }
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
