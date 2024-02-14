import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/screens/confirm_page2.dart';


class RefuelAdd extends StatefulWidget {
  //const RefuelAdd({ Key? key }) : super(key: key);
  final String typeMenuCode;
  RefuelAdd(this.typeMenuCode);
  @override
  _RefuelAddState createState() => _RefuelAddState();
}

class _RefuelAddState extends State<RefuelAdd> {
  String Code = "";
  String Name = "";
  String Code1 = "";
  String Name1 = "";
  String total = '1200.00';
  final formatNum = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: HexColor('#6c7e9b'),
              height: 80.0,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: FlatButton(
                        color: HexColor('#6c7e9b'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AppbarPage(4.toString(), widget.typeMenuCode),
                            ),
                          );
                        },
                        child: Container(
                          height: 40.0,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.map_marker,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '123 แขวง/ตำบล เขต/อำเภอ จังหวัด ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 50.0,
                    margin: const EdgeInsets.only(
                        top: 5.0, right: 5.0, bottom: 5.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        width: 50.0,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(150),
                          border: new Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(LineAwesomeIcons.edit),
                            iconSize: 20.0,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      4.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      //color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.amber,
                            alignment: Alignment.center,
                            width: 100.0,
                            child: Container(),
                          ),
                          Expanded(
                            child: imageFile != null
                                ? /*Container(
                            child: Image.file(
                              _image,
                              width: 50,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )*/
                                Container(
                                    alignment: Alignment.center,
                                    //color: Colors.pink,
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          //color: Colors.pink,
                                          //padding: const EdgeInsets.all(3.0),
                                          alignment: Alignment.center,
                                          height: 140,
                                          width: 140,
                                          /*decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(270.0),
                                  ),*/
                                          child: CircleAvatar(
                                            backgroundImage:
                                                new FileImage(_image),
                                            radius: 150.0,
                                          ),
                                        ),
                                        Align(
                                          child: SizedBox(
                                            height: 150.0,
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: IconButton(
                                                icon: Icon(
                                                  LineAwesomeIcons.camera,
                                                  color: Colors.white,
                                                ),
                                                iconSize: 40,
                                                onPressed: () {
                                                  actionsheet(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    //color: Colors.pink,
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          //padding: const EdgeInsets.all(3.0),
                                          alignment: Alignment.center,
                                          height: 140,
                                          width: 140,
                                          /*decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(270.0),
                                  ),*/
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/brandon.png'),
                                            radius: 150.0,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        Align(
                                          child: SizedBox(
                                            height: 150.0,
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: IconButton(
                                                icon: Icon(
                                                  LineAwesomeIcons.camera,
                                                  color: Colors.white,
                                                ),
                                                iconSize: 40,
                                                onPressed: () {
                                                  actionsheet(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          Container(
                            //color: Colors.amber,
                            alignment: Alignment.center,
                            width: 100.0,
                            // padding: const EdgeInsets.only(right: 20.0),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    //------------------
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'สถานที่เติม',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.centerLeft,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: InkWell(
                              onTap: () {
                                refuelChoice(context);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Code == "" ? 'บีพี หาดใหญ่' : Name,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(LineAwesomeIcons.list),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //---------------------
                    Container(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'เชื้อเพลิง',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              fuelChoice(context);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              alignment: Alignment.centerLeft,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        Code1 == ""
                                                            ? 'เบนซิน'
                                                            : Name1,
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          LineAwesomeIcons
                                                              .angle_down,
                                                          size: 15.0,
                                                        ),
                                                      ),
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
                                  //-------------------------
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'เลขไมล์ปัจจุบัน',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Theme(
                                              data: new ThemeData(
                                                primaryColor: Colors.grey,
                                                //primaryColorDark: Colors.grey,
                                              ),
                                              child: new TextFormField(
                                                maxLength: 7,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Colors.grey,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration: new InputDecoration(
                                                  /*border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey),R
                                        ),*/
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                    //---------------------
                    Container(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'ระยะทาง (Km)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Theme(
                                              data: new ThemeData(
                                                primaryColor: Colors.grey,
                                                //primaryColorDark: Colors.grey,
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '400',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: 'Prompt',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //-------------------------
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'สิ้นเปลือง กม/ล.',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Theme(
                                              data: new ThemeData(
                                                primaryColor: Colors.grey,
                                                //primaryColorDark: Colors.grey,
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '10.5',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: 'Prompt',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                    //-------------------------------------
                    Container(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'จำนวนลิตร',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Theme(
                                              data: new ThemeData(
                                                primaryColor: Colors.grey,
                                                //primaryColorDark: Colors.grey,
                                              ),
                                              child: new TextFormField(
                                                maxLength: 7,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Colors.grey,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration: new InputDecoration(
                                                  /*border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey),R
                                        ),*/
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //-------------------------
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'ราคาลิตรละ',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Theme(
                                              data: new ThemeData(
                                                primaryColor: Colors.grey,
                                                //primaryColorDark: Colors.grey,
                                              ),
                                              child: new TextFormField(
                                                maxLength: 7,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Colors.grey,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration: new InputDecoration(
                                                  /*border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey),R
                                        ),*/
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'ราคารวม',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            child: Text(''),
                                          ),
                                        ],
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
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 120.0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
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
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ราคารวม',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: substring(total),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'โปรดตรวจสอบราคารวม',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 35.0,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: 1 / 2,
                        child: Icon(
                          LineAwesomeIcons.check_circle,
                          color: Colors.green,
                          size: 25.0,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ConfirmPage2(widget.typeMenuCode),
                            ),
                          );
                        },
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
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

  actionsheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Prompt',
                fontSize: 16.0,
              ),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _openCamera();
                Navigator.of(context).pop();
              },
              child: Text(
                'ถ่ายรูป',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Prompt',
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _openGallary();
                Navigator.of(context).pop();
              },
              child: Text(
                'เลือกรูปภาพ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Prompt',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  PickedFile imageFile;
  File _image;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
    });
  }

  Future<void> _openGallary() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, maxHeight: 200.0, maxWidth: 200.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
    });
  }

  refuelChoice(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "001";
                  Name = "สาขา1 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา1 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "002";
                  Name = "สาขา2 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา2 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "003";
                  Name = "สาขา3 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา3 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "004";
                  Name = "สาขา4 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา4 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "005";
                  Name = "สาขา5 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา5 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code = "006";
                  Name = "สาขา5 สงขลา";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'สาขา5 สงขลา',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  fuelChoice(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code1 = "001";
                  Name1 = "ดีเซล";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'ดีเซล',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  Code1 = "002";
                  Name1 = "เบนซิน";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'เบนซิน',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  substring(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];
    var aa = RichText(
      text: TextSpan(
        text: '${formatNum.format(int.parse(bb))}',
        style: TextStyle(
          fontSize: 16,
          color: HexColor('#fc971e'),
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: '฿',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
