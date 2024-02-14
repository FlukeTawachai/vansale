import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CashCheckBodyPay extends StatelessWidget {

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
            child: chooseBank(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: chooseCheckType(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: checkDetails(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: paymentAmount(),
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
        ],
      ),
    );
  }

  Widget chooseBank() {
    return Center(
      child: Container(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //width: 360,
              child: Text(
                'เลือกธนาคาร',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              // alignment: Alignment.centerRight,
              
              width: 240.0,
              height: 35,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseCheckType() {
    return Center(
      child: Container(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //width: 360,
              child: Text(
                'เลือกประเภทเช็ค',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              // alignment: Alignment.centerRight,
              width: 240.0,
              height: 35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkDetails() {
    return Center(
      child: Container(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //width: 360,
                    child: Text(
                      'เลขที่เช็ค',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 170.0,
                    height: 35,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontFamily: 'Prompt',
                          color: Color.fromRGBO(169, 169, 169, 1),
                          fontSize: 16.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    //width: 360,
                    child: Text(
                      'วันที่เช็ค',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 170.0,
                    height: 35,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontFamily: 'Prompt',
                          color: Color.fromRGBO(169, 169, 169, 1),
                          fontSize: 16.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
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

  Widget paymentAmount() {
    return Center(
      child: Container(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Row(
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
              // alignment: Alignment.centerRight,
              width: 240.0,
              height: 35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget label1() {
    String totalCashCheck = '3000.00';
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
                child: substring1(totalCashCheck),
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
    String totalCashCheck = '3100.00';
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
                child: substring2(totalCashCheck),
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
    String totalCashCheck = '100.00';
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
                child: substring3(totalCashCheck),
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
