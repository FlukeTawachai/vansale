import 'package:flutter/material.dart';

class County extends StatefulWidget {
  //const County({ Key? key }) : super(key: key);

  @override
  _CountyState createState() => _CountyState();
}

class _CountyState extends State<County> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('แสดงเขต/อำเภอ'),
      ),
    );
  }
}
