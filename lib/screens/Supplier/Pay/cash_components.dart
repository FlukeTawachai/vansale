import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/globalparam.dart';

class BodyCashPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            child: Expanded(
              child: paymentAmount(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: label1(),
          ),
          Container(
            child: label2(),
          ),
          Container(
            child: label3(),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget paymentAmount() {
    String totalpaymentAmount = '3000.00';
    return Center(
      child: Container(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //width: 360,
                  child: Text(
                    'กรอกยอดชำระ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
                Container(
                  width: 240.0,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                  ),
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 50.0, right: 7.0),
                  child: Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: substringpaymentAmount(GlobalParam.deliveryStoreSum.iTOTAL!),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  substringpaymentAmount(String a) {
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
          color: Colors.green,
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
            text: '฿',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Prompt',
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
    return aa;
  }

  Widget label1() {
    String total1 = GlobalParam.deliveryStoreSum.iTOTAL!;
    return Container(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'จำนวนที่ชำระ',
              style: TextStyle(
                fontSize: 16.0,
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
                child: substring1(total1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  substring1(String a) {
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
          color: Colors.green,
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

  Widget label2() {
    String total2 = GlobalParam.deliveryStoreSum.iTOTAL!;
    return Container(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'ยอดที่ต้องชำระ',
              style: TextStyle(
                fontSize: 16.0,
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
                child: substring2(total2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  substring2(String a) {
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
          color: Colors.red[900],
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

  Widget label3() {
    String total3 = '0.00';
    return Container(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'รวมเป็นเงิน',
              style: TextStyle(
                fontSize: 16.0,
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
                child: substring3(total3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  substring3(String a) {
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
