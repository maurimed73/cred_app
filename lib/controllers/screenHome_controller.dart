import 'dart:convert';
import 'package:cred_app/model/cliente_model.dart';
import 'package:cred_app/model/etapa_model.dart';
import 'package:flutter/material.dart';

class homeController {
  // Json vindo da api, ou outro software - VBA-Excel
  String json = '''
 [
  {
    "idCliente": 1,
    "nome": "Carlos Silva",
    "dataVenda": "2025-10-31",
    "parcelas": [
      { "idParcela": 1,
        "valor": 120.5,
        "vencimento": "2025-12-02"
      },
       {
        "idParcela": 1,
        "valor": 120.5,
        "vencimento": "2026-01-02"
      }
    ]
  },
  {
    "idCliente": 2,
    "nome": "Mauricio de Medeiros",
    "dataVenda": "2025-10-05",
    "parcelas": [
      {
        "idParcela": 1,
        "valor": 40.0,
        "vencimento": "2025-11-05"
      },
       {
        "idParcela": 1,
        "valor": 40.0,
        "vencimento": "2025-12-05"
      }
    ]
  },
   {
    "idCliente": 1,
    "nome": "Carlos Silva",
    "dataVenda": "2025-12-10",
    "parcelas": [
      {
        "idParcela": 1,
        "valor": 120.5,
        "vencimento": "2026-01-10"
      },
       {
        "idParcela": 1,
        "valor": 120.5,
        "vencimento": "2026-02-10"
      }
    ]
  },
  {
    "idCliente": 2,
    "nome": "Mauricio de Medeiros",
    "dataVenda": "2025-10-05",
    "parcelas": [
      {
        "idParcela": 1,
        "valor": 40.0,
        "vencimento": "2025-11-05"
      },
       {
        "idParcela": 1,
        "valor": 40.0,
        "vencimento": "2025-12-05"
      }
    ]
  }
 ]
''';

// Gera 8 etapas da régua para cada parcela (baseado no vencimento passado)
  static List<Etapa> gerarEtapas(DateTime vencimento, DateTime dataEmissao) {
    return [
      Etapa(
        nome: 'Emissão',
        mensagem: 'Parcela emitida',
        dataAgendada: dataEmissao,
      ),
      Etapa(
          nome: 'Lembrete',
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

  List<Cliente> clientes = [];

  Future<List<Cliente>> loadClients() async {
    final data = jsonDecode(json);

    for (var element in data) {
      for (var parcela in element['parcelas']) {
        DateTime vencimento = DateTime.parse(parcela['vencimento']);
        DateTime dataEmissao = DateTime.parse(element['dataVenda']);
        parcela['etapas'] = gerarEtapas(vencimento, dataEmissao).map((etapa) {
          return {
            'nome': etapa.nome,
            'mensagem': etapa.mensagem,
            'dataAgendada': etapa.dataAgendada.toIso8601String(),
            'concluida': etapa.concluida,
          };
        }).toList();
        parcela['isPaid'] = false; // Inicialmente não paga
        parcela['idCliente'] = element['idCliente'];

        print("Valor da parcela: ${parcela['valor']}");

        for (var etapa in parcela['etapas']) {
          print("Etapa: ${etapa['nome']}");
        }
      }

      // print(
      //     'ID: ${element['idCliente']} - ${element['nome']} / ${element['parcelas']} ');

      clientes.add(Cliente.fromJson(element));
    }
    // clientes = (data as List)
    //     .map((clienteJson) => Cliente.fromJson(clienteJson))
    //     .toList();
    //print(clientes.length);
    return clientes;
  }

  bool clienteTemAtraso(Cliente cliente) {
    final hoje =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    for (var parcela in cliente.parcelas) {
      final vencimento = DateTime(
        parcela.vencimento.year,
        parcela.vencimento.month,
        parcela.vencimento.day,
      );

      if (!hoje.isAfter(vencimento)) continue;

      for (var etapa in parcela.etapas) {
        if (etapa.nome == 'Emissão') continue;

        final dataEtapa = DateTime(
          etapa.dataAgendada.year,
          etapa.dataAgendada.month,
          etapa.dataAgendada.day,
        );

        final etapaPodeAtrasar = dataEtapa.isAfter(vencimento);

        final estaAtrasada =
            etapaPodeAtrasar && dataEtapa.isBefore(hoje) && !etapa.concluida;

        if (estaAtrasada) {
          return true;
        }
      }
    }

    return false;
  }
}
