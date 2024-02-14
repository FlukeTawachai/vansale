import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListReOrder extends StatefulWidget {
  //const ListReOrder({ Key? key }) : super(key: key);

  @override
  _ListReOrderState createState() => _ListReOrderState();
}

class _ListReOrderState extends State<ListReOrder> {
  var reorder = [
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า1",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "1800.00",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า2",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product3.png",
      "name": "สินค้า3",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product4.png",
      "name": "สินค้า4",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า5",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า6",
      "total": "200 หีบ",
      "down": "ลด",
      "up": "เพิ่ม",
      "order": "ยอดสั่ง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: reorder.length,
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
                        reorder[index]['image'],
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
                                        reorder[index]['name'],
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      child: reorder[index]['promo'] != ""
                                          ? Text(
                                              reorder[index]['total'],
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            )
                                          : Text(
                                              reorder[index]['total'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: reorder[index]['promo'] != ""
                                          ? Text(
                                              reorder[index]['down'],
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            )
                                          : Text(
                                              reorder[index]['down'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: reorder[index]['promo'] != ""
                                          ? Text(
                                              reorder[index]['up'],
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            )
                                          : Text(
                                              reorder[index]['up'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: reorder[index]['promo'] != ""
                                          ? Text(
                                              reorder[index]['order'],
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
                                              ),
                                            )
                                          : Text(
                                              reorder[index]['order'],
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12.0,
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
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: TextFormField(
                                        readOnly: true,
                                        textAlign: TextAlign.center,
                                        initialValue: '200',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                          fontSize: 14.0,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          /*contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),*/
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
                                        initialValue: '2',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Prompt',
                                          fontSize: 14.0,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          /*contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),*/
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
                                        initialValue: '0',
                                        style: TextStyle(
                                          color: HexColor('#00cb39'),
                                          fontFamily: 'Prompt',
                                          fontSize: 14.0,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          /*contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),*/
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
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: TextFormField(
                                        readOnly: true,
                                        textAlign: TextAlign.center,
                                        initialValue: '18',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                          fontSize: 14.0,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          /*contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 15,
                                              right: 15),*/
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
                      child: Text(
                        reorder[index]['promo'],
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 150.0,
                      child: Text(
                        reorder[index]['price'] + " " + "฿",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
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
}
