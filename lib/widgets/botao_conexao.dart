import 'package:flutter/material.dart';

class BotaoConexao extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const BotaoConexao({
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 3),
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.bluetooth),
        onPressed: onPressed,
        color: Colors.white70,
        iconSize: 32,
      ),
    );
  }
}
