import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/list_all.dart/g_menu_store.dart';
import 'package:vansale/screens/shipping/shipping_store_detail.dart';

class Shipping extends StatefulWidget {
  //const Shipping({ Key? key }) : super(key: key);
  final String typeMenuCode;
  Shipping(this.typeMenuCode);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String poNo = "No. 632606-00xx";

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  String total = '3200.00';
  String totalreturn = '-3200.00';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 40.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        yearThai(),
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$poNo',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ShippingStoreDetail(),
              ),
            ),
            Container(
              height: 500.0,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.0,
                          child: Text(
                            'รวมส่ง',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    '32 รายการ , 32 ตระกร้า',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '$poNo',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Column(
                            children: [
                              Container(
                                child: SubstringPrice(
                                  total,
                                  18.0,
                                  14.0,
                                  Colors.green,
                                  Colors.green,
                                  'Prompt',
                                  'Prompt',
                                  FontWeight.bold,
                                  FontWeight.bold,
                                  '',
                                  14.0,
                                  Colors.orange,
                                  'Prompt',
                                  FontWeight.bold,
                                  FontStyle.normal,
                                  FontStyle.normal,
                                  FontStyle.normal,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 5.0),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'บาท',
                                  style: TextStyle(
                                    fontFamily: 'Prompt',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.0,
                          child: Text(
                            'รวมรับคืน',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    '1 รายการ , 2 ตระกร้า',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: SubstringPrice(
                                    totalreturn,
                                    18.0,
                                    14.0,
                                    Colors.orange,
                                    Colors.orange,
                                    'Prompt',
                                    'Prompt',
                                    FontWeight.bold,
                                    FontWeight.bold,
                                    '',
                                    14.0,
                                    Colors.orange,
                                    'Prompt',
                                    FontWeight.bold,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'บาท',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
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
                  //------------------
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: HexColor("#F2F3F4"),
                      height: MediaQuery.of(context).size.height / 2.8,
                      child: GridMenuStore(widget.typeMenuCode),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80.0,
                    color: Colors.white,
                    child: Container(
                      child: InkWell(
                        onTap: () {},
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
                                  LineAwesomeIcons.map_marker,
                                  color: Colors.green,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'เช็คอิน',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
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
}
