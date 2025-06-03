import 'package:flutter/material.dart';

class FormModal extends StatefulWidget {
  final String titleText;
  final Function func;

  FormModal({Key? key, required this.titleText, required this.func})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormModalState();
}

class _FormModalState extends State<FormModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.titleText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Responsável'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Espécie do Pet'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Raça'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Data de entrada'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Favor inserir algum texto';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Data de saída prevista',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.func();
                  }
                },
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
