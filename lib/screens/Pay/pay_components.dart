import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vansale/screens/Pay/cashTransfer_main.dart';

import 'package:vansale/screens/Pay/cash_main.dart';
import 'package:vansale/screens/Pay/cashCheck_main.dart';

class PayBody extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: PayManu(),
          ),
          Container(
            child: label2(),
          ),
        ],
      ),
    );
  }

  Widget label2() {
    return Container(
      width: 350,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'เงินสดรับเงินบางส่วนได้ ไปตัดเครดิตหลังบ้าน',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 14,
              ),
            ),
          ),
          Container(
            child: Text(
              'โอนเงิน แสดง prompay qr code หมายเลขบัญชี',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 14,
              ),
            ),
          ),
          Container(
            child: Text(
              'ให้บันทึกวันที่ เวลาโอน ถ่ายรูปสลิป',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 14,
              ),
            ),
          ),
          Container(
            child: Text(
              'เช็ค ถ่ายรูปเช็ค บันทึกธนาคาร duedate',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PayManu extends StatefulWidget {
  @override
  _PayManuState createState() => _PayManuState();
}

class _PayManuState extends State<PayManu> {
  var menus = [
    {
      "icon": FontAwesomeIcons.dollarSign,
      "name": "เงินสด",
      "size": 28.0,
      "menu": Cash(),
    },
    {
      "icon": FontAwesomeIcons.warehouse,
      "name": " โอน",
      "size": 28.0,
      "menu": CashTransfer(),
    },
    {
      "icon": FontAwesomeIcons.creditCard,
      "name": " เช็ค",
      "size": 28.0,
      "menu": CashCheck(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 350,
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            //physics: new NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(25.0),
            itemCount: menus.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height) /
                  0.35,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(5.0),
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => menus[index]['menu'],
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          menus[index]['icon'],
                          color: Colors.green,
                          size: menus[index]['size'],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        //padding: const EdgeInsets.all(5.0),
                        child: Text(
                          menus[index]['name'],
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
