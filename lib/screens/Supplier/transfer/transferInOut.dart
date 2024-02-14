import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/transfer/transferConfirm.dart';

class TransferInOut extends StatelessWidget {
  final String typeMenuCode;
  TransferInOut(this.typeMenuCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            "โอนย้ายสินค้า",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransferConfirm(
                          typeMenuCode: "T002",
                          hearderTitle: "โอนออกโกงดัง",
                        )));
              },
              child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(LineAwesomeIcons.arrow_left, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "โอนออกโกดัง",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Prompt',
                            fontSize: 16),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransferConfirm(
                          typeMenuCode: "T002",
                          hearderTitle: "โอนเข้าโกงดัง",
                        )));
              },
              child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(LineAwesomeIcons.arrow_right, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "โอนเข้าโกดัง",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Prompt',
                            fontSize: 16),
                      ),
                    ],
                  )),
            ),
          ),
        ]));
  }
}
