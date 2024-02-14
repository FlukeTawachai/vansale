import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/SendMoney/SaveExpenses.dart';
//import 'package:vansale/screens/SendMoney/SaveExpenses.dart';
import 'package:vansale/screens/SendMoney/main_components.dart';
import 'package:vansale/screens/SendMoney/recordCashDetails.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final listItems = List.generate(30, (i) => 'List Items ${i + 1}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: Text(
          'ส่งเงิน',
          style: TextStyle(
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
            setState(() {
              Navigator.of(context).pop();
            });
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SaveExpenses(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        //alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: 414.0,
              height: 231.0,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: label1(),
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                          Container(
                            child: label2(),
                          ),
                          Container(
                            child: label3(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: label4(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  final item = listItems[index];
                  return Column(
                    children: [
                      Container(
                        child: Dismissible(
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          key: Key(item),
                          onDismissed: (direction) {
                            setState(() {
                              listItems.removeAt(index);
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ComponentsSendMoney(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 350,
                        child: DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ),
                      Container(
                        child: Dismissible(
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          key: Key(item),
                          onDismissed: (direction) {
                            setState(() {
                              listItems.removeAt(index);
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ComponentsSendMoney2(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 350,
                        child: DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              child: label5(),
            ),
          ],
        ),
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              '27/09/63',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: Text(
              'No',
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget label2() {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                '630626-00XX',
                style: TextStyle(
                  color: Color.fromRGBO(130, 145, 169, 1),
                  fontFamily: 'Prompt',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget label3() {
    String total1 = '3200.00';
    return Container(
      //color: Colors.blue,

      height: 30,
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Text(
                'ยอดขายทั้งหมด',
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
              child: substring33(total1),
            ),
          ),
        ],
      ),
    );
  }

  Widget label4() {
    String total2 = '500.00';
    return Container(
      //color: Colors.blue,

      height: 30,
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Text(
                ' ค่าน้ำมัน',
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
              child: substring22(total2),
            ),
          ),
        ],
      ),
    );
  }

  Widget label5() {
    String total3 = '2000.00';
    return Container(
      height: 200.0,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //--------------
          Container(
            height: 50,
            padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      'รวมเงินที่ต้องส่ง',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[400],
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: substring33(total3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 170,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: HexColor('#00cb39'),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //alignment: Alignment.centerRight,
                  child: Icon(
                    FontAwesomeIcons.dollarSign,
                    size: 17.0,
                    color: HexColor('#00cb39'),
                  ),
                ),
                Container(
                  //alignment: Alignment.centerLeft,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                      'ยืนยันการส่งเงิน',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HexColor('#00cb39'),
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                    onPressed: () {
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  substring22(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];
    var aa = RichText(
      text: TextSpan(
        text: '$bb',
        style: TextStyle(
          fontSize: 17,
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
    return aa;
  }

  substring33(String a) {
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
}
