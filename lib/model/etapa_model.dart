class Etapa {
  final String nome;
  final String mensagem;
  final DateTime dataAgendada;
  bool concluida;

  Etapa({
    required this.nome,
    required this.mensagem,
    required this.dataAgendada,
    this.concluida = false,
  });

  factory Etapa.fromJson(Map<String, dynamic> json) {
    return Etapa(
      nome: json['nome'],
      mensagem: json['mensagem'],
      dataAgendada: DateTime.parse(json['dataAgendada']),
      concluida: json['concluida'],
    );
  }
}
