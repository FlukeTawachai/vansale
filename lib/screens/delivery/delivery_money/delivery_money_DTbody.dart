import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/globalparam.dart';

class MoneyDetailBody extends StatefulWidget {
  const MoneyDetailBody({Key? key}) : super(key: key);

  @override
  State<MoneyDetailBody> createState() => _MoneyDetailBodyState();
}

class _MoneyDetailBodyState extends State<MoneyDetailBody> {
  var pay = TextEditingController();
  double money = 0.00;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[200],
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            child: promptPay(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: payment_amount(),
          ),
          const SizedBox(
            height: 15,
          ),
          // Container(
          //   child: label1(),
          // ),
          // Container(
          //   child: label2(),
          // ),
          Container(
            child: label3(),
          ),
        ],
      ),
    );
  }

  Widget promptPay() {
    return SizedBox(
      // width: 70,
      child: Center(
        child: Image.asset(
          'assets/images/PromptPay.png',
          //height: 56,
          //width: 56,
        ),
      ),
    );
  }

  Widget payment_amount() {
    return Center(
      child: SizedBox(
        width: 360,
        //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
        //height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //width: 360,
              child: const Text(
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  border: Border.all(color: Colors.grey)),
              width: 240.0,
              height: 30,
              child: TextField(
                controller: pay,
                // enabled: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (value) {
                  // print("88888888888888888888888888888888888888");
                  setState(() {
                    if (value == '' || value == null) {
                      GlobalParam.deliveryPayReq.iDEBIT = 0.00;
                    } else {
                      money = double.parse(value);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget label1() {
    String totalCashCheck = '3000.00';
    return SizedBox(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: const Text(
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
        style: const TextStyle(
          fontSize: 18,
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          const TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
          const TextSpan(
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
    return SizedBox(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: const Text(
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
          const TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
          const TextSpan(
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
    double total = GlobalParam.deliveryAddSendMoney.iTOTAL! -
        (GlobalParam.deliveryAddSendMoney.iCOST ?? 0) -
        money -
        (GlobalParam.deliveryAddSendMoney.iREFUEL ?? 0);
    String totalCashCheck = '$total';
    return SizedBox(
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'รวมเป็นเงิน',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
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
          const TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
          const TextSpan(
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
