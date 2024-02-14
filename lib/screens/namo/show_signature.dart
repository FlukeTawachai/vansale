import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:typed_data';
import 'package:vansale/screens/home/home.dart';

class SignatureComfirm extends StatefulWidget {
  SignatureComfirm(this.typeMenuCode, {Key key, this.imagedata})
      : super(key: key);

  @override
  State<SignatureComfirm> createState() => _SignatureComfirmState();
  String typeMenuCode;
  final Uint8List imagedata;
}

class _SignatureComfirmState extends State<SignatureComfirm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ยืนยันการรับสินค้า',
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
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.memory(
            widget.imagedata,
            height: 255,
            width: 255,
          ),
        ),
      ),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget buttonBar() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 0.0,
              child: InkWell(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage("T010")),
                    (route) => false),
                child: Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          LineAwesomeIcons.check_circle,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'ยืนยันการรับสินค้า',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
