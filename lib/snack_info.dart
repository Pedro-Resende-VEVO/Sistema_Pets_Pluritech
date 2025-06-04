import 'package:flutter/material.dart';

/// Exibe uma mensagem SnackBar na tela.
/// [context] - Contexto do widget.
/// [title] - Texto a ser exibido.
SnackInfo({required BuildContext context, required String title}) {
  SnackBar snackBar = SnackBar(content: Text(title));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
