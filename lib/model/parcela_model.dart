import 'package:cred_app/model/etapa_model.dart';

class Parcela {
  final double valor;
  final DateTime vencimento;
  final List<Etapa> etapas;
  bool isPaid;

  Parcela(
      {required this.valor,
      required this.vencimento,
      required this.etapas,
      this.isPaid = false});

  factory Parcela.fromJson(Map<String, dynamic> json) {
    return Parcela(
      valor: json['valor'].toDouble(),
      vencimento: DateTime.parse(json['vencimento']),
      isPaid: json['isPaid'],
      etapas: (json['etapas'] as List).map((e) => Etapa.fromJson(e)).toList(),
    );
  }
}
