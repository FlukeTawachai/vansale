import 'dart:convert';
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/searchRefuelReq.dart';
import 'package:vansale/api/class/request/mobile/startStopWorkReq.dart';
import 'package:vansale/api/class/response/routeMobile/addSendMoneyReq.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/Supplier/Pay/storeName.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_DTbody.dart';

class DeliveryMoneyDetail extends StatefulWidget {
  final VoidCallback navigated;
  DeliveryMoneyDetail(this.navigated);

  @override
  State<DeliveryMoneyDetail> createState() => _DeliveryMoneyDetailState();
}

class _DeliveryMoneyDetailState extends State<DeliveryMoneyDetail> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String newDate = DateFormat('dd-MM-yy HH:mm').format(DateTime.now());
  late PickedFile imageFile;
  // final ImagePicker _picker = ImagePicker();
  late File file;
  bool imgIsNull = true;
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: const Text(
          'รับชำระโอน',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
        actions: [
          Row(
            children: [
              Container(
                child: IconButton(
                  icon: const Icon(
                    Icons.print,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              // Container(
              //   child: IconButton(
              //     icon: Icon(
              //       Icons.more_vert,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       setState(
              //         () {
              //           Navigator.of(context).pop(
              //             MaterialPageRoute(
              //               builder: (context) => SendMoney(),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        // width: 414.0,
        // height: 312.0,
        child: Container(
          // width: 350,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                // height: 48,
                child: label1(),
              ),
              const SizedBox(
                height: 10,
              ),
              const DottedLine(
                dashColor: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(
                child: SizedBox(
                  height: 280.0,
                  child: MoneyDetailBody(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          openCamera();
        },
        child: SizedBox(
          height: 64,
          child: savebutton(),
        ),
      ),
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

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  Widget _dateHD() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        yearThai(),
        style: const TextStyle(
          fontFamily: 'Prompt',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget label1() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateHD(),
          Container(
            child: Text(
              'No.$newDate',
              style: const TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget savebutton() {
    return Container(
      color: Colors.white,
      height: 85.0,
      child: Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40.0,
                width: 190,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: HexColor('#00cb39'),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //alignment: Alignment.centerRight,
                      child: Icon(
                        FontAwesomeIcons.checkCircle,
                        size: 20.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                    Container(
                      //alignment: Alignment.centerLeft,
                      child: Text(
                        '  บันทึกการชำระ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: HexColor('#00cb39'),
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
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
    );
  }

  Future<void> openCamera() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image!;
      _image = File(imageFile.path);

      final bytes = File(imageFile.path).readAsBytesSync();

      String img64 = base64Encode(bytes);
      GlobalParam.deliveryAddSendMoney.cBILLPH = img64;
      GlobalParam.deliveryAddSendMoney.cSERVER = '27.254.207.240:11110';
      GlobalParam.deliveryAddSendMoney.cCREABY = GlobalParam.userID;
      // print(img64.substring(0, 100));
      //EasyLoading.dismiss();
      // saveData();
      GlobalParam.deliveryAddSendMoney.cCOSTPH ??= '';
      if (GlobalParam.deliveryAddSendMoney.cCOSNM == null) {
        GlobalParam.deliveryAddSendMoney.cCOSNM = '';
      }
      if (GlobalParam.deliveryAddSendMoney.cREMARK == null) {
        GlobalParam.deliveryAddSendMoney.cREMARK = '';
      }
      // print(GlobalParam.deliveryAddSendMoney.cBRANCD);
      // print(GlobalParam.deliveryAddSendMoney.cGRPCD);
      // print(GlobalParam.deliveryAddSendMoney.cRTECD);
      // print(GlobalParam.deliveryAddSendMoney.cVEHICD);
      // print(GlobalParam.deliveryAddSendMoney.cDRIVER);
      // print(GlobalParam.deliveryAddSendMoney.iTOTAL);
      // print(GlobalParam.deliveryAddSendMoney.iCOST);
      // print(GlobalParam.deliveryAddSendMoney.cBILLPH.substring(0, 100));
      // print(GlobalParam.deliveryAddSendMoney.cCOSTPH);
      // print(GlobalParam.deliveryAddSendMoney.cCOSNM);
      // print(GlobalParam.deliveryAddSendMoney.cREMARK);
      // print(GlobalParam.deliveryAddSendMoney.cCREABY);
      // print(GlobalParam.deliveryAddSendMoney.cSERVER);

      addSendMoney(GlobalParam.deliveryAddSendMoney);
    });
  }

  addSendMoney(AddSendMoneyReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addSendMoney(req);
      if (result.success == false) {
        wrongDialog(result.message);
      } else {
        startStopWork();
      }
      // setState(() {});
      widget.navigated();
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  startStopWork() async {
    // if (cVEHINM == '') {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();
      String section = '';
      if (GlobalParam.typeMenuCode == 'T001') {
        section = 'TF';
      }
      if (GlobalParam.typeMenuCode == 'T002') {
        section = 'SL';
      }
      if (GlobalParam.typeMenuCode == 'T004') {
        section = 'ST';
      }

      var result = await proxy.startStopWork(StartStopWorkReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cREFCD: GlobalParam.VEHICLE['cVEHICD'],
        cUSRNM: GlobalParam.userData.cUSRNM,
        cSTATUS: "N",
        cSECTION: section,
        cCREABY: GlobalParam.userData.cUSRNM,
      ));
      // if (result.success == true) {
      //   wrongDialog('บันทึกเวลาเลิกงานสำเร็จ');
      // }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    // } else {
    //   wrongDialog('ข้อมูลผิดพลาด');
    // }
  }
}
