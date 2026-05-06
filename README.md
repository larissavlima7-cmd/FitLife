# Documentação de Especificações de Requisitos de Software SRS - FitLife

## 1.Introdução
### 1.1 Propósito
Este documento descreve os requisitos funcionais e não funcionais do sistema FitLife, um aplicativo de monitoramento de atividades físicas e métricas de saúde pessoal.
### 1.2 Escopo do Sistema
O FitLife permite ao usuário:Realizar autenticação via login e senha.Visualizar relatórios de desempenho calórico e metas semanais.Gerenciar uma lista de exercícios (Atividades).Monitorar passos diários e converter em gasto calórico.

## 2. Descrição Geral
### 2.1 Perspectiva do Produto
O software é uma aplicação mobile multiplataforma desenvolvida em Flutter, utilizando o padrão de arquitetura Provider para gerenciamento de estado e reatividade de interface.
### 2.2 Funções do Produto
Gestão de Exercícios: Criação, atualização (conclusão) e exclusão de atividades.Cálculo de Métricas: Conversão automática de exercícios concluídos em tempo de treino (30 min/exercício) e calorias (80 kcal/exercício).Controle de Interface: Alternância entre temas claro (Light) e escuro (Dark).

## 3. Requisitos Específicos 
### 3.1 Requisitos Funcionais (RF)
| ID | Requisito | Descrição |
| RF01 | Autenticação | O sistema deve validar as credenciais do usuário na LoginView para permitir acesso ao Dashboard. |
| RF02 | Cálculo de Metas | O sistema deve calcular o progresso semanal baseado em uma meta fixa de 7 exercícios concluídos. |
| RF03 | Persistência de Estado | O FitliveProvider deve notificar a interface (notifyListeners) sempre que houver alteração na lista de atividades ou passos. |
| RF04 | Navegação | O sistema deve prover navegação via Drawer (Menu Lateral) e BottomNavigationBar entre Dashboard e Atividades. |
| RF05 | Gestão de Atividades | O usuário deve ser capaz de adicionar nomes de exercícios e marcá-los como concluídos, aplicando efeito visual de tachado (lineThrough). |

### 3.2 Requisitos Não Funcionais (RNF)

| ID | Categoria | Descrição | 
| RNF01 | Usabilidade | O sistema deve suportar Modo Escuro para conforto visual em ambientes de baixa luminosidade. | 
| RNF02 | Performance | O cálculo das calorias totais gerais (atividades + passos) deve ser realizado em tempo real via getters no Provider. |
| RNF03 | Portabilidade | Desenvolvido em Flutter, o sistema deve ser compatível com Android e iOS. |
| RNF04 | Confiabilidade | Atividades sem nome (strings vazias ou espaços) não devem ser aceitas pelo sistema. |

## 4. Requisitos de Dados
### 4.1 Modelo de Dados (Atividade)
As atividades registradas no sistema devem conter:
- Nome: String (Obrigatório).
- Status: Booleano (Padrão: falso).
- Data de Criação: DateTime (Gerado automaticamente).

## 5. Matriz de Rastreabilidade de Requisitos

- Código Main: Responsável por inicializar o ChangeNotifierProvider e o MaterialApp com suporte a temas.
- Controller: O FitliveProvider centraliza todos os requisitos de lógica de negócio (RF02, RF03, RF05).
- Views: DashboardView e AtividadeView implementam os requisitos de interface e navegação (RF01, RF04, RNF01).

## 6. Referências e Protótipos
### 6.1 Protótipos de Alta Fidelidade
Em conformidade com as boas práticas de engenharia de requisitos para visualização de interface e experiência do usuário (UX/UI), os protótipos das telas LoginView, DashboardView e AtividadeView encontram-se disponíveis no link abaixo:

Link do Projeto (Figma): https://www.figma.com/design/1DwWGoH3a47cmxNJcFR7aK/Sem-t%C3%ADtulo?node-id=3-195&t=BJphIeCwj0Ok2awr-1 

### 6.2 Justificativa de Design
Os protótipos referenciados servem como base para os requisitos de usabilidade (RNF01) e navegação (RF04), detalhando:

- Layout responsivo para dispositivos móveis.

- Paleta de cores baseada em tons de verde (Saúde/Bem-estar).

- Comportamento visual dos componentes no Modo Claro e Modo Escuro.