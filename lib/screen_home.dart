// import 'package:flutter/material.dart';
// import 'dart:math';

// class Etapa {
//   final String nome;
//   final String mensagem;
//   final DateTime dataAgendada;
//   bool enviada;

//   Etapa(
//       {required this.nome,
//       required this.mensagem,
//       required this.dataAgendada,
//       this.enviada = false});
// }

// class Parcela {
//   final double valor;
//   final DateTime vencimento;
//   final List<Etapa> etapas;
//   bool paga;

//   Parcela(
//       {required this.valor,
//       required this.vencimento,
//       required this.etapas,
//       this.paga = false});
// }

// class Cliente {
//   final String nome;
//   final List<Parcela> parcelas;

//   Cliente({required this.nome, required this.parcelas});
// }

// class ScreenHome extends StatelessWidget {
//   final Random random = Random();
//   final DateTime hoje = DateTime.now();

//   // Gera 8 etapas da régua para cada parcela
//   List<Etapa> gerarEtapas(DateTime vencimento) {
//     return [
//       Etapa(
//           nome: 'Emissão',
//           mensagem: 'Parcela emitida',
//           dataAgendada: DateTime.now(),
//           enviada: true),
//       Etapa(
//           nome: 'Antes do vencimento',
//           mensagem: 'Lembrete pré-vencimento',
//           dataAgendada: vencimento.subtract(Duration(days: 2))),
//       Etapa(
//           nome: 'Dia do vencimento',
//           mensagem: 'Aviso no dia do vencimento',
//           dataAgendada: vencimento),
//       Etapa(
//           nome: 'Depois do vencimento',
//           mensagem: '1º alerta pós-vencimento',
//           dataAgendada: vencimento.add(Duration(days: 3))),
//       Etapa(
//           nome: '4 dias de atraso',
//           mensagem: '2º alerta',
//           dataAgendada: vencimento.add(Duration(days: 4))),
//       Etapa(
//           nome: '10 dias de atraso',
//           mensagem: '3º alerta',
//           dataAgendada: vencimento.add(Duration(days: 10))),
//       Etapa(
//           nome: '15 dias de atraso',
//           mensagem: '4º alerta',
//           dataAgendada: vencimento.add(Duration(days: 15))),
//       Etapa(
//           nome: '30 dias de atraso',
//           mensagem: 'Último alerta',
//           dataAgendada: vencimento.add(Duration(days: 30))),
//     ];
//   }

//   // Gera 50 clientes com 3–10 parcelas cada
//   late final List<Cliente> clientes = List.generate(1, (cIndex) {
//     return Cliente(
//       nome: 'Mauricio de Medeiros',
//       parcelas: [
//         Parcela(
//             valor: 80,
//             vencimento: DateTime(2025, 12, 5),
//             etapas: gerarEtapas(DateTime(2025, 11, 15)),
//             paga: true)
//       ],
//     );
//   });

//   // Define a cor de cada etapa
//   Color corEtapa(Etapa etapa) {
//     if (etapa.enviada) return Colors.green;
//     if (etapa.dataAgendada.isBefore(hoje)) return Colors.orange;
//     if (etapa.dataAgendada.day == hoje.day &&
//         etapa.dataAgendada.month == hoje.month) return Colors.pink;
//     return Colors.blue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Régua de Cobrança - Desktop')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: clientes.length,
//           itemBuilder: (context, cIndex) {
//             final cliente = clientes[cIndex];
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(cliente.nome,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 12),
//                     Column(
//                       children: cliente.parcelas.map((parcela) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Parcela R\$ ${parcela.valor.toStringAsFixed(2)} - Vencimento: ${parcela.vencimento.day}/${parcela.vencimento.month}/${parcela.vencimento.year}'),
//                               SizedBox(height: 8),
//                               SizedBox(
//                                 height: 90, // aumentei para caber a seta
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: parcela.etapas.length,
//                                   itemBuilder: (context, eIndex) {
//                                     final etapa = parcela.etapas[eIndex];

//                                     final bool isHoje =
//                                         etapa.dataAgendada.day == hoje.day &&
//                                             etapa.dataAgendada.month ==
//                                                 hoje.month &&
//                                             etapa.dataAgendada.year ==
//                                                 hoje.year;

//                                     return Column(
//                                       children: [
//                                         // Quadradinho
//                                         MouseRegion(
//                                           cursor: SystemMouseCursors.click,
//                                           child: Tooltip(
//                                             message:
//                                                 '${etapa.nome}\n${etapa.mensagem}\nData: ${etapa.dataAgendada.day}/${etapa.dataAgendada.month}',
//                                             child: Container(
//                                               width: 25,
//                                               height: 35,
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 4),
//                                               decoration: BoxDecoration(
//                                                 color: corEtapa(etapa),
//                                                 borderRadius:
//                                                     BorderRadius.circular(4),
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                         // SETA ↓ somente se for a etapa do dia
//                                         if (isHoje)
//                                           const Icon(
//                                             Icons.arrow_drop_down,
//                                             size: 32,
//                                             color: Colors.black87,
//                                           )
//                                         else
//                                           const SizedBox(height: 32),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math';

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
}

class Parcela {
  final double valor;
  final DateTime vencimento;
  final List<Etapa> etapas;

  Parcela({
    required this.valor,
    required this.vencimento,
    required this.etapas,
  });
}

class Cliente {
  final String nome;
  final List<Parcela> parcelas;

