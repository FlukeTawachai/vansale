import 'package:flutter/material.dart';

class District extends StatefulWidget {
  //const District({ Key? key }) : super(key: key);

  @override
  _DistrictState createState() => _DistrictState();
}

class _DistrictState extends State<District> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('แสดงแขวง/ตำบล'),
      ),
    );
  }
}
