import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';

class ListProductReturn extends StatefulWidget {
  //const ListProductReturn({ Key? key }) : super(key: key);

  @override
  _ListProductReturnState createState() => _ListProductReturnState();
}

class _ListProductReturnState extends State<ListProductReturn> {
  var menus = [
    {
      "name": "สินค้า1",
      "type": "สินค้าดี",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
    {
      "name": "สินค้า2",
      "type": "สินค้าเสีย",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
    {
      "name": "สินค้า3",
      "type": "",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
    {
      "name": "สินค้า4",
      "type": "",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
    {
      "name": "สินค้า5",
      "type": "",
      "uom1": "หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
    {
      "name": "สินค้า6",
      "type": "",
      "uom1": "หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "price": "-100.00",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: HexColor("#F2F3F4"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 110.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                      width: 100.0,
                      height: 150.0,
                      margin: const EdgeInsets.all(5.0),
                      child: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            LineAwesomeIcons.camera,
                            size: 80.0,
                          ),
                          onPressed: () {
                            _openCamera();
                          }),
                    ),
                    //----------------------1
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        menus[index]['name'],
                                        style: TextStyle(
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: checkType(index),
                                      child: Text(menus[index]['type'],
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            //--------------------2
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          menus[index]['uom1'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Prompt',
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        menus[index]['uom2'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        menus[index]['uom3'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //----------------------------3
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      height: 30.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        initialValue: '1',
                                        style: TextStyle(
                                          color: HexColor('#00cb39'),
                                          fontFamily: 'Prompt',
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      height: 30.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        initialValue: '1',
                                        style: TextStyle(
                                          color: HexColor('#00cb39'),
                                          fontFamily: 'Prompt',
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      height: 30.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        initialValue: '1',
                                        style: TextStyle(
                                          color: HexColor('#00cb39'),
                                          fontFamily: 'Prompt',
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),
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
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150.0,
                        child: SubstringPrice(
                          menus[index]['price'],
                          18.0,
                          14.0,
                          Colors.black,
                          Colors.black,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          '฿',
                          14.0,
                          Colors.black,
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
              ),
              DottedLine(
                dashColor: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }

  checkType(index) {
    switch (menus[index]['name']) {
      case 'สินค้า1':
        return Colors.green;
        break;
      case 'สินค้า2':
        return Colors.red;
        break;
      default:
        return Colors.transparent;
    }
  }

  PickedFile imageFile;
  File image_;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    setState(() {
      imageFile = image;
      image_ = File(imageFile.path);
    });
  }
}
