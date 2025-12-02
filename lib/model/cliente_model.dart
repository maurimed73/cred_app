import 'package:cred_app/model/parcela_model.dart';

class Cliente {
  final int idCliente;
  final String nome;
  final List<Parcela> parcelas;

  Cliente({
    required this.idCliente,
    required this.nome,
    required this.parcelas,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idCliente: json['idCliente'],
      nome: json['nome'],
      parcelas:
          (json['parcelas'] as List).map((p) => Parcela.fromJson(p)).toList(),
    );
  }
}
