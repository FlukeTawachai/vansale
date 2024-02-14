import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/list_all.dart/lst_order.dart';
import 'package:vansale/screens/customer/customer_confirm_order.dart';

class Order extends StatefulWidget {
  final String typeMenuCode;
  Order(this.typeMenuCode);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String total = '3200.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'สั่งซื้อ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: Container(),
        /*IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),*/
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Prompt',
                          ),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "ค้นหาสินค้า",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 5.0, top: 5.0),
                            prefixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: HexColor('#6c7e9b'),
                                ),
                                onPressed: () {},
                                iconSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: IconButton(
                          icon: const Icon(Icons.qr_code),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              //color: Colors.amber,
              color: HexColor('#6c7e9b'),
              height: 40.0,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0.0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.black12,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              'ประเภท',
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
                    ),
                    //---------------
                    Expanded(
                      child: Card(
                        elevation: 0.0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.black12,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              'หมวดหลัก',
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
                    ),
                    //---------------
                    Expanded(
                      child: Card(
                        elevation: 0.0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.black12,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              'หมวดย่อย',
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
                    ),
                    //---------------
                    Expanded(
                      child: Card(
                        elevation: 0.0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.black12,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              'แบรนด์',
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
                    ),
                    //-------------------
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListOrder("New"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 160.0,
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
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'จำนวนสินค้า',
                        style: TextStyle(
                          fontSize: 12.0,
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
                      child: Text(
                        '32 ชิ้น',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'ราคาสินค้า',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                  /*Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '3200.00' + " " + "฿",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: HexColor('#fc971e'),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ),*/
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SubstringPrice(
                        total,
                        12.0,
                        10.0,
                        Colors.black,
                        Colors.black,
                        'Prompt',
                        'Prompt',
                        FontWeight.bold,
                        FontWeight.bold,
                        '',
                        10.0,
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
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'มัดจำ (ตระกร้า)',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                  /*Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '3200.00' + " " + "฿",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: HexColor('#fc971e'),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ),*/
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SubstringPrice(
                        '500.00',
                        12.0,
                        10.0,
                        Colors.black,
                        Colors.black,
                        'Prompt',
                        'Prompt',
                        FontWeight.bold,
                        FontWeight.bold,
                        '',
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
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'ราคารวม',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                  /*Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '3200.00' + " " + "฿",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: HexColor('#fc971e'),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ),*/
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SubstringPrice(
                        '3700.00',
                        14.0,
                        12.0,
                        Colors.orange,
                        Colors.orange,
                        'Prompt',
                        'Prompt',
                        FontWeight.bold,
                        FontWeight.bold,
                        '฿',
                        12.0,
                        Colors.orange,
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
            //--------------
            Expanded(
              child: Card(
                elevation: 0.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ConfirmOrder(widget.typeMenuCode),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  LineAwesomeIcons.box,
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
                                  'ยืนยันสั่งซื้อ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: HexColor('#00cb39'),
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
                    //--------------
                    /*Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoreItem(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'สินค้าไม่เคยสั่ง',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: HexColor('#00cb39'),
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
