import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:longdo_maps_api3_flutter/longdo_maps_api3_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_select_image.dart';
import 'package:vansale/screens/delivery/delivery_refuel/delivery_refuel_image.dart';

class DeliveryRefuelMap extends StatefulWidget {
  final String typeMenuCode;
  DeliveryRefuelMap(this.typeMenuCode);

  @override
  State<DeliveryRefuelMap> createState() => _DeliveryRefuelMapState();
}

class _DeliveryRefuelMapState extends State<DeliveryRefuelMap> {
  final map = GlobalKey<LongdoMapState>();
  final GlobalKey<ScaffoldMessengerState> messenger =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกการเติมน้ำมัน'),
      ),
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          searchLocation(),
          Expanded(
            child: Container(
              color: Colors.amber,
              child: LongdoMapWidget(
                bundleId: "",
                apiKey: "",
                key: map,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: btnSaveLocation(),
    );
  }

  Widget searchLocation() {
    return Container(
      height: 60.0,
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        height: 60.0,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'Prompt',
                    ),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "ค้นหาตำแหน่ง...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5.0, top: 5.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: HexColor('#6c7e9b'),
                        ),
                        onPressed: () {},
                        iconSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70.0,
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor("#6c7e9b"),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    LineAwesomeIcons.crosshairs,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnSaveLocation() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Container(
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) =>
            //         DeliveryRefuelImage(widget.typeMenuCode),
            //   ),
            // );
                   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryNewSupplierSelectImage(GlobalParam.typeMenuCode,
                        request: CustomerRequest(), subMenu: '004'),
              ),
            );
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(30 / 360),
                          child: Icon(
                            LineAwesomeIcons.location_arrow,
                            size: 25.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'บันทึกตำแหน่ง',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   child: Divider(
                //     height: 5.0,
                //     indent: 130.0,
                //     endIndent: 120.0,
                //     thickness: 2.0,
                //     color: HexColor('#00cb39'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
