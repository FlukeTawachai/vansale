import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:blue_print_pos/receipt/receipt_section_text.dart';
import 'package:blue_print_pos/receipt/receipt_text_size_type.dart';
import 'package:blue_print_pos/receipt/receipt_text_style_type.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as RB;
import 'package:sqflite/sqflite.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/database/class/blueDevice.dart';
import 'package:vansale/database/dbHelper.dart';
import 'package:vansale/screens/Supplier/Pay/pay_main.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/Widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class BluPrintPOS extends StatefulWidget {
  final String code;
  const BluPrintPOS({Key key, this.code}) : super(key: key);

  @override
  State<BluPrintPOS> createState() => _BluPrintPOSState();
}

class _BluPrintPOSState extends State<BluPrintPOS> {
  final formatNum = new NumberFormat("#,###.##", "en_US");
  String poDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String timeNow = DateFormat('HH:mm a').format(DateTime.now());
  String dateNewF = '';
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;
  bool pdfSave = false;
  bool printSave = true;
  BlueDevice deviceSelect;
  List<BlueDevice> deviceList = [BlueDevice(address: '', name: "เลือก")];
  String deviceName = '', deviceAdd = '';
  Database database;
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];
  var unitList = [];

  // BLE weighing
  final flutterReactiveBle = RB.FlutterReactiveBle();
  RB.DiscoveredDevice deviceChipseaBle;
  String mButtonText = "Connect Chipsea-BLE";
  String mWeighingReading = "---";
  String mUnit = "no";
  double widthScreen;
  Future<List<BluetoothDevice>> bluDevlist;

  @override
  void initState() {
    super.initState();
    (WidgetsBinding.instance)?.addPostFrameCallback((_) async {});
    _onScanPressed();
    var list = poDate.split('-');
    dateNewF = '${list[0]}/${list[1]}/${int.parse(list[2]) + 543}';
    bluDevlist = getDeviceList();
    // getBlueDeviceList();
    // print(deviceSelect.name);
    if (GlobalParam.deliveryStoreSum.cPOCD != null) {
      getPodt(GlobalParam.deliveryStoreSum.cPOCD);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  getBlueDeviceList() async {
    bluDevlist = getDeviceList();
    if (GlobalParam.blueListDevice.length > 0) {
      for (int i = 0; i < GlobalParam.blueListDevice.length; i++) {
        deviceList.add(BlueDevice(
            name: GlobalParam.blueListDevice[i].name,
            address: GlobalParam.blueListDevice[i].address));
      }
    }
  }

  Future<void> _onScanPressed() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      GlobalParam.bluetoothConnect = false;
      GlobalParam.selectDevice = BlueDevice(name: '', address: '');
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
          deviceName = '';
          deviceAdd = '';
        });
      }
    });
  }

  void _onSelectDevice(int index) async {
    // box.put('test', 'test');
    bool checkRepeat = false;

    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      GlobalParam.bluetoothConnect = true;
      GlobalParam.selectDevice = blueDevice;

      if (status == ConnectionStatus.connected) {
        if (deviceList.isNotEmpty) {
          var addressCheck = '';
          var roleCodeCheck = [];
          var codeEntityList = [];
          var bluAddRepeat = false;
          for (int i = 0; i < deviceList.length; i++) {
            if (blueDevice.address == deviceList[i].address) {
              checkRepeat = true;
            }
          }
          for (int i = 0; i < deviceList.length; i++) {
            if (deviceList[i].address == blueDevice.address) {
              bluAddRepeat = true;
            }
          }
          if (bluAddRepeat == false) {
            BluetoothDevice barcode = BluetoothDevice(
                id: deviceList.length + 1,
                name: blueDevice.name,
                address: blueDevice.address,
                createDT: DateTime.now().toIso8601String());
            insertDevice(barcode);

            // print(barcode.id);
            // print(barcode.name);
            // print(barcode.address);
            // print(barcode.createDT);
          }
        }

        // if (checkRepeat == false) {
        //   BluetoothDevice barcode = BluetoothDevice(
        //       id: '${deviceList.length + 1}',
        //       name: blueDevice.name,
        //       address: blueDevice.address,
        //       createDT: DateTime.now().toIso8601String());
        //   insertDevice(barcode);

        //   print(barcode.id);
        //   print(barcode.name);
        //   print(barcode.address);
        //   print(barcode.createDT);
        // }

        setState(() {
          _isLoading = true;
          _loadingAtIndex = index;
          _selectedDevice = blueDevice;
          deviceName = blueDevice.name;
          deviceAdd = blueDevice.address;
          deviceList.add(blueDevice);
        });
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        if (kDebugMode) {
          print('$runtimeType - something wrong');
        }
      }
      setState(() => _isLoading = false);
    });
  }

  void _bluConnectDevice(BlueDevice blueDevice) async {
    // box.put('test', 'test');
    bool checkRepeat = false;

    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      GlobalParam.bluetoothConnect = true;
      GlobalParam.selectDevice = blueDevice;

      if (status == ConnectionStatus.connected) {
        if (deviceList.isNotEmpty) {
          var addressCheck = '';
          var roleCodeCheck = [];
          var codeEntityList = [];
          var bluAddRepeat = false;
          for (int i = 0; i < deviceList.length; i++) {
            if (blueDevice.address == deviceList[i].address) {
              checkRepeat = true;
            }
          }
        }

        setState(() {
          _isLoading = true;
          _selectedDevice = blueDevice;
          deviceName = blueDevice.name;
          deviceAdd = blueDevice.address;
        });
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        if (kDebugMode) {
          print('$runtimeType - something wrong');
        }
      }
      setState(() => _isLoading = false);
    });
  }

  Future<void> _onPrintBill() async {
    final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();

    // header
    receipt01.addText(
      'นายกัณฐ์ เทรดดิ้ง',
      size: ReceiptTextSizeType.large,
      style: ReceiptTextStyleType.bold,
    );
    receipt01.addText(
      'ใบส่งสินค้า',
      size: ReceiptTextSizeType.medium,
      style: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);

    // locationStore
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cCUSTNM,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cADDRESS,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cSUBDIST,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cDISTRICT,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      '${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);
    receipt01.addLeftRightText(
      'วันที่ ${dateNewF}',
      'เวลา $timeNow',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'เลขที่ ${GlobalParam.deliveryPodtList[0].cPOCD}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);

    // productHeader
    receipt01.addLeftRightText(
      'รายละเอียด',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // productList() {

    for (int index = 0; index < GlobalParam.deliveryPodtList.length; index++) {
      String unitNM = '';
      double qty = 0, prince = 0;
      // ignore: unrelated_type_equality_checks
      if (double.parse(GlobalParam.deliveryPodtList[index].iSSIZEQTY) > 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iSSIZEQTY);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iSUNITPRICE);
        unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM;
        // ignore: unrelated_type_equality_checks
      }
      if (double.parse(GlobalParam.deliveryPodtList[index].iMSIZEQTY) > 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iMSIZEQTY);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iMUNITPRICE);
        unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM;
        // ignore: unrelated_type_equality_checks
      }
      if (double.parse(GlobalParam.deliveryPodtList[index].iLSIZEQTY) > 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iLSIZEQTY);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE);
        unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM;
      }

      receipt01.addLeftRightText(
        GlobalParam.deliveryPodtList[index].cPRODNM,
        '',
        leftSize: ReceiptTextSizeType.medium,
        leftStyle: ReceiptTextStyleType.bold,
        // rightSize: ReceiptTextSizeType.medium,
        // rightStyle: ReceiptTextStyleType.bold,
      );
      receipt01.addLeftRightText(
        '$unitNM@${qty.toStringAsFixed(0)}',
        '${prince.toStringAsFixed(2)}',
        leftSize: ReceiptTextSizeType.medium,
        // leftStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.medium,
        // rightStyle: ReceiptTextStyleType.bold,
      );
    }
    receipt01.addSpacer(useDashed: true);

    // incompHeader
    receipt01.addLeftRightText(
      'สินค้าขาด',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // incompList
    for (int index = 0; index < GlobalParam.deliveryProIncom.length; index++) {
      if (GlobalParam.deliveryProIncom[index].iINCOMPRO == null) {
        GlobalParam.deliveryProIncom[index].iINCOMPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryProIncom[index].iINCOMPRO;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (double.parse(GlobalParam.deliveryProIncom[index].iSSIZEQTY) > 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryProIncom[index].iSUNITPRICE);
        unitNM = GlobalParam.deliveryProIncom[index].cSUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(GlobalParam.deliveryProIncom[index].iMSIZEQTY) >
          0) {
        prince =
            qty * double.parse(GlobalParam.deliveryProIncom[index].iMUNITPRICE);
        unitNM = GlobalParam.deliveryProIncom[index].cMUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(GlobalParam.deliveryProIncom[index].iLSIZEQTY) >
          0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE);
        unitNM = GlobalParam.deliveryProIncom[index].cLUOMNM;
      }
      if (GlobalParam.deliveryProIncom[index].iINCOMPRO != 0 &&
          GlobalParam.deliveryProIncom[index].iINCOMPRO != null) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryProIncom[index].cPRODNM,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)}',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);
    // cancelHeader
    receipt01.addLeftRightText(
      'คืน/เหลือ',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // cancelList
    for (int index = 0; index < GlobalParam.deliveryPodCancel.length; index++) {
      if (GlobalParam.deliveryPodCancel[index].iCANCLEPRO == null) {
        GlobalParam.deliveryPodCancel[index].iCANCLEPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryPodCancel[index].iCANCLEPRO;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (double.parse(GlobalParam.deliveryPodCancel[index].iSSIZEQTY) > 0) {
        prince = qty *
            double.parse(GlobalParam.deliveryPodCancel[index].iSUNITPRICE);
        unitNM = GlobalParam.deliveryPodCancel[index].cSUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(GlobalParam.deliveryPodCancel[index].iMSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryPodCancel[index].iMUNITPRICE);
        unitNM = GlobalParam.deliveryPodCancel[index].cMUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(GlobalParam.deliveryPodCancel[index].iLSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryPodCancel[index].iLUNITPRICE);
        unitNM = GlobalParam.deliveryPodCancel[index].cLUOMNM;
      }
      if (GlobalParam.deliveryPodCancel[index].iCANCLEPRO != 0 &&
          GlobalParam.deliveryPodCancel[index].iCANCLEPRO != null) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryPodCancel[index].cPRODNM,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)}',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);

    // lossHeader
    receipt01.addLeftRightText(
      'สินค้าดี',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // return good product
    for (int index = 0;
        index < GlobalParam.deliveryReturnGoodPro.length;
        index++) {
      if (GlobalParam.deliveryReturnGoodPro[index].iCANCLEPRO == null) {
        GlobalParam.deliveryReturnGoodPro[index].iCANCLEPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryReturnGoodPro[index].iCANCLEPRO;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (double.parse(GlobalParam.deliveryReturnGoodPro[index].iSSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnGoodPro[index].iSUNITPRICE);
        unitNM = GlobalParam.deliveryReturnGoodPro[index].cSUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(
              GlobalParam.deliveryReturnGoodPro[index].iMSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnGoodPro[index].iMUNITPRICE);
        unitNM = GlobalParam.deliveryPodCancel[index].cMUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(
              GlobalParam.deliveryReturnGoodPro[index].iLSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnGoodPro[index].iLUNITPRICE);
        unitNM = GlobalParam.deliveryReturnGoodPro[index].cLUOMNM;
      }
      if (GlobalParam.deliveryReturnGoodPro[index].iCANCLEPRO != 0 &&
          GlobalParam.deliveryReturnGoodPro[index].iCANCLEPRO != null) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryReturnGoodPro[index].cPRODNM,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)}',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);

    // lossHeader
    receipt01.addLeftRightText(
      'สินค้าเสีย',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // return bad product
    for (int index = 0;
        index < GlobalParam.deliveryReturnBadPro.length;
        index++) {
      if (GlobalParam.deliveryReturnBadPro[index].iCANCLEPRO == null) {
        GlobalParam.deliveryReturnBadPro[index].iCANCLEPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryReturnBadPro[index].iCANCLEPRO;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (double.parse(GlobalParam.deliveryReturnBadPro[index].iSSIZEQTY) > 0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnBadPro[index].iSUNITPRICE);
        unitNM = GlobalParam.deliveryReturnBadPro[index].cSUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(
              GlobalParam.deliveryReturnBadPro[index].iMSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnBadPro[index].iMUNITPRICE);
        unitNM = GlobalParam.deliveryPodCancel[index].cMUOMNM;
        // ignore: unrelated_type_equality_checks
      } else if (double.parse(
              GlobalParam.deliveryReturnBadPro[index].iLSIZEQTY) >
          0) {
        prince = qty *
            double.parse(GlobalParam.deliveryReturnBadPro[index].iLUNITPRICE);
        unitNM = GlobalParam.deliveryReturnBadPro[index].cLUOMNM;
      }
      if (GlobalParam.deliveryReturnBadPro[index].iCANCLEPRO != 0 &&
          GlobalParam.deliveryReturnBadPro[index].iCANCLEPRO != null) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryReturnBadPro[index].cPRODNM,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)}',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);

    // basketHeader
    receipt01.addLeftRightText(
      'คืนตะกร้า',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // basketList
    for (int index = 0; index < GlobalParam.deliveryBasketReq.length; index++) {
      String basName = '';
      double basTotal = 0;
      for (int i = 0; i < GlobalParam.deliveryBasketList.length; i++) {
        if (GlobalParam.deliveryBasketList[i].cBASKCD ==
            GlobalParam.deliveryBasketReq[index].cBASKCD) {
          basName = GlobalParam.deliveryBasketList[i].cBASKNM;
          basTotal = GlobalParam.deliveryBasketReq[index].iQTY *
              double.parse(GlobalParam.deliveryBasketList[i].iPRICE);
        }
      }
      if (GlobalParam.deliveryBasketReq[index].iQTY != 0) {
        receipt01.addLeftRightText(
          '$basName@${GlobalParam.deliveryBasketReq[index].iQTY}',
          '${basTotal.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }
    receipt01.addSpacer(useDashed: true);
    // footer
    List unitName = [];
    double totalItem = 0;
    double totalIncom = 0;
    double totalCancel = 0;
    double totalReGood = 0;
    double totalReBad = 0;
    var listItem = [];
    for (int i = 0; i < GlobalParam.deliveryUnitList.length; i++) {
      unitName.add(GlobalParam.deliveryUnitList[i]['cUOMNM']);
    }

    var unitList = unitName.toSet().toList();

    for (int i = 0; i < unitList.length; i++) {
      int num = 0;
      double numItem = 0;

      for (int j = 0; j < GlobalParam.deliveryUnitList.length; j++) {
        if (unitList[i] == GlobalParam.deliveryUnitList[j]['cUOMNM']) {
          double total = GlobalParam.deliveryUnitList[j]['iTOTAL'];
          double prince = GlobalParam.deliveryUnitList[j]['iPRICE'];
          num++;
          numItem += total;
        }
      }
      totalItem += numItem;
      var text = {
        "unitName": unitList[i],
        "qty": num,
        "sumItem": numItem.toStringAsFixed(0)
      };
      listItem.add(text);
    }
    for (int i = 0; i < GlobalParam.deliveryProIncom.length; i++) {
      var qty = 0.0;
      var price = 0.0;
      qty = double.parse('${GlobalParam.deliveryProIncom[i].iINCOMPRO}');
      if (double.parse(GlobalParam.deliveryProIncom[i].iSSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryProIncom[i].iSUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryProIncom[i].iMSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryProIncom[i].iMUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryProIncom[i].iLSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryProIncom[i].iLUNITPRICE);
      }
      totalIncom += qty * price;
    }

    for (int i = 0; i < GlobalParam.deliveryPodCancel.length; i++) {
      var qty = 0.0;
      var price = 0.0;
      qty = double.parse('${GlobalParam.deliveryPodCancel[i].iCANCLEPRO}');
      if (double.parse(GlobalParam.deliveryPodCancel[i].iSSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryPodCancel[i].iSUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryPodCancel[i].iMSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryPodCancel[i].iMUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryPodCancel[i].iLSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryPodCancel[i].iLUNITPRICE);
      }
      totalCancel += qty * price;
    }

    for (int i = 0; i < GlobalParam.deliveryReturnGoodPro.length; i++) {
      var qty = 0.0;
      var price = 0.0;
      qty = double.parse('${GlobalParam.deliveryReturnGoodPro[i].iCANCLEPRO}');
      if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iSSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnGoodPro[i].iSUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iMSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnGoodPro[i].iMUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iLSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnGoodPro[i].iLUNITPRICE);
      }
      totalReGood += qty * price;
    }

    for (int i = 0; i < GlobalParam.deliveryReturnBadPro.length; i++) {
      var qty = 0.0;
      var price = 0.0;
      qty = double.parse('${GlobalParam.deliveryReturnBadPro[i].iCANCLEPRO}');
      if (double.parse(GlobalParam.deliveryReturnBadPro[i].iSSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnBadPro[i].iSUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryReturnBadPro[i].iMSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnBadPro[i].iMUNITPRICE);
      }
      if (double.parse(GlobalParam.deliveryReturnBadPro[i].iLSIZEQTY) > 0) {
        price = double.parse(GlobalParam.deliveryReturnBadPro[i].iLUNITPRICE);
      }
      totalReBad += qty * price;
    }

    receipt01.addLeftRightText(
      'รวมทั้งหมด',
      '${formatNum.format(double.parse(GlobalParam.deliveryStoreSum.iTOTAL) - totalIncom - totalCancel - totalReGood - totalReBad)}',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      'รวม ${GlobalParam.deliveryStoreSum.iitems} รายการ',
      'จำนวน  ${totalItem.toStringAsFixed(0)} ชิ้น',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      'ได้ตรวจรับสิ่งของและชำระเงินถูกต้องเรียบร้อยแล้ว',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'ผู้ส่งของ/รับเงิน',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addText('',
        size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold);
    receipt01.addText('ลงชื่อ______________________',
        size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold);

    await _bluePrintPos.printReceiptText(receipt01, feedCount: 1).then(
        (value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (comtext) => SupPay())));
  }

  Future<void> _onPrintReceipt() async {
    final ReceiptSectionText receipt01 = ReceiptSectionText();
    receipt01.addText(
      'พิมพ์ทดสอบ',
      size: ReceiptTextSizeType.large,
      style: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      '${GlobalParam.selectDevice.name}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      '${GlobalParam.selectDevice.address}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'วันที่ ${dateNewF}',
      'เวลา $timeNow',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    await _bluePrintPos.printReceiptText(receipt01, feedCount: 1);
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่าบลูทูธ'),
        centerTitle: true,
        leading: Icon(LineAwesomeIcons.cog),
        actions: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child:
                  Container(child: Center(child: Icon(LineAwesomeIcons.print))),
            ),
            GlobalParam.bluetoothConnect == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 18, 6),
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                : Container()
          ]),
        ],
      ),
      body: SafeArea(
        child: _isLoading && _blueDevices.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : _blueDevices.isNotEmpty
                ? SingleChildScrollView(
                    // padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                              child: Row(
                            children: [
                              Container(
                                  width: widthScreen * 0.05,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.green,
                                    value: pdfSave,
                                    onChanged: (bool value) {
                                      if (widget.code == '002') {
                                        wrongDialog('บันทึก PDF เรียบร้อยแล้ว');
                                        setState(() {
                                          pdfSave = value;
                                          printSave = !printSave;
                                        });
                                      }
                                    },
                                  )),
                              SizedBox(width: 12),
                              Container(
                                width: widthScreen * 0.5,
                                child: Text(
                                  'PDF',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: widget.code == '002'
                                          ? Colors.black
                                          : Colors.grey,
                                      fontFamily: 'Prompt',
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                              height: 48,
                              child: Row(
                                children: [
                                  Container(
                                      width: widthScreen * 0.05,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.green,
                                        value: printSave,
                                        onChanged: (bool value) {
                                          setState(() {
                                            printSave = value;
                                            pdfSave = !pdfSave;
                                          });
                                        },
                                      )),
                                  SizedBox(width: 12),
                                  Container(
                                    width: widthScreen * 0.5,
                                    child: Text(
                                      'Printer',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Prompt',
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                              height: 48,
                              child: Row(
                                children: [
                                  Container(
                                      width: widthScreen * 0.2,
                                      child: Text(
                                        'ชื่อบลูทูธ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Prompt',
                                        ),
                                      )),
                                  SizedBox(width: 12),
                                  Container(
                                    width: widthScreen * 0.5,
                                    child: Text(
                                      deviceName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                              height: 48,
                              child: Row(
                                children: [
                                  Container(
                                    width: widthScreen * 0.2,
                                    child: Text(
                                      'แอดแดรส',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    width: widthScreen * 0.5,
                                    child: Text(
                                      deviceAdd,
                                      style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Container(
                              height: 48,
                              child: Row(
                                children: [
                                  Container(
                                    width: widthScreen * 0.2,
                                    child: Text(
                                      'ปริ้นเตอร์',
                                      style: TextStyle(
                                          fontFamily: 'Prompt', fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    width: widthScreen * 0.7,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ))),
                                    child: FutureBuilder(
                                        future: bluDevlist,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            List<BluetoothDevice>
                                                dataBlueDevice = snapshot.data;
                                            // deviceList = [BlueDevice(address: '', name: "เลือก")];
                                            if (deviceList.length <=
                                                dataBlueDevice.length) {
                                              for (int i = 0;
                                                  i < dataBlueDevice.length;
                                                  i++) {
                                                BlueDevice device = BlueDevice(
                                                    name:
                                                        dataBlueDevice[0].name,
                                                    address: dataBlueDevice[0]
                                                        .address);
                                                deviceList.add(device);
                                              }
                                            }

                                            // return Text('${dataBlueDevice[0].name}');
                                            return DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child:
                                                    DropdownButton<BlueDevice>(
                                                  hint: Text("เลือก"),
                                                  value: deviceSelect,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  style: TextStyle(
                                                    fontFamily: "Prompt",
                                                    fontSize: 16,
                                                    color: HexColor('#000000'),
                                                  ),
                                                  onChanged:
                                                      (BlueDevice newValue) {
                                                    if (newValue.address !=
                                                        '') {
                                                      _bluConnectDevice(
                                                          newValue);
                                                    } else {
                                                      _onDisconnectDevice();
                                                    }

                                                    setState(() {
                                                      deviceSelect = newValue;
                                                    });
                                                  },
                                                  items: deviceList.map<
                                                          DropdownMenuItem<
                                                              BlueDevice>>(
                                                      (BlueDevice value) {
                                                    // dropdownProvinceColor = '#000000';
                                                    return DropdownMenuItem<
                                                        BlueDevice>(
                                                      value: value,
                                                      child: Text(
                                                        value.name,
                                                        // style: TextStyle(
                                                        //     color: HexColor('${dropdownProvinceColor}')),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        }),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            height: 64,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: widthScreen * 0.2,
                                  decoration: BoxDecoration(
                                      color:
                                          GlobalParam.bluetoothConnect == true
                                              ? Colors.grey.shade300
                                              : Colors.green,
                                      border: Border(
                                          right: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ))),
                                  child: Center(
                                    child: Text(
                                      'เชื่อมต่อ',
                                      style: TextStyle(
                                          fontFamily: 'Prompt', fontSize: 14),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _onDisconnectDevice();
                                  },
                                  child: Container(
                                    width: widthScreen * 0.2,
                                    decoration: BoxDecoration(
                                        color:
                                            GlobalParam.bluetoothConnect == true
                                                ? Colors.green.shade300
                                                : Colors.grey.shade300,
                                        border: Border(
                                            right: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ))),
                                    child: Center(
                                      child: Text(
                                        'ยกเลิก',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Prompt',
                                          color: GlobalParam.bluetoothConnect ==
                                                  true
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (GlobalParam.selectDevice.address !=
                                        '') {
                                      if (widget.code == '001') {
                                        _onPrintReceipt();
                                      } else if (widget.code == '002') {
                                        _onPrintBill();
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: widthScreen * 0.2,
                                    decoration: BoxDecoration(
                                        color:
                                            GlobalParam.bluetoothConnect == true
                                                ? Colors.green.shade300
                                                : Colors.grey.shade300,
                                        border: Border(
                                            right: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ))),
                                    child: Center(
                                      child: Text(
                                        'พิมพ์',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Prompt',
                                          color: GlobalParam.bluetoothConnect ==
                                                  true
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _onScanPressed();
                                  },
                                  child: Container(
                                    width: widthScreen * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        border: Border(
                                            right: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ))),
                                    child: Center(
                                      child: Text(
                                        'รีเฟรช',
                                        style: TextStyle(
                                            fontFamily: 'Prompt', fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _onDisconnectDevice();
                                    _onScanPressed();
                                  },
                                  child: Container(
                                    color: GlobalParam.bluetoothConnect == true
                                        ? Colors.grey.shade300
                                        : Colors.green.shade300,
                                    width: widthScreen * 0.2,
                                    child: Center(
                                      child: Text(
                                        'ล้าง',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Column(
                          children: List<Widget>.generate(_blueDevices.length,
                              (int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: widthScreen * 0.15,
                                      child: Center(
                                        child: Icon(
                                          LineAwesomeIcons.bluetooth,
                                          size: 48,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _blueDevices[index].name,
                                                style: TextStyle(
                                                  color: _selectedDevice
                                                              ?.address ==
                                                          _blueDevices[index]
                                                              .address
                                                      ? Colors.green
                                                      : Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'Prompt',
                                                  // fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                _blueDevices[index].address,
                                                style: TextStyle(
                                                  color: _selectedDevice
                                                              ?.address ==
                                                          _blueDevices[index]
                                                              .address
                                                      ? Colors.blueGrey
                                                      : Colors.grey,
                                                  fontSize: 14,
                                                  fontFamily: 'Prompt',
                                                  // fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_loadingAtIndex == index && _isLoading)
                                      Container(
                                        height: 24.0,
                                        width: 24.0,
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child: const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.blue,
                                          ),
                                        ),
                                      ),
                                    // if (!_isLoading &&
                                    //     _blueDevices[index].address ==
                                    //         (_selectedDevice?.address ?? ''))
                                    //   TextButton(
                                    //     onPressed: _onPrintReceipt,
                                    //     child: Container(
                                    //       color: _selectedDevice == null
                                    //           ? Colors.grey
                                    //           : Colors.green,
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: const Text(
                                    //         'พิมพ์',
                                    //         style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 18),
                                    //       ),
                                    //     ),
                                    //     style: ButtonStyle(
                                    //       backgroundColor: MaterialStateProperty
                                    //           .resolveWith<Color>(
                                    //         (Set<MaterialState> states) {
                                    //           if (states.contains(
                                    //               MaterialState.pressed)) {
                                    //             return Theme.of(context)
                                    //                 .colorScheme
                                    //                 .primary
                                    //                 .withOpacity(0.5);
                                    //           }
                                    //           return Theme.of(context)
                                    //               .primaryColor;
                                    //         },
                                    //       ),
                                    //     ),
                                    //   ),
                                    InkWell(
                                      onTap: _blueDevices[index].address ==
                                              (_selectedDevice?.address ?? '')
                                          ? _onDisconnectDevice
                                          : () => _onSelectDevice(index),
                                      child: Container(
                                        height: 48,
                                        width: widthScreen * 0.2,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'เลือก',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Prompt',
                                              fontSize: 16),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'กรุณาเปิดบลูทูธ',
                          style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 24,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
      ),
      bottomNavigationBar: widget.code == "002"
          ? BottomAppBar(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (comtext) => SupPay()));
                },
                child: Container(
                  height: 64,
                  // width: widthScreen * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(5),
                    //   topRight: Radius.circular(5),
                    //   bottomLeft: Radius.circular(5),
                    //   bottomRight: Radius.circular(5),
                    // ),
                  ),
                  child: Center(
                      child: Text(
                    'ข้าม',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Prompt',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          : Container(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _isLoading ? null : _onScanPressed,
      //   child: const Icon(Icons.search),
      //   backgroundColor: _isLoading ? Colors.grey : Colors.green,
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    genenratePdf();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<BluetoothDevice> insertDevice(BluetoothDevice barcode) async {
    // print(barcode.id);
    // print(barcode.name);
    // print(barcode.address);
    // print(barcode.createDT);
    database = await DBManager.getDatabase();
    var dbClient = database;
    await dbClient.insert('blueDevice', barcode.toJson());
    return barcode;
  }

  Future<List<BluetoothDevice>> getDeviceList() async {
    database = await DBManager.getDatabase();
    List<Map<String, dynamic>> data = await database.query(
      'blueDevice',
    );
    print(data.length);
    return data.map((e) => BluetoothDevice.fromJson(e)).toList();
  }

  Future<void> genenratePdf() async {
    final pdf = pw.Document();
    final fontTHNA = await rootBundle.load("assets/fonts/TH_Niramit_AS.ttf");
    final TH_NA = pw.Font.ttf(fontTHNA);
    final fontTHNAB =
        await rootBundle.load("assets/fonts/TH_Niramit_AS_Bold.ttf");
    final TH_NA_B = pw.Font.ttf(fontTHNAB);
    final formatNum = new NumberFormat("#,###.##", "en_US");

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(56),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          pw.Widget header() {
            return pw.Container(
                child: pw.Center(
                    child: pw.Column(children: [
              pw.Text('นายกัณฐ์ เทรดดิ้ง',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Text('ใบส่งสินค้า',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA))
            ])));
          }

          pw.Widget locationStore() {
            return pw.Container(
                child: pw.Center(
                    child: pw.Column(children: [
              pw.Row(children: [
                pw.Text(GlobalParam.deliverySelectStore.cCUSTNM,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Text(GlobalParam.deliverySelectStore.cADDRESS,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Text(GlobalParam.deliverySelectStore.cSUBDIST,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Text(GlobalParam.deliverySelectStore.cDISTRICT,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Text(
                    '${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
            ])));
          }

          pw.Widget lineBreak() {
            return pw.Container(
                child: pw.Center(
              child: pw.Text(
                  '\n_______________________________________________________________\n\n',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ));
          }

          pw.Widget footer(var data) {
            List unitName = [];
            double totalItem = 0;
            var listItem = [];
            for (int i = 0; i < data.length; i++) {
              unitName.add(data[i]['cUOMNM']);
            }

            var unitList = unitName.toSet().toList();

            for (int i = 0; i < unitList.length; i++) {
              int num = 0;
              double numItem = 0;

              for (int j = 0; j < data.length; j++) {
                if (unitList[i] == data[j]['cUOMNM']) {
                  double total = double.parse(data[j]['iTOTAL']);
                  double prince = double.parse(data[j]['iPRICE']);
                  num++;
                  numItem += total / prince;
                }
              }
              totalItem += numItem;
              var text = {
                "unitName": unitList[i],
                "qty": num,
                "sumItem": numItem.toStringAsFixed(0)
              };
              listItem.add(text);
            }

            return pw.Container(
                child: pw.Center(
                    child: pw.Column(children: [
              pw.Row(children: [
                pw.Text('รวมทั้งหมด',
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
                pw.Text(
                    formatNum.format(
                        double.parse(GlobalParam.deliveryStoreSum.iTOTAL)),
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA))
              ]),
              pw.Row(children: [
                pw.Text(
                  'รวม ${GlobalParam.deliveryStoreSum.iitems} รายการ',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA),
                  textAlign: pw.TextAlign.left,
                ),
                pw.Spacer(),
                pw.Text(
                  'จำนวน  ${totalItem.toStringAsFixed(0)} ชิ้น',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA),
                  textAlign: pw.TextAlign.right,
                )
              ]),
              pw.Row(children: [
                pw.Text('ได้ตรวจรับสิ่งของและชำระเงินถูกต้องเรียบร้อยแล้ว',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Text(
                  'ผู้ส่งของ/รับเงิน',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA),
                  textAlign: pw.TextAlign.left,
                ),
                pw.Spacer(),
              ]),
              pw.SizedBox(height: 24),
              pw.Text('ลงชื่อ__________________________________',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ])));
          }

          pw.Widget productHeader() {
            return pw.Container(
                child: pw.Center(
              child: pw.Row(children: [
                pw.Container(
                    width: widthScreen * 0.2,
                    child: pw.Text('รายละเอียด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            font: TH_NA))),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('ยอดเงิน',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
            ));
          }

          pw.Widget productList() {
            for (int index = 0;
                index < GlobalParam.deliveryPodtList.length;
                index++) {
              String unitNM = '';
              double qty = 0, prince = 0;
              // ignore: unrelated_type_equality_checks
              if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
                qty =
                    double.parse(GlobalParam.deliveryPodtList[index].iSSIZEQTY);
                prince = double.parse(
                    GlobalParam.deliveryPodtList[index].iSUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
                qty =
                    double.parse(GlobalParam.deliveryPodtList[index].iMSIZEQTY);
                prince = double.parse(
                    GlobalParam.deliveryPodtList[index].iMUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
                qty =
                    double.parse(GlobalParam.deliveryPodtList[index].iLSIZEQTY);
                prince = double.parse(
                    GlobalParam.deliveryPodtList[index].iLUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM;
              }

              return pw.Center(
                  child: pw.Container(
                      child: pw.Column(children: [
                pw.Row(children: [
                  pw.Text(GlobalParam.deliveryPodtList[index].cPRODNM,
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                  pw.Spacer(),
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 196,
                    child: pw.Text(unitNM,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            font: TH_NA)),
                  ),
                  pw.Container(
                      width: 116,
                      child: pw.Text(qty.toStringAsFixed(0),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              font: TH_NA))),
                  pw.Container(
                      width: 172,
                      child: pw.Text(prince.toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              font: TH_NA))),
                ]),
              ])));
            }
          }

          pw.Widget incompHeader() {
            return pw.Container(
                child: pw.Center(
              child: pw.Row(children: [
                pw.Container(
                  width: widthScreen * 0.2,
                  child: pw.Text('สินค้าขาด',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('ยอดเงิน',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
            ));
          }

          pw.Widget incompList() {
            for (int index = 0;
                index < GlobalParam.deliveryPodtList.length;
                index++) {
              String unitNM = '';
              int qty = GlobalParam.deliveryPodtList[index].iINCOMPRO;
              double prince = 0;
              // ignore: unrelated_type_equality_checks
              if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iSUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iMUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iLUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM;
              }
              return pw.Center(
                  child: GlobalParam.deliveryPodtList[index].iINCOMPRO != 0
                      ? pw.Container(
                          child: pw.Column(children: [
                          pw.Row(children: [
                            pw.Text(GlobalParam.deliveryPodtList[index].cPRODNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                            pw.Spacer(),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                              width: 196,
                              child: pw.Text(unitNM,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA)),
                            ),
                            pw.Container(
                                width: 116,
                                child: pw.Text(qty.toStringAsFixed(0),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                            pw.Container(
                                width: 172,
                                child: pw.Text(prince.toStringAsFixed(2),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                          ]),
                        ]))
                      : pw.Container());
            }
          }

          pw.Widget cancelHeader() {
            return pw.Container(
                child: pw.Center(
              child: pw.Row(children: [
                pw.Container(
                  width: widthScreen * 0.2,
                  child: pw.Text('ไม่รับ/คืน',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('ยอดเงิน',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
            ));
          }

          pw.Widget cancelList() {
            for (int index = 0;
                index < GlobalParam.deliveryPodtList.length;
                index++) {
              String unitNM = '';
              int qty = GlobalParam.deliveryPodtList[index].iCANCLEPRO;
              double prince = 0;
              // ignore: unrelated_type_equality_checks
              if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iSUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iMUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM;
                // ignore: unrelated_type_equality_checks
              }
              if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iLUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM;
              }
              return pw.Center(
                  child: GlobalParam.deliveryPodtList[index].iCANCLEPRO != 0
                      ? pw.Container(
                          child: pw.Column(children: [
                          pw.Row(children: [
                            pw.Text(GlobalParam.deliveryPodtList[index].cPRODNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                            pw.Spacer(),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                              width: 196,
                              child: pw.Text(unitNM,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA)),
                            ),
                            pw.Container(
                                width: 116,
                                child: pw.Text(qty.toStringAsFixed(0),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                            pw.Container(
                                width: 172,
                                child: pw.Text(prince.toStringAsFixed(2),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                          ]),
                        ]))
                      : pw.Container());
            }
          }

          pw.Widget lossHeader() {
            return pw.Container(
                child: pw.Center(
              child: pw.Row(children: [
                pw.Container(
                  width: widthScreen * 0.2,
                  child: pw.Text('สินค้าขาด',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('ยอดเงิน',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
            ));
          }

          pw.Widget lossList() {
            for (int index = 0;
                index < GlobalParam.deliveryPodtList.length;
                index++) {
              String unitNM = '';
              int qty = GlobalParam.deliveryPodtList[index].iLOSSPRO;
              double prince = 0;
              // ignore: unrelated_type_equality_checks
              if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iSUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM;
                // ignore: unrelated_type_equality_checks
              } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iMUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM;
                // ignore: unrelated_type_equality_checks
              } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
                prince = qty *
                    double.parse(
                        GlobalParam.deliveryPodtList[index].iLUNITPRICE);
                unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM;
              }
              return pw.Center(
                  child: GlobalParam.deliveryPodtList[index].iLOSSPRO != 0
                      ? pw.Container(
                          child: pw.Column(children: [
                          pw.Row(children: [
                            pw.Text(GlobalParam.deliveryPodtList[index].cPRODNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                            pw.Spacer(),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                              width: 196,
                              child: pw.Text(
                                  "$unitNM@${qty.toStringAsFixed(0)}",
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA)),
                            ),
                            pw.Container(
                                width: 172,
                                child: pw.Text(prince.toStringAsFixed(2),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                          ]),
                        ]))
                      : pw.Container());
            }
          }

          pw.Widget basketHeader() {
            return pw.Container(
                child: pw.Center(
              child: pw.Row(children: [
                pw.Container(
                  width: widthScreen * 0.2,
                  child: pw.Text('คืนตะกร้า',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('ยอดเงิน',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
            ));
          }

          pw.Widget basketList() {
            for (int index = 0;
                index < GlobalParam.deliveryBasketReq.length;
                index++) {
              String basName = '';
              double basTotal = 0;
              for (int i = 0; i < GlobalParam.deliveryBasketList.length; i++) {
                if (GlobalParam.deliveryBasketList[i].cBASKCD ==
                    GlobalParam.deliveryBasketReq[index].cBASKCD) {
                  basName = GlobalParam.deliveryBasketList[i].cBASKNM;
                  basTotal = GlobalParam.deliveryBasketReq[index].iQTY *
                      double.parse(GlobalParam.deliveryBasketList[i].iPRICE);
                }
              }
              return pw.Center(
                  child: GlobalParam.deliveryBasketReq[index].iQTY != 0
                      ? pw.Container(
                          child: pw.Column(children: [
                          pw.Row(children: [
                            pw.Container(
                              width: 196,
                              child: pw.Text(basName,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA)),
                            ),
                            pw.Container(
                                width: 116,
                                child: pw.Text(
                                    GlobalParam.deliveryBasketReq[index].iQTY
                                        .toStringAsFixed(0),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                            pw.Container(
                                width: 172,
                                child: pw.Text(basTotal.toStringAsFixed(2),
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                        font: TH_NA))),
                          ]),
                        ]))
                      : pw.Container());
            }
          }

          pw.Widget dateOfBill() {
            return pw.Container(
                child: pw.Center(
                    child: pw.Column(children: [
              pw.Row(children: [
                pw.Container(
                    width: widthScreen * 0.5,
                    child: pw.Text('วันที่ ${dateNewF}',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            font: TH_NA))),
                pw.Container(
                  width: widthScreen * 0.8,
                  child: pw.Text('เวลา ${timeNow}',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
              ]),
              pw.Row(children: [
                pw.Text('เลขที่ ${GlobalParam.deliveryPodtList[0].cPOCD}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
            ])));
          }

          return <pw.Widget>[
            header(),
            lineBreak(),
            locationStore(),
            lineBreak(),
            dateOfBill(),
            lineBreak(),
            productHeader(),
            productList(),
            lineBreak(),
            incompHeader(),
            incompList(),
            lineBreak(),
            cancelHeader(),
            cancelList(),
            lineBreak(),
            lossHeader(),
            lossList(),
            lineBreak(),
            basketHeader(),
            basketList(),
            lineBreak(),
            footer(GlobalParam.deliveryUnitList)
          ];
        }));

    List<int> bytes = await pdf.save();
    String poDate = DateFormat('yyyyMMddHHmm').format(DateTime.now());
    // await file.writeAsBytes(await pdf.save());
    saveAndLaunchFile(
        bytes, '${GlobalParam.deliveryPodtList[0].cPOCD}_${poDate}.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    // final path = (await getExternalStorageDirectory()).path;
    final path = '/storage/emulated/0/Documents';
    final file = File('$path/$fileName');
    // final bit = await bytes;
    print('***************$path');
    await file
        .writeAsBytes(bytes, flush: true)
        .then((value) => {OpenFile.open('$path/$fileName')});
  }

  getPodt(String cPOCD) async {
    double sumItem = 0;
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getPodt(QueryPodtReq(
              cPOCD: cPOCD,
              cPRODCD: '%%',
              cPRODNM: '%%',
              cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));
          if (result.isNotEmpty) {
            //  print('+++++++++++++++++++ query TBT_PODT success +++++++++++++++++++');
            podtList.clear();
            for (int i = 0; i < result.length; i++) {
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);

              if (double.parse(result[i].iSSIZEQTY) > 0) {
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "cUOMNM": result[i].cSUOMNM,
                  "iPRICE": double.parse(result[i].iSUNITPRICE),
                  "iTOTAL": double.parse(result[i].iSSIZEQTY)
                };
                unitList.add(data);
                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: result[i].iSSIZEQTY,
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iSSIZEQTY) * double.parse(result[i].iSUNITPRICE)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iMSIZEQTY) > 0) {
                var data = {
                  "cUOMNM": result[i].cMUOMNM,
                  "iPRICE": double.parse(result[i].iMUNITPRICE),
                  "iTOTAL": double.parse(result[i].iMSIZEQTY)
                };
                unitList.add(data);
                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: result[i].iMSIZEQTY,
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iMSIZEQTY) * double.parse(result[i].iMUNITPRICE)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iLSIZEQTY) > 0) {
                var data = {
                  "cUOMNM": result[i].cLUOMNM,
                  "iPRICE": double.parse(result[i].iLUNITPRICE),
                  "iTOTAL": double.parse(result[i].iLSIZEQTY)
                };
                unitList.add(data);
                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: result[i].iLSIZEQTY,
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iLSIZEQTY) * double.parse(result[i].iLUNITPRICE)}",
                );

                podtList.add(product);
              }

              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }
            GlobalParam.deliveryPodtList = podtList;
            GlobalParam.deliveryPodtShow = podtList;
            GlobalParam.deliveryUnitList = unitList;
          } else {
            // print('+++++++++++++++++++ query TBT_PODT fail +++++++++++++++++++');
            podtList.clear();
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        setState(() {});
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }
}
