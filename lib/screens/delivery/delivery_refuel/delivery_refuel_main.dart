import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/delivery/delivery_refuel/delivery_refuel_map.dart';
import 'package:vansale/screens/delivery/delivery_refuel/lst_delivery_refuel.dart';
import 'package:vansale/screens/delivery/delivery_refuel/refuel_checkin.dart';
import 'package:vansale/screens/home/home.dart';

class DeliveryRefuelMain extends StatefulWidget {
  final String typeMenuCode;
  DeliveryRefuelMain(this.typeMenuCode);
  //const DeliveryRefuelMain({Key key}) : super(key: key);

  @override
  State<DeliveryRefuelMain> createState() => _DeliveryRefuelMainState();
}

class _DeliveryRefuelMainState extends State<DeliveryRefuelMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('เติมน้ำมัน'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(widget.typeMenuCode),
              ),
            );
          },
          icon: Icon(LineAwesomeIcons.home),
        ),
      ),
      backgroundColor: HexColor("#F2F3F4"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListDeliveryRefuel(),
      ),
      bottomNavigationBar: btnRefuel_(),
    );
  }

  Widget btnRefuel_() {
    return Container(
      color: Colors.white,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RefuelCheckIn(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Icon(
                      LineAwesomeIcons.gas_pump,
                      size: 30.0,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    child: Text(
                      'เติมน้ำมัน',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Divider(
          //   color: Colors.green,
          //   indent: 150.0,
          //   endIndent: 150.0,
          //   thickness: 2,
          // ),
        ],
      ),
    );
  }
}
