import 'dart:convert';

import 'package:cred_app/model/cliente_model.dart';
import 'package:cred_app/model/etapa_model.dart';
import 'package:cred_app/screen_home.dart';
import 'package:flutter/material.dart';

class ClientesProvider extends ChangeNotifier {
// Gera 8 etapas da régua para cada parcela (baseado no vencimento passado)
  static List<Etapa> gerarEtapas(DateTime vencimento, DateTime dataEmissao) {
    return [
      Etapa(
        nome: 'Emissão',
        mensagem: 'Parcela emitida',
        dataAgendada: dataEmissao,
      ),
      Etapa(
          nome: 'Antes do\nvencimento',
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
        "vencimento": "2025-01-10",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Olá Carlos, sua parcela vence em breve.",
            "dataAgendada": "2025-01-05",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Carlos, sua parcela vence amanhã.",
            "dataAgendada": "2025-01-09",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Carlos, sua parcela está vencida. Regularize por favor.",
            "dataAgendada": "2025-01-11",
            "concluida": false
          }
        ]
      }
    ]
  },
  {
    "idCliente": 2,
    "nome": "Mariana Rocha",
    "parcelas": [
      {
        "valor": 150,
        "vencimento": "2025-02-01",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Olá Mariana, lembrete da sua parcela.",
            "dataAgendada": "2025-01-27",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Sua parcela vence amanhã.",
            "dataAgendada": "2025-01-31",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Sua parcela venceu, por favor regularize.",
            "dataAgendada": "2025-02-02",
            "concluida": false
          }
        ]
      },
      {
        "valor": 150,
        "vencimento": "2025-03-01",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Olá, lembrete da sua parcela.",
            "dataAgendada": "2025-02-25",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Parcela vence amanhã.",
            "dataAgendada": "2025-02-28",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Parcela vencida.",
            "dataAgendada": "2025-03-02",
            "concluida": false
          }
        ]
      }
    ]
  },
  {
    "idCliente": 3,
    "nome": "João Pereira",
    "parcelas": [
      {
        "valor": 90,
        "vencimento": "2025-01-15",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Olá João, sua parcela vence em breve.",
            "dataAgendada": "2025-01-10",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Sua parcela vence amanhã.",
            "dataAgendada": "2025-01-14",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Sua parcela venceu.",
            "dataAgendada": "2025-01-16",
            "concluida": false
          }
        ]
      },
      {
        "valor": 90,
        "vencimento": "2025-02-15",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Olá João, lembrete da sua parcela.",
            "dataAgendada": "2025-02-10",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Parcela vence amanhã.",
            "dataAgendada": "2025-02-14",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Parcela vencida.",
            "dataAgendada": "2025-02-16",
            "concluida": false
          }
        ]
      },
      {
        "valor": 90,
        "vencimento": "2025-03-15",
        "isPaid": false,
        "etapas": [
          {
            "nome": "Aviso 1",
            "mensagem": "Lembrete da parcela.",
            "dataAgendada": "2025-03-10",
            "concluida": false
          },
          {
            "nome": "Aviso 2",
            "mensagem": "Parcela vence amanhã.",
            "dataAgendada": "2025-03-14",
            "concluida": false
          },
          {
            "nome": "Cobrança",
            "mensagem": "Parcela vencida.",
            "dataAgendada": "2025-03-16",
            "concluida": false
          }
        ]
      }
    ]
  }, 
]
''';
  List<Cliente> clientes = [];
  Future<List<Cliente>> carregarClientes() async {
    final data = jsonDecode(json);

    clientes = (data as List)
        .map((clienteJson) => Cliente.fromJson(clienteJson))
        .toList();

    return clientes;
  }
}
