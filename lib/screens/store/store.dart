import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';

class Store extends StatefulWidget {
  final String typeMenuCode;
  Store(this.typeMenuCode);
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  // bool _edit = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //color: Colors.amber,
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
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: const Icon(LineAwesomeIcons.crosshairs),
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
                                    backgroundImage: new FileImage(_image),
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
                                    backgroundImage:
                                        AssetImage('assets/images/brandon.png'),
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
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50.0,
                      width: 50.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: HexColor('#c8c9c9'),
                        borderRadius: BorderRadius.circular(150),
                        border: new Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: const Icon(LineAwesomeIcons.edit),
                          iconSize: 20.0,
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                //alignment: Alignment.center,
                color: HexColor("#F2F3F4"),
                //height: MediaQuery.of(context).size.height / 2.8,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'ชื่อร้านค้า',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              //readOnly: _edit,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'เลขประจำตัวผู้เสียภาษี',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'ที่อยู่',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          color: Colors.white,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              //maxLines: 1,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal),
                                ),

                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'ที่จัดส่ง',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              //maxLines: 1,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal),
                                ),

                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'จังหวัด',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      8.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เลือกจังหวัด",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'เขต/อำเภอ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      10.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เลือกเขต/อำเภอ",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'แขวง/ตำบล',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      9.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เลือกแขวง/ตำบล",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'รหัสไปรษณีย์',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15.0),
                          height: 40.0,
                          color: HexColor('#c8c9c9'),
                          child: Text(
                            '12345',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'โลเคชั่น',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      4.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: [
                                  Container(
                                    width: 30.0,
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      LineAwesomeIcons.map_marker,
                                      color: Colors.grey,
                                      size: 25.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '123 แขวง/ตำบล เขต/อำเภอ จังหวัด ',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30.0,
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'เบอร์โทร',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'ผู้ติดต่อ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'เบอร์ติดต่อ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'ไลน์',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 40.0,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                            ),
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                /*hintText: 'Tell us about yourself',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: 'Life story',*/
                                /* prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  prefixText: ' ',
                                  suffixText: 'USD',
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: HexColor("#FFFFFF"),
              height: 60.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35.0,
                                alignment: Alignment.center,
                                child: Icon(
                                  LineAwesomeIcons.times_circle,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ConfirmPage(widget.typeMenuCode, '', ''),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35.0,
                                alignment: Alignment.center,
                                child: Icon(
                                  LineAwesomeIcons.check_circle,
                                  color: Colors.green,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'บันทึก',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                            ],
                          ),
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
}
