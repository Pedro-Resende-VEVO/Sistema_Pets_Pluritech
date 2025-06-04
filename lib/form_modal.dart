import 'package:flutter/material.dart';

var formData =
    {'tutor': '', 'species': '', 'race': '', 'entry_date': '', 'exit_date': ''}
        as Map<String, dynamic>;

class FormModal extends StatefulWidget {
  final String titleText;
  final Map<String, dynamic> data;
  final Function func;

  const FormModal({
    Key? key,
    required this.titleText,
    required this.func,
    this.data = const {},
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormModalState();
}

class _FormModalState extends State<FormModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.data != {}) {
      formData = widget.data;
    }

    return AlertDialog(
      title: Text(
        widget.titleText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Container(
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
                initialValue: formData['tutor'],
                onChanged: (newValue) => {formData['tutor'] = newValue},
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Espécie do Pet'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor inserir algum texto';
                  }
                  return null;
                },
                initialValue: formData['species'],
                onChanged: (newValue) => {formData['species'] = newValue},
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Raça'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor inserir algum texto';
                  }
                  return null;
                },
                initialValue: formData['race'],
                onChanged: (newValue) => {formData['race'] = newValue},
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Data de entrada'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor inserir algum texto';
                  }
                  return null;
                },
                initialValue: formData['entry_date'],
                onChanged: (newValue) => {formData['entry_date'] = newValue},
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Data de saída prevista',
                ),
                initialValue: formData['exit_date'],
                onChanged: (newValue) => {formData['exit_date'] = newValue},
              ),
            ],
          ),
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
            Navigator.of(context).pop();
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
