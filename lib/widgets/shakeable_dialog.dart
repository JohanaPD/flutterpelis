// ignore_for_file: dead_code, unused_label

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peliculas_flutter/screens/screen.dart';

class ShakeableDialog extends StatefulWidget {
  final Duration duration;
  final double distance;
  const ShakeableDialog(
      {super.key,
      this.duration = const Duration(milliseconds: 300),
      this.distance = 24.0});

  @override
  State<ShakeableDialog> createState() => _ShakeableDialogState();
}

class _ShakeableDialogState extends State<ShakeableDialog>
    with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: widget.duration);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: AlertDialog(
        title: const Text('Esta zona está en construcción'),
        content: const Text('Confirmo que he sido informado'),
        actions: [
          TextButton(
            child: const Text('Pulsar opciones'),
            onPressed: () async {
              await _controller.forward(from: 0.0);
              _controller.reset();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          TextButton(
            child: const Text('Acepto'),
            onPressed: () {
              _controller.forward(from: 0.0);
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          TextButton(
            child: const Text('Rechazo'),
            onPressed: () {
              _controller.reset();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
      builder: (BuildContext context, Widget? child) {
        //convertir grados en double, en este caso es el valor de la animación
        //por 2 y por pi y luego por la distancia del widget
        final dx = sin(_controller.value * 2 * pi) * widget.distance;
        return Transform.translate(
          offset: Offset(dx, 0),
          child: child,
        );
      },
    );
  }
}
