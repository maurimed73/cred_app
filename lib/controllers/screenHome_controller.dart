import 'dart:convert';

import 'package:cred_app/model/cliente_model.dart';
import 'package:cred_app/model/etapa_model.dart';

class homeController {
// Gera 8 etapas da régua para cada parcela (baseado no vencimento passado)
  static List<Etapa> gerarEtapas(DateTime vencimento, DateTime dataEmissao) {
    return [
      Etapa(
        nome: 'Emissão',
        mensagem: 'Parcela emitida',
        dataAgendada: dataEmissao,
      ),
      Etapa(
          nome: 'Dia\nvencimento',
          mensagem: 'Lembrete pré-vencimento',
          dataAgendada: vencimento.subtract(Duration(days: 2))),
      Etapa(
          nome: 'Dia\nvencimento',
          mensagem: 'Aviso no dia do vencimento',
          dataAgendada: vencimento),
      Etapa(
          nome: '3 dias após\nvencimento',
          mensagem: '1º alerta pós-vencimento',
          dataAgendada: vencimento.add(Duration(days: 3))),
      Etapa(
          nome: '4 dias de atraso',
          mensagem: '2º alerta',
          dataAgendada: vencimento.add(Duration(days: 4))),
      Etapa(
          nome: '10 dias de atraso',
          mensagem: '3º alerta',
          dataAgendada: vencimento.add(Duration(days: 10))),
      Etapa(
          nome: '15 dias de atraso',
          mensagem: '4º alerta',
          dataAgendada: vencimento.add(Duration(days: 15))),
      Etapa(
          nome: '30 dias de atraso',
          mensagem: 'Último alerta',
          dataAgendada: vencimento.add(Duration(days: 30))),
    ];
  }

  String json = '''
 [
  {
    "idCliente": 1,
    "nome": "Carlos Silva",
    "parcelas": [
      {
        "valor": 120.5,
        "vencimento": "2026-01-10"              
      },
       {
        "valor": 120.5,
        "vencimento": "2026-02-10"              
      }
    ]
  },
  {
    "idCliente": 1,
    "nome": "Mauricio de Medeiros",
    "parcelas": [
      {
        "valor": 40.0,
        "vencimento": "2025-12-05"              
      },
       {
        "valor": 40.0,
        "vencimento": "2025-11-05"              
      }
    ]
  }
]
''';

  List<Cliente> clientes = [];
  Future<List<Cliente>> carregarClientes() async {
    final data = jsonDecode(json);
    for (var element in data) {
      for (var parcela in element['parcelas']) {
        DateTime vencimento = DateTime.parse(parcela['vencimento']);
        DateTime dataEmissao = vencimento.subtract(Duration(days: 30));
        parcela['etapas'] = gerarEtapas(vencimento, dataEmissao).map((etapa) {
          return {
            'nome': etapa.nome,
            'mensagem': etapa.mensagem,
            'dataAgendada': etapa.dataAgendada.toIso8601String(),
            'concluida': etapa.concluida,
          };
        }).toList();
        parcela['isPaid'] = false; // Inicialmente não paga
      }
      print(element['nome']);

      clientes.add(Cliente.fromJson(element));
    }
    // clientes = (data as List)
    //     .map((clienteJson) => Cliente.fromJson(clienteJson))
    //     .toList();

    return clientes;
  }
}
