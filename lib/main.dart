import 'package:flutter/material.dart';
import 'tela_tarefas.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaTarefas(),
    );
  }
}
