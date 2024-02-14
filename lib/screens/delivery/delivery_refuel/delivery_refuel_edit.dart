import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addRefuelReq.dart';
import 'package:vansale/api/class/response/routeMobile/searchRefuelResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';

class DeliveryRefuelEdit extends StatefulWidget {
  final String typeMenuCode;
  DeliveryRefuelEdit(this.typeMenuCode);

  @override
  State<DeliveryRefuelEdit> createState() => _DeliveryRefuelEditState();
}

class _DeliveryRefuelEditState extends State<DeliveryRefuelEdit> {
  TextEditingController locationName = TextEditingController();
  TextEditingController mile = TextEditingController();
  TextEditingController distance = TextEditingController(text: '0');
  TextEditingController rate = TextEditingController(text: '0');
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController totalprice = TextEditingController(text: '0');
  String dropdownFuel = 'ดีเซล';
  SearchRefuelResp refuelHis;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (GlobalParam.refuelList.length > 0) {
      mile.text =
          '${double.parse(GlobalParam.refuelList[0].iMILEAGE).toStringAsFixed(0)}';
      refuelHis = GlobalParam.refuelList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('บันทึกการเติมน้ำมัน'),
      ),
      backgroundColor: HexColor("#F2F3F4"),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                // Container(
                //   height: 70.0,
                //   alignment: Alignment.center,
                //   color: HexColor("#8291a9"),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: location_(),
                //       ),
                //       Container(
                //         child: btnEdit_(),
                //       ),
                //     ],
                //   ),
                // ),
                Column(
                  children: [
                    // Stack(
                    //   children: [
                    //     picProfile_(),
                    //     countImage_(),
                    //     btnCamera_(),
                    //   ],
                    // ),
                    locationName_(),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: fuel_(),
                          ),
                          Expanded(
                            child: mile_(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: distance_(),
                          ),
                          Expanded(
                            child: rate_(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: qty_(),
                          ),
                          Expanded(
                            child: price_(),
                          ),
                          Expanded(
                            child: totalprice_(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buttonBar_(),
      resizeToAvoidBottomInset: true,
    );
  }

  //Widget ......
  Widget location_() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            width: 30.0,
            child: Icon(
              LineAwesomeIcons.map_marker,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: AutoSizeText(
              'data',
              minFontSize: 10.0,
              maxFontSize: 16.0,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnEdit_() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: HexColor("#a5b4c7"),
          shape: CircleBorder(),
        ),
        child: Icon(
          LineAwesomeIcons.edit,
          color: Colors.white,
          size: 25.0,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget picProfile_() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(150.0),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/Image.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget countImage_() {
    return Positioned(
      top: 40.0,
      right: 105.0,
      child: Container(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
          ),
          child: Text(
            '5+',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget btnCamera_() {
    return Positioned(
      top: 40.0,
      right: 5.0,
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: HexColor("#a5b4c7"),
            shape: CircleBorder(),
          ),
          child: Container(
            height: 40.0,
            child: Icon(
              LineAwesomeIcons.camera,
              color: Colors.black,
              size: 25.0,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget locationName_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สถานที่เติม',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green,
              ),
              controller: locationName,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fuel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เชื้อเพลิง',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            height: 52.0,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownFuel,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Prompt",
                    color: Colors.green,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownFuel = newValue;
                    });
                  },
                  items: <String>['ดีเซล', 'เบนซิน']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mile_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลขไมล์',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
              ),
              controller: mile,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
              onChanged: (value) {
                if (value != '' && value != null) {
                  double milage = double.parse(value);
                  setState(() {
                    distance.text =
                        '${milage - double.parse(refuelHis.iMILEAGE)}';
                    if (double.parse(refuelHis.iLITER) > 0) {
                      rate.text =
                          '${double.parse('${milage - double.parse(refuelHis.iMILEAGE)}') / double.parse(refuelHis.iLITER)}';
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget distance_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ระยะทาง (Km)',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              readOnly: true,
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: distance,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rate_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สิ้นเปลือง กม/ล.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: TextFormField(
              readOnly: true,
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: rate,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qty_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'จำนวนลิตร',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
              ),
              controller: qty,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
              onChanged: (value) {
                if (value != '' && value != null) {
                  double liter = double.parse(value);
                  setState(() {
                    if (price.text == '') {
                      totalprice.text = '0';
                    } else {
                      totalprice.text =
                          '${double.parse('${liter * double.parse(price.text)}')}';
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget price_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ราคาลิตรละ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              controller: price,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
              onChanged: (value) {
                if (value != '' && value != null) {
                  double liter = double.parse(value);
                  setState(() {
                    if (qty.text == '') {
                      totalprice.text = '0';
                    } else {
                      totalprice.text =
                          '${double.parse('${liter * double.parse(qty.text)}')}';
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget totalprice_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ราคารวม',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              enabled: false,
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: totalprice,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonBar_() {
    return Container(
      height: 130.0,
      decoration: BoxDecoration(
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
      ),
      child: ListView(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      'ราคารวม',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                    alignment: Alignment.centerRight,
                    child: Utility.formateNumberOrangeSym(
                        double.parse(totalprice.text)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20.0, top: 10.0),
            alignment: Alignment.centerRight,
            child: Text(
              'โปรดตรวจสอบราคารวม',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.white,
            child: Container(
              child: InkWell(
                onTap: () {
                  addRefuel(AddRefuelReq(
                    cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                    cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
                    cVEHINM: GlobalParam.VEHICLE['cVEHINM'],
                    cLOCATION: locationName.text,
                    cFUELNM: dropdownFuel,
                    iMILEAGE: double.parse(mile.text),
                    iKM: double.parse(distance.text),
                    iFUELRATE: double.parse(rate.text),
                    iLITER: double.parse(qty.text),
                    iPRICE: double.parse(price.text),
                    cPLATE: GlobalParam.VEHICLE['cPLATE'],
                    cPROVINCE: GlobalParam.VEHICLE['cPPROVINCE'],
                    cREFDOC: GlobalParam.refuelRff,
                    cCREABY: GlobalParam.userID,
                  ));
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: RotationTransition(
                                turns: new AlwaysStoppedAnimation(0 / 360),
                                child: Icon(
                                  LineAwesomeIcons.check_circle,
                                  size: 25.0,
                                  color: HexColor('#00cb39'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              //alignment: Alignment.centerLeft,
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: HexColor('#00cb39'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   child: Divider(
                      //     height: 5.0,
                      //     indent: 150.0,
                      //     endIndent: 150.0,
                      //     thickness: 2.0,
                      //     color: HexColor('#00cb39'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addRefuel(AddRefuelReq req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addRefuel(req);
      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ConfirmPage(
                widget.typeMenuCode, 'บันทึกการเติมน้ำมัน', 'เรียบร้อยแล้ว'),
          ),
        );
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
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
