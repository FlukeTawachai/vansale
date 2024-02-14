import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckMiles.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/deliveryAddProductCard.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BuildContext? scaffoldContext;
  bool discovered = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 1,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo:
          'โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน ',
      price: 9999.00,
      amount: 99999999.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: true,
    ),
    ProductsModel(
      id: 2,
      name: "สินค้า 2",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: true,
    ),
    ProductsModel(
      id: 3,
      name: "สินค้า 3",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product3.png",
      check: false,
    ),
    ProductsModel(
      id: 4,
      name: "สินค้า 4",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product4.png",
      check: false,
    ),
    ProductsModel(
      id: 5,
      name: "สินค้า 5",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: false,
    ),
    ProductsModel(
      id: 6,
      name: "สินค้า 6",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: false,
    ),
  ];

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {

    super.initState();
    // discovered == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "สะแกนบาร์โค้ด",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        // leading: Container(),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: IconButton(
                icon: Icon(
                  LineAwesomeIcons.calculator,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CheckInMiles(
                          headerTitle: 'กรอกบาร์โค้ดด้วยตัวเอง',
                          title: 'กรอกบาร์โค้ด',
                          cancel: () {
                            Navigator.of(context).pop();
                          },
                          submit: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  );
                }),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildQrView(context)),
          // result != null ? Text('${result.code}') : Container(),
          discovered
              ? Container()
              : Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(LineAwesomeIcons.exclamation_circle,
                                color: Colors.white)),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("ไม่พบสินค้าในคลัง",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                  fontSize: 16))),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: const Text('ตกลง',
                              style: TextStyle(
                                  fontFamily: 'Prompt', fontSize: 16)),
                          onPressed: () {
                            setState(() {
                              discovered = !discovered;
                              _buildQrView(context);
                            });

                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => QrScanner(),
                            // ));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              textStyle: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
          Expanded(
              child: result != null
                  ? ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: DeliveryAddProductCard(
                              mode: "new", product: virtualProduct[index]),
                        );
                      })
                  : Container()),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Container(
          height: 48.0,
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(LineAwesomeIcons.check_circle, size: 24, color: Colors.green),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "บันทึก",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 225.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
