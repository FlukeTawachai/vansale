import 'package:flutter/material.dart';

class Province extends StatefulWidget {
  //const Province({ Key? key }) : super(key: key);

  @override
  _ProvinceState createState() => _ProvinceState();
}

class _ProvinceState extends State<Province> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('แสดงจังหวัด'),
      ),
    );
  }
}
