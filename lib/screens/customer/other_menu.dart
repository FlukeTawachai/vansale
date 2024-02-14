import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/customer/transfer_payment.dart';

class OtherMenu extends StatefulWidget {
  //const OtherMenu({Key key}) : super(key: key);
  final String typeMenuCode;
  OtherMenu(this.typeMenuCode);
  @override
  _OtherMenuState createState() => _OtherMenuState();
}

class _OtherMenuState extends State<OtherMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50.0),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Text(
                'เมนู',
                style: TextStyle(
                  color: Colors.black,
                  //color: Color.fromRGBO(0, 157, 181, 5),
                  fontFamily: 'Prompt',
                  fontSize: 18.0,
                ),
              ),
            ),
            ListTile(
              leading: new Icon(
                LineAwesomeIcons.file_invoice_with_us_dollar,
                color: Colors.black54,
                size: 30.0,
              ),
              title: new Text(
                'แจ้งโอนเงิน',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Prompt',
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TransferPayment(widget.typeMenuCode),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: new Icon(
                LineAwesomeIcons.power_off,
                color: Colors.black54,
                size: 30.0,
              ),
              title: new Text(
                'ออกจากระบบ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Prompt',
                  fontSize: 16.0,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
