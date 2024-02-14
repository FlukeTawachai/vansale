import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
class ConfirmPage2 extends StatefulWidget {
  //const ConfirmPage2({ Key? key }) : super(key: key);
  final String typeMenuCode;
  ConfirmPage2(this.typeMenuCode);
  @override
  _ConfirmPage2State createState() => _ConfirmPage2State();
}

class _ConfirmPage2State extends State<ConfirmPage2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Icon(
                  LineAwesomeIcons.check_circle,
                  color: Colors.green,
                  size: 150.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'บันทึกการเติมน้ำมัน',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'เรียบร้อยแล้ว',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ],
          ),
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
                        AppbarPage(5.toString(), widget.typeMenuCode),
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
                        LineAwesomeIcons.arrow_left,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'กลับหน้าหลัก',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
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
      ),
    );
  }
}
