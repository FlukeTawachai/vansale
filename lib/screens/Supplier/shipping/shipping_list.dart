import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/list_all.dart/lst_shipping.dart';

class ShippingList extends StatefulWidget {
  //const ShippingList({ Key? key }) : super(key: key);

  @override
  _ShippingListState createState() => _ShippingListState();
}

class _ShippingListState extends State<ShippingList> {
  String total = '5200.00';
  String poNo = "No. 632606-00xx";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ListShipping(),
            ),
          ),
          Container(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              height: 160.0,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70.0,
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.0,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            LineAwesomeIcons.boxes,
                            color: Colors.grey,
                            size: 50.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '32 รายการ , 32 ตระกร้า',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
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
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
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
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'THB',
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
                  DottedLine(
                    dashColor: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150.0,
                          alignment: Alignment.centerRight,
                          child: Icon(
                            LineAwesomeIcons.check_circle,
                            color: Colors.green,
                            size: 25.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'บันทึกส่งสินค้า',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
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
    );
  }
}
