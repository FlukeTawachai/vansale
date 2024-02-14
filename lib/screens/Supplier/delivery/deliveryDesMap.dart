import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/screens/Supplier/delivery/models/store.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/desMapFooter.dart';
import 'package:vansale/screens/googleMap/mapHome.dart';

class DestionationMap extends StatefulWidget {
  final StoreModel store;
  const DestionationMap({Key key, this.store}) : super(key: key);

  @override
  State<DestionationMap> createState() => _DestionationMapState();
}

class _DestionationMapState extends State<DestionationMap> {
  double latitude;
  double longitude;
  bool discoverStores = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'แผนที่ร้านค้า',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: MapSample(),
        // Image.asset(
        //   "assets/images/Map.jpg",
        //   fit: BoxFit.cover,
        // ),
        bottomNavigationBar: discoverStores == true
            ? DesMapFooter(store: widget.store)
            : Container());
  }

  getLocationStore() async {
    try {
      // nameOfRoute = "%${routeName.text}%";
      // setState(() {

      //   routeList.clear();
      // });

      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getLocationStore('CUST-18');
      if (result.cLATITUDE != '' && result.cLONGTITUDE != '') {
        discoverStores = true;
        print(
            '----------- Location Store: ${result.cLATITUDE},${result.cLONGTITUDE} -----------');
        GlobalParam.deliveryLocationStoreLatitude =
            double.parse(result.cLATITUDE);
        GlobalParam.deliveryLocationStoreLongitude =
            double.parse(result.cLONGTITUDE);
      } else {
        discoverStores = false;
        wrongDialog('ไม่พบที่อยู่ร้าน');
      }
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
