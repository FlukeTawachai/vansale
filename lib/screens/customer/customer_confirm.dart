import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/home/home.dart';

class CustomerConfirm extends StatefulWidget {
  //const CustomerConfirm({ Key? key }) : super(key: key);
  final String typeMenuCode;
  CustomerConfirm(this.typeMenuCode);

  @override
  _CustomerConfirmState createState() => _CustomerConfirmState();
}

class _CustomerConfirmState extends State<CustomerConfirm> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
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
                          'รับชำระ',
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
              ),
              Container(
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
                              HomePage(widget.typeMenuCode),
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
            ],
          ),
        ),
      ),
    );
  }
}
