import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';

class AtividadeView extends StatefulWidget {
  const AtividadeView({super.key});

  @override
  State<AtividadeView> createState() => _AtividadeViewState();
}

class _AtividadeViewState extends State<AtividadeView> {
  // Controle de nova tarefa
  final TextEditingController _atividadeInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FitliveProvider>(context);

    // Filtramos as listas para a divisão da tela
    final pendentes = controller.atividades.where((a) => !a.concluida).toList();
    final concluidas = controller.atividades.where((a) => a.concluida).toList();

    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 230, 201),
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            const Text("FitLife", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          const Icon(Icons.wb_sunny_outlined, color: Colors.black),
          const SizedBox(width: 15),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _atividadeInput,
              decoration: InputDecoration(
                labelText: "Adicionar novo exercício...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: () {
                    if (_atividadeInput.text.isNotEmpty) {
                      controller.createAtividade(_atividadeInput.text);
                      _atividadeInput.clear(); // Limpa o campo após adicionar
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            

            // Parte: Atividades Pendentes
            const Text("Atividades Pendentes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: pendentes.isEmpty
                  ? const Center(child: Text("Nada pendente!"))
                  : _buildLista(pendentes, controller),
            ),

            const Divider(height: 30, thickness: 2),

            // Atividades concluidas
            const Text("Atividades Concluídas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: concluidas.isEmpty
                  ? const Center(child: Text("Nenhuma atividade concluída ainda."))
                  : _buildLista(concluidas, controller),
            ),
          ],
        ),
      ),
    );
  }

  // Deixa em formato de lista
  Widget _buildLista(List lista, FitliveProvider controller) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final atividade = lista[index];
        final int indexOriginal = controller.atividades.indexOf(atividade);

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Checkbox(
              value: atividade.concluida,
              onChanged: (_) => controller.updateAtividade(indexOriginal),
            ),
            title: Text(
              atividade.nome,
              style: TextStyle(
                decoration: atividade.concluida ? TextDecoration.lineThrough : null,
                color: atividade.concluida ? Colors.grey : Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => controller.deleteAtividade(indexOriginal),
            ),
          ),
        );
      },
    );
  }
}