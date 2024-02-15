import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/SendMoney/recordCashDetails_components.dart';

class RecordCashDetails extends StatefulWidget {
  @override
  _RecordCashDetailsState createState() => _RecordCashDetailsState();
}

class _RecordCashDetailsState extends State<RecordCashDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.0,
        backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: Text(
          'ส่งเงิน - บันทึกรายละเอียดเงินสด',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(
              () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        //alignment: Alignment.topCenter,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: label1(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        label2(),
                        label3(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: label4(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 350,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        depositamount(),
                        const SizedBox(
                          height: 20,
                        ),
                        banknote1000(),
                        const SizedBox(
                          height: 20,
                        ),
                        banknote500(),
                        const SizedBox(
                          height: 20,
                        ),
                        banknote100(),
                        const SizedBox(
                          height: 20,
                        ),
                        banknote50(),
                        const SizedBox(
                          height: 20,
                        ),
                        banknote20(),
                        const SizedBox(
                          height: 20,
                        ),
                        totalcoins(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  label5(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: label6(),
            ),
          ],
        ),
      ),
    );
  }

  Widget label1() {
    String total2 = '2000.00';
    return Container(
      padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                'รวมเงินที่ต้องส่ง',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: substring2(total2),
            ),
          ),
        ],
      ),
    );
  }

  Widget label2() {
    return Container(
      height: 28,
      padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  'เงินโอน',
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
                  '0',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: HexColor('#00cb39'),
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget label3() {
    return Container(
      height: 28,
      padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                'เช็ค',
                style: TextStyle(
                  fontSize: 16.0,
                  //color: Colors.black,
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
                '0',
                style: TextStyle(
                  fontSize: 20.0,
                  color: HexColor('#00cb39'),
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget label4() {
    return Center(
      child: Container(
        height: 40,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  'บัญชีที่ต้องโอน TMB 405-603-XXX',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  'ชื่อบัญชี บริษัท XXXXX',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget label5() {
    String total3 = '-2000.00';
    return Container(
      //color: Colors.blue,
      width: 380,
      height: 30,
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Text(
                'เงินขาด',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: substring3(total3),
            ),
          ),
        ],
      ),
    );
  }

  Widget label6() {
    return Container(
      color: Colors.white,
      height: 85.0,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //height: 45.0,
              width: 175,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: HexColor('#00cb39'),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //alignment: Alignment.centerRight,
                    child: Icon(
                      FontAwesomeIcons.dollarSign,
                      size: 25.0,
                      color: HexColor('#00cb39'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RecordCashDetails(),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      //alignment: Alignment.centerLeft,
                      // ignore: deprecated_member_use
                      child: Text(
                        'ยืนยันการส่งเงิน',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: HexColor('#00cb39'),
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
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
          fontSize: 20,
          color: HexColor('#00cb39'),
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
              fontSize: 14,
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
            ),
          ),
        ],
      ),
    );
    return aa;
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
          fontSize: 20,
          color: Color.fromRGBO(203, 57, 57, 1),
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
              fontSize: 14,
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
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
