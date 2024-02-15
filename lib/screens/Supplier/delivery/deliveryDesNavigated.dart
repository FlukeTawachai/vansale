import 'package:flutter/material.dart';
import 'package:vansale/screens/home/home.dart';

class DestinationNavigated extends StatefulWidget {
  const DestinationNavigated({Key? key}) : super(key: key);

  @override
  State<DestinationNavigated> createState() => _DestinationNavigatedState();
}

class _DestinationNavigatedState extends State<DestinationNavigated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage("T002")),
              (Route<dynamic> route) => false);
        },
        child: Image.asset(
          "assets/images/MapNavigator.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
