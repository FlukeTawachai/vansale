import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeResp.dart';
import 'package:vansale/screens/warehouse3/CardWidgets/warehouse3Search.dart';

class Warehouse3SearchRoute extends StatefulWidget {
  //const Warehouse3SearchRoute({ Key? key }) : super(key: key);
  final String typeMenuCode;
  Warehouse3SearchRoute(this.typeMenuCode);

  @override
  State<Warehouse3SearchRoute> createState() => _Warehouse3SearchRouteState();
}

class _Warehouse3SearchRouteState extends State<Warehouse3SearchRoute> {
  var routeName = TextEditingController();
  String routeId;
  String nameOfRoute;
  String message = 'กรุณาระบุชื่อสาย';
  int storeInRoute = 0;
  List<RouteResp> routeList = [];
  List<RouteCusResp> routeCusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final moonLanding = new DateTime.now();
    // print(moonLanding.weekday); // 7
    if (moonLanding.weekday == 1) {
      routeName.text = 'อังคาร';
    } else if (moonLanding.weekday == 2) {
      routeName.text = 'พุธ';
    } else if (moonLanding.weekday == 3) {
      routeName.text = 'หัส';
    } else if (moonLanding.weekday == 4) {
      routeName.text = 'ศุกร์';
    } else if (moonLanding.weekday == 5) {
      routeName.text = 'เสาร์';
    } else if (moonLanding.weekday == 6) {
      routeName.text = 'ทั่วไป';
    } else if (moonLanding.weekday == 7) {
      routeName.text = 'จันทร์';
    } else {
      routeName.text = '';
    }

    getRoute();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ค้นหาสาย'),
        ),
        body: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                    style: TextStyle(
                      fontFamily: 'Prompt',
                    ),
                    textInputAction: TextInputAction.search,
                    controller: routeName,
                    decoration: InputDecoration(
                      hintText: "ค้นหาชื่อรถ สาย",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5.0, top: 12.0),
                      prefixIcon: RotatedBox(
                        quarterTurns: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: HexColor('#6c7e9b'),
                          ),
                          onPressed: () {},
                          iconSize: 25.0,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        routeName.text = value;
                      });

                      getRoute();
                    }),
              ),
              Expanded(
                child: Container(
                  color: HexColor("#F2F3F4"),
                  child: (routeList.isNotEmpty)
                      ? ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: routeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Warehouse3SearchCard(
                              cRTECD: routeList[index].cRTECD,
                              cRTENM: routeList[index].cRTENM,
                              cGRPCD: routeList[index].cGRPCD,
                            );
                          })
                      : Center(
                          child: Text(message,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRoute() async {
    if (routeName.text.isNotEmpty) {
      try {
        nameOfRoute = "%${routeName.text}%";
        setState(() {
          routeList.clear();
        });

        // print("************** $nameOfRoute **************");

        AllApiProxyMobile proxy = AllApiProxyMobile();

        var result =
            await proxy.getRoute(nameOfRoute, GlobalParam.VEHICLE['cBRANCD']);
        if (result.isNotEmpty) {
          for (int i = 0; i < result.length; i++) {
            routeList.add(result[i]);
          }
        } else {
          routeList.clear();
          message = 'ไม่พบสาย';
        }
        setState(() {});
      } on SocketException catch (e) {
        wrongDialog(e.message);
      } on Exception catch (e) {
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog('กรุณาระบุชื่อสาย');
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
