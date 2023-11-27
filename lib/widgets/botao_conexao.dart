import 'package:flutter/material.dart';

class BotaoConexao extends StatelessWidget {
  //final IconData iconData;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const BotaoConexao({
    super.key,
    // required this.iconData,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.bluetooth),
        onPressed: onPressed,
        color: Colors.black,
        //iconSize: 10,
      ),
    );
  }
}
