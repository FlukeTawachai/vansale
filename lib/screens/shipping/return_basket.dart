import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/list_all.dart/lst_basket_return.dart';

class ReturnBasket extends StatefulWidget {
  //const ReturnBasket({ Key? key }) : super(key: key);

  @override
  _ReturnBasketState createState() => _ReturnBasketState();
}

class _ReturnBasketState extends State<ReturnBasket> {
  String total = '3700.00';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: HexColor('#6c7e9b'),
            height: 70.0,
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(150),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Prompt',
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "ค้นหาแบรนด์ตระกร้า",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          /*suffixIcon: RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: HexColor('#6c7e9b'),
                              ),
                              onPressed: () {},
                              iconSize: 30.0,
                            ),
                          ),*/
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5.0, right: 15.0, bottom: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor('#6c7e9b'),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.qr_code),
                        iconSize: 25.0,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListBasketReturn(),
            ),
          ),
          Container(
            height: 150.0,
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
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'จำนวนตระกร้ารวม (เก็บ)',
                            style: TextStyle(
                              fontSize: 16.0,
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
                            '20 ใบ',
                            style: TextStyle(
                              fontSize: 16.0,
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
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'คืนค่ามัดจำ',
                            style: TextStyle(
                              fontSize: 20.0,
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
                            18.0,
                            14.0,
                            Colors.orange,
                            Colors.orange,
                            'Prompt',
                            'Prompt',
                            FontWeight.bold,
                            FontWeight.bold,
                            '฿',
                            14.0,
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
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 25.0, right: 25.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          //alignment: Alignment.centerRight,
                          child: Icon(
                            LineAwesomeIcons.check_circle,
                            size: 25.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'บันทึกคืนตระกร้า',
                            style: TextStyle(
                              fontSize: 20.0,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
