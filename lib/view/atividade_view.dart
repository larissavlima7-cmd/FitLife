import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';
import 'dashboard_view.dart';
import 'login_view.dart';

class AtividadeView extends StatefulWidget {
  const AtividadeView({super.key});

  @override
  State<AtividadeView> createState() => _AtividadeViewState();
}

class _AtividadeViewState extends State<AtividadeView> {
  //controle para quando adicionar uma nova atividade/exercício
  final TextEditingController _atividadeInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Vê as mudanças do provider para atualizar a lista e o tema
    final provider = context.watch<FitliveProvider>();
// filtra para separar as concluidas das pendentes
    final pendentes = provider.atividades.where((a) => !a.concluida).toList();
    final concluidas = provider.atividades.where((a) => a.concluida).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDarkMode ? Colors.black54 : const Color.fromARGB(255, 200, 230, 201),
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            Text(
              "Atividades",
              style: TextStyle(
                color: provider.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            //icone para alterar o modo para claro/escuro
            icon: Icon(provider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            color: provider.isDarkMode ? Colors.yellow : Colors.black,
            onPressed: () => provider.toggleTheme(),
          ),
          const SizedBox(width: 10),
        ],
      ),

      // Drawer com os atalhos para as outras páginas
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 84, 172, 12)),
              child: Text('Menu FitLife', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            //atalho do dashboard
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardView()),
                );
              },
            ),
            //atalho das atividades
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Atividades'),
              onTap: () => Navigator.pop(context),
            ),
            //linha que divide para deixar mais organizado
            const Divider(),
            //forma de sair e voltra para a página de login
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //adicionar a caixa de texto para adição de novos exeercícios
            TextField(
              controller: _atividadeInput,
              style: TextStyle(color: provider.isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                labelText: "Adicionar novo exercício...",
                labelStyle: TextStyle(color: provider.isDarkMode ? Colors.white70 : Colors.black54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                //icone que possui a função de adicionar as atividades
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: () {
                    if (_atividadeInput.text.isNotEmpty) {
                      provider.createAtividade(_atividadeInput.text);
                      _atividadeInput.clear();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            //bloco para os exercícios que ainda não foram feitos
            Text(
              "Pendentes",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: provider.isDarkMode ? Colors.white : Colors.black
              ),
            ),
            Expanded(
              child: pendentes.isEmpty
                  ? const Center(child: Text("Nada pendente!"))
                  : _buildLista(pendentes, provider),
            ),
            //linha para ficar mais organizado
            const Divider(),
          //bloco para as atividades que já foram feitas
            Text(
              "Concluídas",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: provider.isDarkMode ? Colors.white : Colors.black
              ),
            ),
            Expanded(
              child: concluidas.isEmpty
                  ? const Center(child: Text("Nenhuma atividade concluída."))
                  : _buildLista(concluidas, provider),
            ),
          ],
        ),
      ),
    //bottom navigation para a moviemntação entre as páginas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Indica que estamos na aba Atividades
        selectedItemColor: const Color.fromARGB(255, 84, 172, 12),
        backgroundColor: provider.isDarkMode ? Colors.grey[900] : Colors.white,
        unselectedItemColor: provider.isDarkMode ? Colors.white70 : Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardView()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Atividades'),
        ],
      ),
    );
  }
//metodo para montar os exercícios em lista
  Widget _buildLista(List lista, FitliveProvider provider) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final atividade = lista[index];
        // Encontrar o index real na lista principal do provider
        final int indexOriginal = provider.atividades.indexOf(atividade);

        return Card(
          elevation: 3,
          color: provider.isDarkMode ? Colors.grey[850] : Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            // Checkbox para alternar o estado de conclusão no Provider
            leading: Checkbox(
              value: atividade.concluida,
              activeColor: Colors.green,
              onChanged: (_) => provider.updateAtividade(indexOriginal),
            ),
            // Nome da atividade com efeito "riscado" se estiver concluída
            title: Text(
              atividade.nome,
              style: TextStyle(
                decoration: atividade.concluida ? TextDecoration.lineThrough : null,
                color: atividade.concluida 
                    ? Colors.grey 
                    : (provider.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            //Botão que exclui as atividades permanentemente
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => provider.deleteAtividade(indexOriginal),
            ),
          ),
        );
      },
    );
  }
}