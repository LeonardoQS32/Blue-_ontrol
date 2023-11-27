//import 'dart:convert';
//import 'dart:io';

import 'dart:convert';

import 'package:blue_control/bluetooth_state.dart';
import 'package:blue_control/core/bluetooth_service.dart';
import 'package:blue_control/widgets/botao_conexao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothConnection? _connection;
  final _addressDevice = '00:23:09:A0:18:EA';
  BluetoothEstado _bluetoothState = BluetoothEstado.bluetoohOff;

  @override
  void initState() {
    _verificaBluetooth();
    //_verifica();
    _checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    if (_connection!.isConnected) {
      _connection?.dispose();
      _connection = null;
    }
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    }
    status = await Permission.bluetooth.status;

    if (status.isDenied) {
      await Permission.bluetooth.request();
    }
    status = await Permission.bluetoothScan.status;

    if (status.isDenied) {
      await Permission.bluetoothScan.request();
    }
    status = await Permission.bluetoothConnect.status;

    if (status.isDenied) {
      await Permission.bluetoothConnect.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    Widget botaoConexao = const Text('data');
    switch (_bluetoothState) {
      case BluetoothEstado.bluetoohOff:
        botaoConexao = const BotaoConexao(
            backgroundColor: Colors.redAccent,
            onPressed: MyBluetoohService.ligarBluetooth);
        break;
      case BluetoothEstado.bluetoohOn:
        botaoConexao = BotaoConexao(
            backgroundColor: Colors.blue, onPressed: _conectarComModulo);
        break;
      case BluetoothEstado.bluetoohConected:
        botaoConexao =
            BotaoConexao(backgroundColor: Colors.green, onPressed: () {});
        break;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          botaoConexao,
          const SizedBox(
            height: 25,
          ),
          BotaoConexao(
            onPressed: () {
              _sendData('FF');
            },
            backgroundColor: Colors.greenAccent,
          ),
        ]),
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _verificaBluetooth() {
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        _bluetoothState = BluetoothEstado.bluetoohOn;
      } else {
        _bluetoothState = BluetoothEstado.bluetoohOff;
      }
      setState(() {});
    });
  }

  Future<void> _ligarBluetooth() async {
    await FlutterBluePlus.turnOn();
  }

  Future<void> _conectarComModulo() async {
    try {
      BluetoothConnection.toAddress(_addressDevice).then((connection) {
        showSnackBar('Conectado com dispositivo');
        _connection = connection;
        _bluetoothState = BluetoothEstado.bluetoohConected;
        setState(() {});
      }).catchError((error) {
        showSnackBar('Erro ao tentar se conectar: $error');
      });
    } catch (exception) {
      showSnackBar('Erro: $exception');
    }
  }

  void _sendData(String data) {
    if (_connection != null) {
      _connection!.output.add(Uint8List.fromList(utf8.encode(data)));
      _connection!.output.allSent.then((_) {}).catchError((error) {
        showSnackBar('Erro ao enviar dados: $error');
      });
    } else {
      showSnackBar('Conexão Bluetooth não estabelecida.');
    }
  }
}
