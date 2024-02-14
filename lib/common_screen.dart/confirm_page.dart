import 'dart:async';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/home/home.dart';


class ConfirmPage extends StatefulWidget {
  //const ConfirmPage({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final String title;
  final String detail;
  ConfirmPage(this.typeMenuCode, this.title, this.detail);
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  Timer _timer;

  _ConfirmPageState() {
    _timer = new Timer(const Duration(seconds: 1), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(widget.typeMenuCode),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

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
                  widget.title,
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
                  widget.detail,
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
    );
  }
}
