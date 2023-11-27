import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MyBluetoohService {
  static Future<void> ligarBluetooth() async {
    await FlutterBluePlus.turnOn();
  }

  static Future<bool> verificaBluetooth() async {
    bool value = false;
    await FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        print('deu certo');
        value = true;
      } else {
        value = false;
      }
    });
    print('Valor value : $value');
    return value;
  }
}
