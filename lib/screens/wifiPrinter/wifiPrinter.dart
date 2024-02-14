import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/wifiPrinter/printPage.dart';

class WifiPrinter extends StatefulWidget {
  const WifiPrinter({Key key}) : super(key: key);

  @override
  State<WifiPrinter> createState() => _WifiPrinterState();
}

class _WifiPrinterState extends State<WifiPrinter> {
  double withScreen = 0;
  double heightScreen = 0;
  TextEditingController printerIp = TextEditingController();
  NetworkPrinter networkPrinter = NetworkPrinter();
  @override
  Widget build(BuildContext context) {
    withScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Wifi Printer"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: withScreen * 0.8,
              child: TextFormField(
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: printerIp,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  hintText: '127.0.0.0',
                  hintStyle: TextStyle(color: Colors.grey),
                  // border: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // enabledBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  // disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
                onFieldSubmitted: (value) {
                  if (value != "") {
                    setState(() {
                      printerIp.text = value;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                printData(printerIp.text);
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
                        LineAwesomeIcons.print,
                        color: Colors.green,
                        size: 25.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Connect And Print',
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
          ],
        ),
      ),
    );
  }

  printData(String printerIp) async {
    var ticket = await networkPrinter.testTicket();
    await networkPrinter.printTicket(printerIp, ticket).then((value) {
      print("Print to $printerIp success");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('"Print to $printerIp success"',
            style: const TextStyle(fontSize: 16)),
        backgroundColor: HexColor("#70ad47"),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: heightScreen - (heightScreen * 0.15), left: 10, right: 10),
      ));
    });
  }
}
