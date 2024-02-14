import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_main.dart';

class DeliveryMoneyNew extends StatefulWidget {
  final String typeMenuCode;
  const DeliveryMoneyNew(this.typeMenuCode, {super.key});
  @override
  State<DeliveryMoneyNew> createState() => _DeliveryMoneyNewState();
}

class _DeliveryMoneyNewState extends State<DeliveryMoneyNew> {
  String dropdownName = 'ค่าซ่อมรถ';
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController remark = TextEditingController();
  late PickedFile imageFile;
  // final ImagePicker _picker = ImagePicker();
  late File file;
  bool imgIsNull = true;
  late File _image;
  String base64 = '';
  String costName = '';
  double cost = 0;
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ส่งเงิน - บันทึกค่าใช้จ่าย'),
      ),
      body: Column(
        children: [
          _name(),
          _price(),
          showImage(),
          _remark(),
        ],
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  Widget _name() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'จ่ายค่า',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(color: Colors.grey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16,
                    ),
                    controller: name,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        costName = value;
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _price() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'จำนวนเงิน',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(color: Colors.grey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16,
                    ),
                    controller: price,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value != '' && value != null) {
                        setState(() {
                          cost = double.parse(value);
                        });
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remark() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'หมายเหตุ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(color: Colors.grey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                  maxLength: 100,
                  scrollPadding: const EdgeInsets.only(bottom: 40),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: remark,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 11, top: 15, right: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnSave() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 80.0,
      color: Colors.white,
      /*decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),*/
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  GlobalParam.deliveryAddSendMoney.cCOSNM = '';
                  GlobalParam.deliveryAddSendMoney.iCOST = 0;
                  GlobalParam.deliveryAddSendMoney.cREMARK = '';
                  GlobalParam.deliveryAddSendMoney.cCOSTPH = '';
                  if (costName == '') {
                    // wrongDialog('กรุณาระบุจ่ายค่า');

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeliveryMoneyMain(
                            GlobalParam.typeMenuCode ?? '', false)));
                  } else {
                    if (cost == 0) {
                      wrongDialog('กรุณาระบุจำนวนเงิน');
                    } else {
                      if (base64 == '' || base64 == null) {
                        wrongDialog('กรุณาถ่ายรูปหลักฐานจ่ายเงิน');
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DeliveryMoneyMain(
                                GlobalParam.typeMenuCode ?? '', true)));
                        GlobalParam.deliveryAddSendMoney.cCOSNM = costName;
                        GlobalParam.deliveryAddSendMoney.iCOST = cost;
                        GlobalParam.deliveryAddSendMoney.cREMARK = comment;
                        GlobalParam.deliveryAddSendMoney.cCOSTPH = base64;
                      }
                    }
                  }
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icvp.check_circle_solid,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                        /*child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(30 / 360),
                          
                        ),*/
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'บันทึกค่าใช้จ่าย',
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
              // SizedBox(
              //   child: Divider(
              //     height: 5.0,
              //     indent: 105.0,
              //     endIndent: 100.0,
              //     thickness: 2.0,
              //     color: HexColor('#00cb39'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showImage() {
    return SizedBox(
      height: 224,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30.0),
            alignment: Alignment.topLeft,
            child: const Text(
              'บันทึกภาพถ่าย',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            alignment: Alignment.topCenter,
            child: FDottedLine(
                color: Colors.grey[600],
                strokeWidth: 2.0,
                dottedLength: 10.0,
                space: 2.0,
                child: imageFile != null
                    ? Container(
                        width: 500.0,
                        height: 300.0,
                        alignment: Alignment.center,
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {
                            openCamera();
                          },
                          child: SizedBox(
                            width: 500,
                            height: 300,
                            child: Image.file(
                              File(_image.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 500.0,
                        height: 300.0,
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {
                            openCamera();
                          },
                          child: const Icon(
                            LineAwesomeIcons.camera,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                      )),
          ),
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       "*กรุณาถ่ายภาพ",
          //       style: TextStyle(
          //         fontSize: 14.0,
          //         color: Colors.white,
          //         //fontWeight: FontWeight.bold,
          //         fontFamily: 'Prompt',
          //       ),
          //     ),
          //   ),
          // ),
        ],
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
      base64 = img64;
      // print(img64.substring(0, 100));
      //EasyLoading.dismiss();
      // saveData();
      imgIsNull = false;
    });
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
}
