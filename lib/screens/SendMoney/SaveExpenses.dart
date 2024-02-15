import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'main_SendMoney.dart';
//import 'package:vansale/screens/P_Tik/order.dart';

class SaveExpenses extends StatefulWidget {
  @override
  _SaveExpensesState createState() => _SaveExpensesState();
}

class _SaveExpensesState extends State<SaveExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.0,
        backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: Text(
          'ส่งเงิน - บันทึกค่าใช้จ่าย',
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
            onPressed: () {},
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
              height: 35,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: label1(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: text1(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: label2(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: text2(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: label3(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: text3(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: label4(),
            ),
          ],
        ),
      ),
    );
  }

  Widget label1() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 0,
      ),
      child: Align(
        alignment: Alignment(-0.76, 0.0),
        child: Text(
          'ค่าใช้จ่าย',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
            //color: Color.fromRGBO(34, 34, 34, 1),

            //fontWeight: FontWeight.bold,
            fontFamily: 'Prompt',
          ),
        ),
      ),
    );
  }

  Widget text1() {
    return Container(
      width: 320.0,
      height: 56,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "ค่าซ่อมรถ",

          //focusColor: Colors.grey,
          labelStyle: TextStyle(
            fontFamily: 'Prompt',
            color: HexColor('#A9A9A9'),
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
    );
  }

  Widget label2() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 0,
      ),
      child: Align(
        alignment: Alignment(-0.76, 0.0),
        child: Text(
          'จำนวนเงิน',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
            //fontWeight: FontWeight.bold,
            fontFamily: 'Prompt',
          ),
        ),
      ),
    );
  }

  Widget text2() {
    return Container(
      width: 320.0,
      height: 56,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "200.00",

          //focusColor: Colors.grey,
          labelStyle: TextStyle(
            fontFamily: 'Prompt',
            color: HexColor('#A9A9A9'),
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
    );
  }

  Widget label3() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 0,
      ),
      child: Align(
        alignment: Alignment(-0.76, 0.0),
        child: Text(
          'หมายเหตุ',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
            //color: Color.fromRGBO(34, 34, 34, 1),
            //fontWeight: FontWeight.bold,
            fontFamily: 'Prompt',
          ),
        ),
      ),
    );
  }

  Widget text3() {
    return Container(
      width: 320.0,

      //height: 56,
      child: TextFormField(
        maxLines: 10,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: "",

          //focusColor: Colors.red,
          labelStyle: TextStyle(
            fontFamily: 'Prompt',
            color: Color.fromRGBO(169, 169, 169, 1),
            fontSize: 16.0,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget label4() {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      height: 85.0,
      child: Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40.0,
                width: 170,
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
                        FontAwesomeIcons.checkCircle,
                        size: 20.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SendMoney(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        //alignment: Alignment.centerLeft,
                        // ignore: deprecated_member_use
                        child: Text(
                          'บันทึกค่าใช้จ่าย',
                          style: TextStyle(
                            fontSize: 18.0,
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
      ),
    );
  }
}
