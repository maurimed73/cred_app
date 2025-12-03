import 'package:flutter/material.dart';

class ToastUtils {
  static void showDesktopToast(BuildContext context, String mensagem) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        left: MediaQuery.of(context).size.width * 0.3,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.black87,
            child: Text(
              mensagem,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
