import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FitliveProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[100], // Fundo suave como no protótipo
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            const Text("FitLife", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.wb_sunny_outlined, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.menu, color: Colors.black), onPressed: () {
            Scaffold.of(context).openDrawer(); // Abre o menu lateral
          }),
        ],
      ),
      body: Container(
        color: const Color(), // Fundo cinza bem claro
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // BLOCO 1: Relatório
            _buildContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Relatório"),
                  const SizedBox(height: 10),
                  _textoMetrica("Calorias: ${provider.caloriasEstimadas} kcal"),
                  _textoMetrica("Tempo Total: ${provider.tempoTotalTreino}"),
                  _textoMetrica("Meta: ${(provider.metaSemanal * 100).toStringAsFixed(0)}%"),
                ],
              ),
            ),

            // BLOCO 2: Passos e Calorias do dia
            _buildContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Passos e Calorias do dia"),
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

            // BLOCO 3: Atividades feitas durante a semana
            _buildContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tituloBloco("Atividades feitas durante a semana"),
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
    );
  }

  // Widget para criar os blocos cinzas
  Widget _buildContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Cor cinza do card
        borderRadius: BorderRadius.circular(0), // No protótipo parece reto
      ),
      child: child,
    );
  }

  // Título em itálico como no desenho
  Widget _tituloBloco(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textoMetrica(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(texto, style: const TextStyle(fontSize: 16)),
    );
  }

  // Quadrados escuros de métricas
  Widget _quadradoEscuro(String texto) {
    return Container(
      width: 80,
      height: 80,
      color: const Color(0xFF9E9E9E), // Cinza escuro
      alignment: Alignment.center,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ),
    );
  }

  // Quadrados com ícones (Yoga/Corrida)
  Widget _quadradoComIcone(IconData icone, String nome) {
    return Container(
      width: 80,
      height: 80,
      color: const Color(0xFF9E9E9E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, color: Colors.black, size: 30),
          Text(nome, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12)),
        ],
      ),
    );
  }
}