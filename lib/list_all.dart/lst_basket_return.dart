import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';

class ListBasketReturn extends StatefulWidget {
  //const ListBasketReturn({ Key? key }) : super(key: key);

  @override
  _ListBasketReturnState createState() => _ListBasketReturnState();
}

class _ListBasketReturnState extends State<ListBasketReturn> {
  var menus = [
    {
      "image": "assets/images/Product1.png",
      "name": "ตระกร้า1",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "มัดจำใบละ",
      "price": "1800.00",
      "price1": "100.00",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "ตระกร้า2",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "price1": "",
    },
    {
      "image": "assets/images/Product3.png",
      "name": "ตระกร้า3",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "price1": "",
    },
    {
      "image": "assets/images/Product4.png",
      "name": "ตระกร้า4",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "price1": "",
    },
    {
      "image": "assets/images/Product1.png",
      "name": "ตระกร้า5",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "price1": "",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า6",
      "remaining": "ยอดค้าง",
      "increase": "เพิ่ม",
      "collect": "เก็บ",
      "balance": "คงค้าง",
      "promo": "* ลด 10 บาท แถม 1 ชิ้น",
      "price": "100.00",
      "price1": "",
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
                      margin: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        menus[index]['image']!,
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
                                        menus[index]['name']!,
                                        style: TextStyle(
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
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
                                        menus[index]['remaining']!,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        menus[index]['increase']!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        menus[index]['collect']!,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        menus[index]['balance']!,
                                        style: TextStyle(
                                          color: Colors.blue,
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
                                        color: Colors.grey,
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
                                        initialValue: '20',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
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
                                        initialValue: '2',
                                        style: TextStyle(
                                          color: Colors.red,
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
                                        initialValue: '0',
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
                                        color: Colors.grey,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    menus[index]['name'] == 'ตระกร้า1'
                        ? Expanded(
                            child: Text(
                              menus[index]['promo']!,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          )
                        : Container(),
                    menus[index]['name'] == 'ตระกร้า1'
                        ? Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SubstringPrice(
                                menus[index]['price1'],
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
                          )
                        : Container(),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              //-------------5
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    menus[index]['name'] == 'ตระกร้า1'
                        ? Expanded(
                            child: Container(),
                          )
                        : Expanded(
                            child: Text(
                              menus[index]['promo']!,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
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
}
