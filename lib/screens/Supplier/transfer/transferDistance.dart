import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/function/substring_price.dart';

class TransferDistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 122,
      //width: 360,

      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   child: pic(),
                // ),
                Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: storename(),
                        ),
                        Container(
                          child: Container(
                            child: address(),
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
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: icon(),
                ),
                Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: numberOfEntries(),
                        ),
                        // Container(
                        //   child: Container(
                        //     child: account_number(),
                        //   ),
                        // ),
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

  Widget pic() {
    return SizedBox(
      width: 70,
      child: Center(
        child: Image.asset(
          'assets/images/IMG.png',
          height: 56,
          width: 56,
        ),
      ),
    );
  }

  Widget storename() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "โกดังใหญ่ -> กข 99 สงขลา",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget address() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NY, Abraham Mount Suite 325',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
    );
  }

  Widget icon() {
    return Container(
      width: 70,
      //alignment: Alignment.centerRight,
      child: Icon(
        FontAwesomeIcons.box,
        size: 20.0,
        color: Colors.grey,
      ),
    );
  }

  Widget numberOfEntries() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "32 รายการ, 32 ตะกร้า",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget accountNumber() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No. 630626-XXXX',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }
}

class TransferPay extends StatelessWidget {
  final formatNum = new NumberFormat("#,###.0#", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 70,
      //width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   child: Center(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //           child: label1(),
          //         ),
          //         Container(
          //           child: Container(
          //             child: label2(),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Spacer(),
          Container(
            child: SubstringPrice(
                      '99999999.99',
                      18.0,
                      12.0,
                      HexColor('#fc971e'),
                      HexColor('#fc971e'),
                      'Prompt',
                      'Prompt',
                      FontWeight.bold,
                      FontWeight.bold,
                      'บาท',
                      14.0,
                      Colors.black,
                      'Prompt',
                      FontWeight.bold,
                      FontStyle.normal,
                      FontStyle.normal,
                      FontStyle.normal,
                    )

          ),
        ],
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ส่วนลดท้ายบิล    50 บาท',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ]),
    );
  }

  Widget label2() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ส่วนลดสินค้า    100 บาท\n*ลด 10 บาท\tแถม 1 ชิ้น',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ]),
    );
  }

}

class DetailsMainmore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 70,
      //width: 480,
      child: Column(
        children: [
          Container(
            child: label1(),
          ),
          Container(
            child: label2(),
          ),
          Container(
            child: label3(),
          ),
          Container(
            child: label4(),
          ),
        ],
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ยอดค้างชำระ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '200 บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label2() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ส่วนลดท้ายบิล',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '50 บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label3() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ยอดปัจจุบัน',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '3000 บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label4() {
    String totalCashCheck = '3100.00';
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'รวมทั้งหมด',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 50.0, right: 7.0),
            child: Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: substringCashCheck(totalCashCheck),
              ),
            ),
          ),
        ],
      ),
    );
  }

  substringCashCheck(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];
    var aa = RichText(
      text: TextSpan(
        text: '$bb',
        style: TextStyle(
          fontSize: 18,
          color: HexColor('#fc971e'),
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: 'THB',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Prompt',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
