import 'package:flutter/material.dart';

class BotaoDirecao extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData iconData;

  const BotaoDirecao(
      {super.key,
      this.onPressed,
      this.backgroundColor,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 3),
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(iconData),
        onPressed: onPressed,
        color: Colors.white70,
        iconSize: 48,
      ),
    );
  }
}
