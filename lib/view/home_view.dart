// import 'package:flutter/material.dart';
// import 'dashboard_view.dart';
// import 'atividade_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _aba = 0;
//   final List<Widget> _telas = [const DashboardView(), const AtividadeView()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("FitLife"), centerTitle: true),
//       body: _telas[_aba],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _aba,
//         onTap: (i) => setState(() => _aba = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "Atividades"),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dashboard_view.dart';
import 'atividade_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _abaAtual = 0;
  final List<Widget> _telas = [const DashboardView(), const AtividadeView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaAtual,
        onTap: (i) => setState(() => _abaAtual = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Atividades"),
        ],
      ),
    );
  }
}