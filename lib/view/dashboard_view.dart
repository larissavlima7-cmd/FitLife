import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';
import 'atividade_view.dart';
import 'login_view.dart'; // ADICIONADO: Importe o login para o botão sair funcionar

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos watch para a tela atualizar assim que clicar no sol/lua
    final provider = context.watch<FitliveProvider>();

    return Scaffold(
      // Removido o backgroundColor fixo para respeitar o tema global
      appBar: AppBar(
        backgroundColor: provider.isDarkMode ? Colors.black54 : const Color.fromARGB(255, 200, 230, 201),
        elevation: 0,
        title: Row(
          children: [
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
          IconButton(
            icon: Icon(provider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            color: provider.isDarkMode ? Colors.yellow : Colors.black,
            onPressed: () => provider.toggleTheme(),
          ),
          const SizedBox(width: 10),
        ],
      ),

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

      // 1. DASHBOARD
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {
          Navigator.pop(context); // Apenas fecha o drawer pois já estamos na Dashboard
        },
      ),

      // 2. ATIVIDADES
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

      const Divider(), // Linha separadora para o Sair

      // 3. SAIR
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

      body: Container(
        // Faz o fundo da lista mudar automaticamente entre branco e preto/cinza
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
                      _quadradoEscuro("${provider.passosDados}\npassos"),
                      _quadradoEscuro("${provider.caloriasPorPassos.toStringAsFixed(0)}\nkcal"),
                    ],
                  ),
                ],
              ),
            ),

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

  // MÉTODOS AUXILIARES CORRIGIDOS

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