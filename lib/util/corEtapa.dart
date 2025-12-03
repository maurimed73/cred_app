import 'package:cred_app/model/etapa_model.dart';
import 'package:cred_app/model/parcela_model.dart';
import 'package:flutter/material.dart';

class Coretapa {
  static Color corDaEtapa(Etapa etapa, Parcela parcela, bool concluida) {
    final hoje = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final dataEtapa = DateTime(
      etapa.dataAgendada.year,
      etapa.dataAgendada.month,
      etapa.dataAgendada.day,
    );

    final vencimento = DateTime(
      parcela.vencimento.year,
      parcela.vencimento.month,
      parcela.vencimento.day,
    );

    if (concluida) {
      return Colors.black;
    }
    // 🔵 Emissão nunca atrasa
    if (etapa.nome == 'Emissão') {
      return Colors.blue;
    }

    // 🔵 Etapa futura → azul
    if (dataEtapa.isAfter(hoje)) {
      return Colors.blue;
    }

    // 🔵 Etapa hoje → azul
    if (dataEtapa == hoje) {
      return Colors.blue;
    }

    // 🔵 Se a etapa está antes do vencimento → NÃO ATRASA
    if (dataEtapa.isBefore(vencimento)) {
      return Colors.blue;
    }

    // 🔴 Só fica vermelho se:
    // etapa atrasada E já passou do vencimento
    if (dataEtapa.isBefore(hoje) && hoje.isAfter(vencimento)) {
      return Colors.red;
    }

    return Colors.blue;
  }
}
