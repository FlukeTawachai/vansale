import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:signature/signature.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/apiexception.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceivBillReq.dart';
import 'package:vansale/api/class/request/mobile/getVehicleResp.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';
import 'dart:typed_data';

import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/namo/show_signature.dart';

class Signature2 extends StatefulWidget {
  final String cVEHICD;
  final int item;
  final double total;
  final String cREF;
  Signature2({Key key, this.cVEHICD, this.item, this.total, this.cREF})
      : super(key: key);

  @override
  State<Signature2> createState() => _Signature2State();
}

class _Signature2State extends State<Signature2> {
  // initialize the signature controller
  List<GetVehicleResp> receiver = [];
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
    getVehicle();
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ยืนยันการรับสินค้า',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopContainer(
                size: size,
                item: widget.item,
                total: widget.total,
                cREF: widget.cREF,
                cVEHINM: receiver.isEmpty ? GetVehicleResp() : receiver[0]),
            //SIGNATURE CANVAS
            Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'เซ็นรับสินค้า',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Signature(
                            height: 255,
                            width: 255,
                            key: const Key('signature'),
                            controller: _controller,
                            backgroundColor: Colors.white),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: //CLEAR CANVAS
                        Padding(
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      child: InkWell(
                        child: Icon(
                          Icons.clear,
                          color: Colors.green,
                        ),
                        onTap: () {
                          setState(() => _controller.clear());
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget buttonBar() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 0.0,
              child: InkWell(
                onTap: () async {
                  if (_controller.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        key: Key('snackbarPNG'),
                        content: Text('No content'),
                      ),
                    );
                    return;
                  }
                  final Uint8List data = await _controller.toPngBytes();
                  if (data != null) {
                    String img64 = base64Encode(data);
                    saveData(img64);
                  }
                },
                child: Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          LineAwesomeIcons.check_circle,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'ยืนยันการรับสินค้า',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveData(String base64Image) async {
    try {
      EasyLoading.show();
      AllApiProxyMobile proxy = AllApiProxyMobile();
      bool nextPage = false;
      if (base64Image != "" && base64Image != null) {
        // print("-----------------------${GlobalParam.imageStoreList.length }");
        var result = await proxy.addSupplierReceivBill(AddSupplierReceivBillReq(
            cRECEIVENO: widget.cREF,
            iSEQ: "1",
            cSERVER: "27.254.207.240:11110",
            cIB64: base64Image,
            cREFDOC: widget.cREF,
            cTYPE: "TPSS",
            cCREABY: GlobalParam.userID));
        if (result.success == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ConfirmPage(
                  GlobalParam.typeMenuCode, "เซ็นรับ", "เรียบร้อยแล้ว"),
            ),
          );
        } else {
          wrongDialog('${result.message}');
        }
      } else {
        EasyLoading.dismiss();
        wrongDialog('กรุณาเซ็นรับสินค้า');
      }
      EasyLoading.dismiss();
    } on ApiException catch (e) {
      EasyLoading.dismiss();
      print(e.cause);
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  getVehicle() async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${basketProduct.length}************');
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var check = 0;
      var result = await proxy.getVehicle(widget.cVEHICD);
      if (result.isNotEmpty) {
        setState(() {
          receiver = result;
        });
      } else {
        wrongDialog('ไม่พบข้อมูลผู้รับสินค้า');
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('แจ้งเตือน'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 16.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      'ตกลง',
                    );
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  TopContainer(
      {Key key, this.size, this.item, this.total, this.cREF, this.cVEHINM})
      : super(key: key);

  final Size size;
  final int item;
  final double total;
  final String cREF;
  final GetVehicleResp cVEHINM;

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(new DateTime.now());
    final formatNum = new NumberFormat("#,###.##", "en_US");
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              outputDate,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'No. $cREF',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black38,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DottedLine(
                    lineThickness: 2.0,
                    dashColor: Colors.black38,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    //color: HexColor("#F2F3F4"),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: Container(
                              //color: Colors.amber,
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                image: cVEHINM.cPHOTOPATH != ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${cVEHINM.cPHOTOSERV}/${cVEHINM.cPHOTOPATH}',
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: new AssetImage(
                                          "assets/images/no_image.png",
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                right: 5.0,
                                bottom: 5.0,
                                left: 10.0,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cVEHINM.cVEHINM ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${formatNum.format(item)} รายการ',
                                            style: TextStyle(
                                              fontFamily: 'Prompt',
                                              color: Colors.black,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Container(
                                          child: Text(
                                            '${formatNum.format(item)} ตระกร้า',
                                            style: TextStyle(
                                              fontFamily: 'Prompt',
                                              color: Colors.black,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 2,
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'ส่วนลดสินค้า',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          child: SubstringPrice(
                            '0.00',
                            14.0,
                            14.0,
                            Colors.black38,
                            Colors.black38,
                            'Prompt',
                            'Prompt',
                            FontWeight.normal,
                            FontWeight.normal,
                            'บาท',
                            14.0,
                            Colors.black38,
                            'Prompt',
                            FontWeight.normal,
                            FontStyle.normal,
                            FontStyle.normal,
                            FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width / 2,
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'ส่วนลดท้ายบิล',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black38,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                            Container(
                              child: SubstringPrice(
                                '0.00',
                                14.0,
                                14.0,
                                Colors.black38,
                                Colors.black38,
                                'Prompt',
                                'Prompt',
                                FontWeight.normal,
                                FontWeight.normal,
                                'บาท',
                                14.0,
                                Colors.black38,
                                'Prompt',
                                FontWeight.normal,
                                FontStyle.normal,
                                FontStyle.normal,
                                FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: SubstringPrice(
                            '$total',
                            14.0,
                            12.0,
                            Colors.orange,
                            Colors.orange,
                            'Prompt',
                            'Prompt',
                            FontWeight.bold,
                            FontWeight.bold,
                            'THB',
                            12.0,
                            Colors.black38,
                            'Prompt',
                            FontWeight.bold,
                            FontStyle.normal,
                            FontStyle.normal,
                            FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  DottedLine(
                    lineThickness: 2.0,
                    dashColor: Colors.black38,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