  Cliente({
    required this.nome,
    required this.parcelas,
  });
}

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    processarAcoes();
  }

  final DateTime hoje = DateTime.now();
  bool expandido = false;

  // Gera 8 etapas da régua para cada parcela (baseado no vencimento passado)
  List<Etapa> gerarEtapas(DateTime vencimento, DateTime dataEmissao) {
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

  // Exemplo de clientes/parcela (você pode gerar mais)
  final dataEmissao = DateTime.now();
  late final List<Cliente> clientes = [
    Cliente(
      nome: 'Mauricio de Medeiros',
      parcelas: [
        Parcela(
          valor: 80,
          vencimento: DateTime(2025, 12, 02),
          etapas: gerarEtapas(DateTime(2025, 12, 02), dataEmissao),
        ),
        Parcela(
          valor: 80,
          vencimento: DateTime(2026, 01, 07),
          etapas: gerarEtapas(DateTime(2026, 01, 07), dataEmissao),
        ),
      ],
    ),
  ];

  Color corDaEtapa(Etapa etapa, Parcela parcela) {
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

  Etapa? etapaAtual(Parcela parcela) {
    final hoje = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var etapa in parcela.etapas) {
      final data = DateTime(
        etapa.dataAgendada.year,
        etapa.dataAgendada.month,
        etapa.dataAgendada.day,
      );

      // A etapa atual é a primeira cuja data chegou ou é hoje
      if (!data.isAfter(hoje)) {
        return etapa;
      }
    }

    // Se nenhuma etapa chegou ainda → Emissão é a atual
    return parcela.etapas.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Régua de Cobrança - Desktop')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: clientes.length,
          itemBuilder: (context, cIndex) {
            final cliente = clientes[cIndex];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expandido = !expandido;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(cliente.nome,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Icon(
                            expandido
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 26,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: clienteTemAtraso(cliente)
                                    ? Colors.pink
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.black12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (expandido) ...[
                      const SizedBox(height: 12),
                      Column(
                        children: cliente.parcelas.map((parcela) {
                          // --- lógica correta da etapa atual ---
                          final hoje = DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day);

                          int currentEtapaIndex = 0;

                          for (int i = 0; i < parcela.etapas.length; i++) {
                            final etapa = parcela.etapas[i];

                            final dataEtapa = DateTime(
                              etapa.dataAgendada.year,
                              etapa.dataAgendada.month,
                              etapa.dataAgendada.day,
                            );

                            // Quando achar a primeira etapa FUTURA → a etapa atual é a anterior
                            if (dataEtapa.isAfter(hoje)) {
                              currentEtapaIndex =
                                  (i - 1).clamp(0, parcela.etapas.length - 1);
                              break;
                            }

                            // Se estiver no último item e nenhum for futuro → última etapa
                            if (i == parcela.etapas.length - 1) {
                              currentEtapaIndex = i;
                            }
                          }
                          // ---------------------------------------------------

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Parcela R\$ ${parcela.valor.toStringAsFixed(2)} - Vencimento: '
                                  '${parcela.vencimento.day}/${parcela.vencimento.month}/${parcela.vencimento.year}',
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 90,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: parcela.etapas.length,
                                    itemBuilder: (context, eIndex) {
                                      final etapa = parcela.etapas[eIndex];
                                      final bool isCurrent =
                                          currentEtapaIndex == eIndex;

                                      return Column(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Tooltip(
                                              message:
                                                  '${etapa.nome}\n${etapa.mensagem}\nData: ${etapa.dataAgendada.day}/${etapa.dataAgendada.month}/${etapa.dataAgendada.year}',
                                              child: Container(
                                                width: 120,
                                                height: 55,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: corDaEtapa(
                                                      etapa, parcela),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: isCurrent
                                                      ? Border.all(
                                                          color: Colors.black54,
                                                          width: 2,
                                                        )
                                                      : null,
                                                  boxShadow: isCurrent
                                                      ? [
                                                          BoxShadow(
                                                            color: const Color
                                                                .fromARGB(
                                                                31, 79, 61, 61),
                                                            blurRadius: 6,
                                                            offset:
                                                                Offset(0, 3),
                                                          )
                                                        ]
                                                      : null,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  etapa.nome.contains('dias')
                                                      ? etapa.nome
                                                      : etapa.nome
                                                          .split(' ')
                                                          .first,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          if (isCurrent)
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              size: 28,
                                              color: Colors.black87,
                                            )
                                          else
                                            const SizedBox(height: 28),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void processarAcoes() {
    for (var cliente in clientes) {
      for (var parcela in cliente.parcelas) {
        for (var etapa in parcela.etapas) {
          final hoje = DateTime.now();

          // Se chegou o dia dessa etapa
          if (!etapa.dataAgendada.isAfter(hoje) && etapa.concluida == false) {
            executarAcao(etapa); // << envia mensagem, registra log etc.
          }
        }
      }
    }
  }

  void executarAcao(Etapa etapa) {
    print("Executando ação: ${etapa.nome}");

    // Exemplo: envio de email
    if (etapa.nome.contains("Emissão")) {
      // enviar email inicial
    }

    if (etapa.nome.contains("vencimento")) {
      // enviar aviso pre-vencimento
    }

    if (etapa.nome.contains("atraso")) {
      // enviar cobrança / WhatsApp
    }

    // Ou você pode transformar cada etapa em um enum e deixar mais organizado
  }
}
