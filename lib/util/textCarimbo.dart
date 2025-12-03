import 'package:flutter/material.dart';

class DiagonalStampText extends StatelessWidget {
  final String text;

  const DiagonalStampText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.4, // em radianos, ajuste para inclinação desejada
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Opacity(
          opacity: 0.7, // dá aquele efeito “carimbo” desgastado
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
