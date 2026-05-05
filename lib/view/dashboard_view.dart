// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controller/fitlive_provider.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<FitliveProvider>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 200, 230, 201),
//         elevation: 0,
//         title: Row(
//           children: [
//             Image.asset('assets/images/logo.png', height: 40),
//             const SizedBox(width: 10),
//             const Text("FitLife", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//           ],
//         ),
//         actions: [
//           const Icon(Icons.wb_sunny_outlined, color: Colors.black),
//           const SizedBox(width: 15),
//           Builder(
//             builder: (context) => IconButton(
//               icon: const Icon(Icons.menu, color: Colors.black),
//               onPressed: () => Scaffold.of(context).openDrawer(),
//             ),
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),

//       body: Container(
//         color: const Color.fromARGB(255, 255, 255, 255), 
//         child: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             //Relatório
//             _buildContainer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _tituloBloco("Relatório"),
//                   const SizedBox(height: 10),
//                   _textoMetrica("Calorias: ${provider.caloriasEstimadas} kcal"),
//                   _textoMetrica("Tempo Total: ${provider.tempoTotalTreino}"),
//                   _textoMetrica("Meta: ${(provider.metaSemanal * 100).toStringAsFixed(0)}%"),
//                 ],
//               ),
//             ),

//             // Passos e Calorias do dia
//             _buildContainer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _tituloBloco("Passos e Calorias do dia"),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _quadradoEscuro("${provider.passosDados}\npassos"),
//                       _quadradoEscuro("${provider.caloriasPorPassos.toStringAsFixed(0)}\nkcal"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             //Atividades feitas durante a semana
//             _buildContainer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _tituloBloco("Atividades feitas durante a semana"),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _quadradoComIcone(Icons.self_improvement, "Yoga"),
//                       _quadradoComIcone(Icons.directions_run, "Corrida"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0, // Aba Dashboard ativa
//         selectedItemColor: const Color.fromARGB(255, 84, 172, 12),
//         onTap: (index) {
//           if (index == 1) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const AtividadeView()),
//             );
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
//           BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Atividades'),
//         ],
//       ),
//     );
//   }

//   //Criar os blocos
//   Widget _buildContainer({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 200, 230, 201),
//         borderRadius: BorderRadius.circular(12), 
//       ),
//       child: child,
//     );
//   }

//   //Estilizar o titulo
//   Widget _tituloBloco(String texto) {
//     return Text(
//       texto,
//       style: const TextStyle(
//         fontSize: 18,
//         fontStyle: FontStyle.italic,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _textoMetrica(String texto) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Text(texto, style: const TextStyle(fontSize: 16)),
//     );
//   }

//   // Quadrados com as informações
//   Widget _quadradoEscuro(String texto) {
//     return Container(
//       width: 80,
//       height: 80,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 84, 172, 12),
//         borderRadius: BorderRadius.circular(12), // Ajuste o valor do raio aqui
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         texto,
//         textAlign: TextAlign.center,
//         style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
//       ),
//     );
//   }

//   // Quadrados com ícones 
//   Widget _quadradoComIcone(IconData icone, String nome) {
//     return Container(
//       width: 80,
//       height: 80,
//       color: const Color.fromARGB(255, 84, 172, 12),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icone, color: Colors.black, size: 30),
//           Text(nome, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12)),
//         ],
//       ),
//     );
//   }

  
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/fitlive_provider.dart';
import 'atividade_view.dart'; // Certifique-se de que o import está correto

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FitliveProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
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

      body: Container(
        color: Colors.white, 
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Relatório
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

            // Passos e Calorias do dia
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

            // Atividades feitas durante a semana
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
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, 
        selectedItemColor: const Color.fromARGB(255, 84, 172, 12),
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

  // --- MÉTODOS AUXILIARES ---

  Widget _buildContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 200, 230, 201),
        borderRadius: BorderRadius.circular(12), 
      ),
      child: child,
    );
  }

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
      // ADICIONADO: Decoração para manter arredondado como o outro quadrado
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 84, 172, 12),
        borderRadius: BorderRadius.circular(12),
      ),
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