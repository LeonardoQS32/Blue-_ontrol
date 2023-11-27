import 'package:blue_control/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BlueControl extends StatelessWidget {
  const BlueControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blue control',
        theme: ThemeData.dark(),
        routes: {'/': (context) => const HomeScreen()});
  }
}
