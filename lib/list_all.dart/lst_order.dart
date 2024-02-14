import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';

class ListOrder extends StatefulWidget {
  final String mode;
  ListOrder(this.mode);
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  var order = [
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า1",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า2",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
    {
      "image": "assets/images/Product3.png",
      "name": "สินค้า3",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
    {
      "image": "assets/images/Product4.png",
      "name": "สินค้า4",
      "uom1": "10 หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า5",
      "uom1": "หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า6",
      "uom1": "หีบ",
      "uom2": "12 ห่อ",
      "uom3": "1 ชิ้น",
      "promo": "",
      "price": "100.00",
      "orderno": "No.630626-xxxxxxx",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: order.length,
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
                      margin: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        order[index]['image'],
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 150.0,
                      ),
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
                                        order[index]['name'],
                                        style: TextStyle(
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                      iconSize: 30.0,
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                            //--------------------2
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.mode == "View"
                                      ? Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              order[index]['uom1'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.centerLeft,
                                            child: order[index]['promo'] != ""
                                                ? Text(
                                                    order[index]['uom1'],
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  )
                                                : Text(
                                                    order[index]['uom1'],
                                                    style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                  widget.mode == "View"
                                      ? Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              order[index]['uom2'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: order[index]['promo'] != ""
                                                ? Text(
                                                    order[index]['uom2'],
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  )
                                                : Text(
                                                    order[index]['uom2'],
                                                    style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                  widget.mode == "View"
                                      ? Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              order[index]['uom3'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: order[index]['promo'] != ""
                                                ? Text(
                                                    order[index]['uom3'],
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  )
                                                : Text(
                                                    order[index]['uom3'],
                                                    style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            //----------------------------3
                            widget.mode == "View"
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      order[index]['orderno'],
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                disabledBorder:
                                                    InputBorder.none,
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
                                                disabledBorder:
                                                    InputBorder.none,
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
                                                disabledBorder:
                                                    InputBorder.none,
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
                    widget.mode == "View"
                        ? Expanded(
                            child: Container(),
                          )
                        : Expanded(
                            child: Text(
                              order[index]['promo'],
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                    Container(
                        alignment: Alignment.centerRight,
                        width: 150.0,
                        child: SubstringPrice(
                          order[index]['price'].toString(),
                          14.0,
                          12.0,
                          Colors.black,
                          Colors.black,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          '฿',
                          12.0,
                          Colors.black,
                          'Prompt',
                          FontWeight.bold,
                          FontStyle.normal,
                          FontStyle.normal,
                          FontStyle.normal,
                        )),
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
}
