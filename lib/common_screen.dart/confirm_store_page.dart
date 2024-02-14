import 'dart:async';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_home.dart';

class ConfirmStorePage extends StatefulWidget {
  final String typeMenuCode;
  final String title;
  final String detail;
  ConfirmStorePage(this.typeMenuCode, this.title, this.detail);

  @override
  State<ConfirmStorePage> createState() => _ConfirmStorePageState();
}

class _ConfirmStorePageState extends State<ConfirmStorePage> {
  Timer _timer;

  _ConfirmStorePageState() {
    _timer = new Timer(const Duration(seconds: 1), () {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DeliveryStoreHome(widget.typeMenuCode,"A Store"),
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
