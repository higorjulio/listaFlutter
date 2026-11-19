import 'package:flutter/material.dart';
import 'tarefa.dart';

class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final TextEditingController controladorTexto = TextEditingController();

  final List<Tarefa> tarefas = [];

  // Cadastrar tarefa
  void cadastrarTarefa() {
    String texto = controladorTexto.text.trim();

    if (texto.isEmpty) {
      return;
    }

    setState(() {
      tarefas.insert(0, Tarefa(nome: texto));
      controladorTexto.clear();
    });
  }

  // Marcar ou desmarcar tarefa
  void alterarTarefa(int index, bool? valor) {
    if (valor == null) return;

    setState(() {
      Tarefa tarefa = tarefas.removeAt(index);

      tarefa.concluida = valor;

      if (valor == true) {
        tarefas.add(tarefa);
      } else {
        tarefas.insert(0, tarefa);
      }
    });
  }

  @override
  void dispose() {
    controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          children: [
            // Campo de texto
            TextField(
              controller: controladorTexto,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tarefa',
                prefixIcon: Icon(Icons.assignment),
              ),
              onSubmitted: (_) => cadastrarTarefa(),
            ),

            const SizedBox(height: 10),

            // Botão cadastrar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cadastrarTarefa,
                child: const Text('Cadastrar'),
              ),
            ),

            const SizedBox(height: 5),

            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      tarefas[index].nome,
                      style: TextStyle(
                        decoration: tarefas[index].concluida
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    value: tarefas[index].concluida,

                    onChanged: (valor) {
                      alterarTarefa(index, valor);
                    },

                    controlAffinity: ListTileControlAffinity.trailing,

                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
