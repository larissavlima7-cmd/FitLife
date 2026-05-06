import 'package:flutter/material.dart';
import 'package:fitlife/model/atividade.dart';

//A classe precisa herdar da changeNotifier
class FitliveProvider extends ChangeNotifier {
  List<Atividade> _atividades = []; //para armazenar as atividades

  List<Atividade> get atividades => _atividades;

  //Metodos

  //Criar atiividade
  void createAtividade(String nome){
    if(nome.trim().isEmpty)return; //se não tiver o exercício escrito 

    _atividades.add(Atividade(nome: nome));
    notifyListeners();
  }

  //Atualizar(mudar se o exercício já está concluida ou não)
  void updateAtividade(int index){
    _atividades[index].concluida = !_atividades[index].concluida;
    //muda para concluida ou para não concluida
    notifyListeners(); //notifica os widgets uqe o estado da bool mudou
  }

  //Para apagar um exercício
  void deleteAtividade(int index){
    _atividades.removeAt(index);
    notifyListeners(); //avisa que não exite mais esse exercício
  }

  //métodos para as métricas

//quantas atividades foram feitas
int get totalAtividades => _atividades.length;

//Atividades/Exercícios que foram feitos
int get totalAtividadesConcluidas => _atividades.where((atividade)=>atividade.concluida).length;

//Exrcícios pendentes
int get totalAtividadesPendentes => _atividades.where((atividade)=>!atividade.concluida).length;


  //Tempo Total de Treino (considerando um tempo de 30 minutos para a atividade)
  String get tempoTotalTreino {
    int minutosTotais = totalAtividadesConcluidas * 30;
    int horas = minutosTotais ~/ 60;
    int minutos = minutosTotais % 60;
    return "${horas}h${minutos.toString().padLeft(2, '0')}";
  }

  // 3. Meta Semanal - com meta de 7 exercícios por semana
  double get metaSemanal {
    const int metaObjetivo = 7;
    if (_atividades.isEmpty) return 0.0;
    double progresso = totalAtividadesConcluidas / metaObjetivo;
    return progresso > 1.0 ? 1.0 : progresso; // Limita a 100%
  }

  //Caloria baseada na atividade física feita
  int get caloriasEstimadas => totalAtividadesConcluidas * 80;

  int _passosDados = 0; 

  int get passosDados => _passosDados;

  // Cálculo de calorias por passo (0.04 kcal por passo)
  double get caloriasPorPassos => _passosDados * 0.04;

  // Método para quando o usuário caminhar (simulação)
  void adicionarPassos(int novosPassos) {
    _passosDados += novosPassos;
    notifyListeners();
  }

  // Calorias Totais (passos e atividades)
  double get caloriasTotaisGerais {
    // Pegamos os 80kcal por exercício concluído que já tínhamos + calorias dos passos
    return (totalAtividadesConcluidas * 80) + caloriasPorPassos;
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Isso vai avisar o MaterialApp para mudar a cor
  }

}

