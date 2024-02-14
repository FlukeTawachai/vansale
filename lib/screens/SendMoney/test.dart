import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/SendMoney/main_components.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final listItems = List.generate(30, (i) => 'List Items ${i + 1}');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          final item = listItems[index];
          return Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComponentsSendMoney(),
                    ComponentsSendMoney2(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget amount1() {
    String total1 = '400.00';
    return Container(
      alignment: Alignment.center,
      child: substring1(total1),
    );
  }

  Widget label1() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "รับเงินสดจาก....",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
      ),
    );
  }

  Widget label2() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            'No. 630626-XXXX-XX',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(165, 180, 199, 1),
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget label3() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            '22/9/63   13:00',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(165, 180, 199, 1),
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget amount2() {
    String total2 = '400.00';
    return Container(
      alignment: Alignment.center,
      child: substring2(total2),
    );
  }

  Widget label4() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "จ่ายค่าใช้จ่ายเรื่อง",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
      ),
    );
  }

  Widget label5() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            'No. 630626-XXXX-XX',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(165, 180, 199, 1),
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget label6() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            '22/9/63   13:00',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(165, 180, 199, 1),
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 32,
        ),
      );

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
          fontSize: 14,
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
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
    return aa;
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
          fontSize: 14,
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
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
