import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/list_all.dart/lst_refuel.dart';

class Refuel extends StatefulWidget {
  //const Refuel({ Key? key }) : super(key: key);
  final String typeMenuCode;
  Refuel(this.typeMenuCode);
  @override
  _RefuelState createState() => _RefuelState();
}

class _RefuelState extends State<Refuel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('#c8c9c9'),
        child: ListRefuel(widget.typeMenuCode),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 80.0,
        color: Colors.white,
        child: Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AppbarPage(6.toString(), widget.typeMenuCode),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 35.0,
                    alignment: Alignment.center,
                    child: Icon(
                      LineAwesomeIcons.gas_pump,
                      color: Colors.green,
                      size: 25.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เติมน้ำมัน',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
