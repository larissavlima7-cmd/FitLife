// Criando a classe Atividade, para o exercício que precisa ser feito
//Precisa do nome e se ela está concluida ou não
class Atividade {
  // atributos
  String nome; 
  bool concluida; 
  DateTime criadaEm; 

  //required = torna a informação obrigatória, ele não pode adicionar uma atividade sem nome
  Atividade({required this.nome, this.concluida = false, DateTime? criadaEm}): criadaEm = criadaEm ?? DateTime.now();
  // se ao criar não existir (??) uma carimbo de data e hora é criado um 
}