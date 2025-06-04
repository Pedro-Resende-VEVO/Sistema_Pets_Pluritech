import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    const List<String> comboList = <String>['Cachorro', 'Gato'];
    DateFormat dateFormater = DateFormat('dd/MM/yyyy');
    Map<String, dynamic> formData = {
      'tutor': '',
      'species': 'Cachorro',
      'race': '',
      'entry_date': dateFormater.format(DateTime.now()),
      'exit_date': 'Indefinido',
    };
    if (widget.data.isNotEmpty) {
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
              DropdownButton(
                value: formData['species'],
                elevation: 16,
                onChanged: (newValue) => {
                  setState(() => formData['species'] = newValue),
                },
                items: comboList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
              DateTimeFormField(
                decoration: const InputDecoration(labelText: 'Data de entrada'),
                mode: DateTimeFieldPickerMode.date,
                canClear: false,
                initialValue: dateFormater.parse(formData['entry_date']),
                onChanged: (newValue) => {
                  formData['entry_date'] = dateFormater.format(newValue!),
                },
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Data de saída prevista',
                ),
                mode: DateTimeFieldPickerMode.date,
                initialValue: formData['exit_date'] != 'Indefinido'
                    ? dateFormater.parse(formData['exit_date'])
                    : null,
                onChanged: (newValue) => {
                  formData['exit_date'] = newValue != null
                      // ? dateFormater.format(newValue)
                      ? dateFormater.format(newValue)
                      : 'Indefinido',
                },
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
              Navigator.of(context).pop();
            }
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
