import 'dart:convert';
import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ThermalPrint extends StatefulWidget {
  const ThermalPrint({Key? key}) : super(key: key);

  @override
  State<ThermalPrint> createState() => _ThermalPrintState();
}

class _ThermalPrintState extends State<ThermalPrint> {
  List<BluetoothDevice> device = [];
  late BluetoothDevice selectDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('thermal print'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<BluetoothDevice>(
              hint: const Text('เลือก'),
              value: selectDevice,
              items: device
                  .map((e) => DropdownMenuItem(
                        child: Text(e.name ?? ''),
                        value: e,
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectDevice = value;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  printer.connect(selectDevice);
                },
                child: const Text('connect')),
            ElevatedButton(
                onPressed: () {
                  printer.disconnect();
                },
                child: const Text('disconnect')),
            ElevatedButton(
                onPressed: () async {
                  var response = await http.get(Uri.parse(
                      "https://raw.githubusercontent.com/kakzaki/blue_thermal_printer/master/example/assets/images/yourlogo.png"));
                  Uint8List bytesNetwork = response.bodyBytes;
                  Uint8List imageBytesFromNetwork = bytesNetwork.buffer
                      .asUint8List(bytesNetwork.offsetInBytes,
                          bytesNetwork.lengthInBytes);

                  ///image from Asset
                  ByteData bytesAsset =
                      await rootBundle.load("assets/images/logo.png");
                  Uint8List imageBytesFromAsset = bytesAsset.buffer.asUint8List(
                      bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);
                  if (await printer.isConnected ?? false) {
                    //size
                    // 0 : Normal
                    // 1: Normal - Bold
                    // 2: Medium - Bold
                    // 3: Large - Bold

                    // ALIGN
                    // 0: left
                    // 1: center
                    // 2: right
                    printer.printCustom('การบ้าน', 2, 1);
                    // printer.printQRcode('Tawatchai', 200, 200, 1);
                    printer.printNewLine();
                    // printer.printImageBytes(imageBytesFromAsset);

                    printer.printNewLine();
                  }
                },
                child: const Text('print test')),
          ],
        ),
      ),
    );
  }

  void getDevice() async {
    device = await printer.getBondedDevices();
    setState(() {});
  }
}
