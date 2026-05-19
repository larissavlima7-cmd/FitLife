import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';
import 'atividade_view.dart';
import 'login_view.dart'; // ADICIONADO: Importe o login para o botão sair funcionar

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    //Vê as mudanças do provider para atualizar a tela
    final provider = context.watch<FitliveProvider>();

    return Scaffold(
      //app bar com o logo, drawer e a função de mudar o tema
      appBar: AppBar(
        backgroundColor: provider.isDarkMode ? Colors.black54 : const Color.fromARGB(255, 200, 230, 201),
        elevation: 0,
        title: Row(
          children: [
            //logo
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            Text(
              "FitLife",
              style: TextStyle(
                color: provider.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          //icone para a função de mudar o tema claro/escuro
          IconButton(
            icon: Icon(provider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            color: provider.isDarkMode ? Colors.yellow : Colors.black,
            onPressed: () => provider.toggleTheme(),
          ),
          const SizedBox(width: 10),
        ],
      ),
 //cria um menu lateral com atalhos para as página e para voltar a página de login
 //adiciona sozinho o icone de menu
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      // Cabeçalho do Menu
      const DrawerHeader(
        decoration: BoxDecoration(color: Color.fromARGB(255, 84, 172, 12)),
        child: Text(
          'Menu FitLife', 
          style: TextStyle(color: Colors.white, fontSize: 24)
        ),
      ),

      //colocando o atalho para o dashboard no drawer
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {
          Navigator.pop(context); // Apenas fecha o drawer pois já estamos na Dashboard
        },
      ),

      // atalho para atividades no drawer
      ListTile(
        leading: const Icon(Icons.fitness_center),
        title: const Text('Atividades'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AtividadeView()),
          );
        },
      ),
// uma linha para deixar mais organizado
      const Divider(), // Linha separadora para o Sair

      //Para o usuário sair da parte interna do app
      ListTile(
        leading: const Icon(Icons.exit_to_app, color: Colors.red),
        title: const Text('Sair', style: TextStyle(color: Colors.red)),
        onTap: () {
          // Volta para a tela de Login e remove todo o histórico de telas
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
 //organização das informações do Dashboard
      body: Container(
        // Faz o fundo da lista mudar automaticamente entre branco e preto
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildContainer(
              provider: provider, // Agora a função aceita o provider
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Relatório", provider),
                  const SizedBox(height: 10),
                  //puxa as informações do provider
                  _textoMetrica("Calorias: ${provider.caloriasEstimadas} kcal", provider),
                  _textoMetrica("Tempo Total: ${provider.tempoTotalTreino}", provider),
                  _textoMetrica("Meta: ${(provider.metaSemanal * 100).toStringAsFixed(0)}%", provider),
                ],
              ),
            ),

            _buildContainer(
              provider: provider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Passos e Calorias do dia", provider),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       //puxa as informações do provide
                      _quadradoEscuro("${provider.passosDados}\npassos"),
                      _quadradoEscuro("${provider.caloriasPorPassos.toStringAsFixed(0)}\nkcal"),
                    ],
                  ),
                ],
              ),
            ),

          //bloco visual para as atividades já praticadas
            _buildContainer(
              provider: provider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Atividades da semana", provider),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _quadradoComIcone(Icons.self_improvement, "Yoga"),
                      _quadradoComIcone(Icons.directions_run, "Corrida"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      //barra de tarefas para acesso entre páginas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 84, 172, 12),
        backgroundColor: provider.isDarkMode ? Colors.grey[900] : Colors.white,
        unselectedItemColor: provider.isDarkMode ? Colors.white70 : Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AtividadeView()),
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

  //métodos para estilização

  Widget _buildContainer({required Widget child, required FitliveProvider provider}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // No modo escuro o container fica cinza bem escuro, no claro fica verde
        color: provider.isDarkMode ? Colors.white10 : const Color.fromARGB(255, 200, 230, 201),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _tituloBloco(String texto, FitliveProvider provider) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        color: provider.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _textoMetrica(String texto, FitliveProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        texto, 
        style: TextStyle(
          fontSize: 16,
          color: provider.isDarkMode ? Colors.white70 : Colors.black87,
        )
      ),
    );
  }

  Widget _quadradoEscuro(String texto) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 84, 172, 12),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _quadradoComIcone(IconData icone, String nome) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 84, 172, 12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, color: Colors.white, size: 30), // Ícone branco fica melhor no fundo verde
          Text(
            nome, 
            style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12)
          ),
        ],
      ),
    );
  }
}