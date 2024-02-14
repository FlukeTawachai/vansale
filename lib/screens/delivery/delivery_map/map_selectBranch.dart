import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getCustomerOfBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getGroupRouteReq.dart';
import 'package:vansale/api/class/response/routeMobile/getCustInRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getGroupRouteResp.dart';
import 'package:vansale/screens/delivery/delivery_map/map_DesNavigator.dart';
import 'package:vansale/screens/delivery/delivery_map/map_googleMap.dart';
import 'package:vansale/screens/navigatorStore/storeInRoute.dart';

class SelectBranchMap extends StatefulWidget {
  const SelectBranchMap({Key? key}) : super(key: key);

  @override
  State<SelectBranchMap> createState() => _SelectBranchMapState();
}

class _SelectBranchMapState extends State<SelectBranchMap> {
  String selectBranch = '';
  String selectGroup = '';
  String selectRoute = '';
  String selectVehicle = '';
  List<DropdownMenuItem<String>> group = [
    const DropdownMenuItem(child: Text("เลือก"), value: ""),
    const DropdownMenuItem(child: Text("วันจันทร์"), value: "GRMON"),
    const DropdownMenuItem(child: Text("วันอังคาร"), value: "GRTUE"),
    const DropdownMenuItem(child: Text("วันพุธ"), value: "GRWED"),
    const DropdownMenuItem(child: Text("วันพฤหัสบดี"), value: "GRTHU"),
    const DropdownMenuItem(child: Text("ศุกร์"), value: "GRFRI"),
    const DropdownMenuItem(child: Text("เสาร์"), value: "GRSAT"),
    const DropdownMenuItem(child: Text("อาทิตย์"), value: "GRSUN"),
  ];

  List<DropdownMenuItem<String>> route = [
    const DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];

  List<DropdownMenuItem<String>> branch = [
    const DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];

  List<DropdownMenuItem<String>> vehicle = [
    const DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBranchAll();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: widthScreen * 0.2,
                child: Text(
                  "เลือกสาขา:",
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                )),
            Container(
              width: widthScreen * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          value: selectBranch,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 16,
                            color: HexColor('#000000'),
                            // fontFamily: "Prompt",
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectBranch = value ?? '';
                              selectGroup = '';
                              selectRoute = '';
                              selectVehicle = '';
                              route = [
                                const DropdownMenuItem(
                                    child: Text("เลือก"), value: ""),
                              ];
                            });
                            getVehicleInBranch(value ?? '');
                          },
                          items: branch))),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: widthScreen * 0.2,
                child: Text(
                  "เลือกชื่อรถ:",
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                )),
            Container(
              width: widthScreen * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          value: selectVehicle,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 16,
                            color: HexColor('#000000'),
                            // fontFamily: "Prompt",
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectVehicle = value ?? '';
                            });
                          },
                          items: vehicle))),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: widthScreen * 0.2,
                child: Text(
                  "เลือกกลุ่ม:",
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                )),
            Container(
              width: widthScreen * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          value: selectGroup,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 16,
                            color: HexColor('#000000'),
                            // fontFamily: "Prompt",
                          ),
                          onChanged: (value) {
                            getRouteGroup(value ?? '', selectBranch);
                            setState(() {
                              selectGroup = value ?? '';
                            });
                          },
                          items: group))),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: widthScreen * 0.2,
                child: Text(
                  "เลือกสาย:",
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                )),
            Container(
              width: widthScreen * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          value: selectRoute,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 16,
                            color: HexColor('#000000'),
                            // fontFamily: "Prompt",
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectRoute = value ?? '';
                            });
                          },
                          items: route))),
            )
          ],
        ),
        const SizedBox(
          height: 48,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapStores(
                    req: GetCustomerOfBranchReq(
                        cBRANCD: '%${selectBranch}%',
                        cGRPCD: '%${selectGroup}%',
                        cRTECD: '%${selectRoute}%',
                        cVEHICD: '%${selectVehicle}%'))));
          },
          child: Container(
            width: widthScreen * 0.6,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
                child: Text(
              "ค้นหา",
              style: TextStyle(
                fontFamily: "Prompt",
                fontSize: 18,
                color: HexColor('#ffffff'),
                // fontFamily: "Prompt",
              ),
            )),
          ),
        ),
        // SizedBox(
        //   height: 48,
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (context) => DesNavigator()));
        //   },
        //   child: Container(
        //     width: widthScreen * 0.6,
        //     height: 48,
        //     decoration: BoxDecoration(
        //       color: Colors.green,
        //       shape: BoxShape.rectangle,
        //       borderRadius: BorderRadius.circular(5.0),
        //     ),
        //     child: Center(
        //         child: Text(
        //       "นำทาง",
        //       style: TextStyle(
        //         fontFamily: "Prompt",
        //         fontSize: 18,
        //         color: HexColor('#ffffff'),
        //         // fontFamily: "Prompt",
        //       ),
        //     )),
        //   ),
        // )
      ],
    );
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

  getBranchAll() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBranchAll();
      if ((result.isNotEmpty)) {
        setState(() {
          for (var item in result) {
            branch.add(DropdownMenuItem(
                child: Text(item.cBRANNM ?? ''), value: item.cBRANCD));
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getVehicleInBranch(String branch) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getVehicleInBranch(branch);
      if ((result.isNotEmpty)) {
        setState(() {
          vehicle = [const DropdownMenuItem(child: Text("เลือก"), value: "")];
          result.sort(
              (a, b) => a.cVEHICD.toString().compareTo(b.cVEHICD.toString()));

          for (var item in result) {
            vehicle.add(DropdownMenuItem(
                child: Text(item.cVEHINM ?? ''), value: item.cVEHICD));
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getRouteGroup(String cGRPCD, String cBRANCD) async {
    if (cGRPCD != '') {
      if (cGRPCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getRouteGroup(
              GetGroupRouteReq(cBRANCD: cBRANCD, cGRPCD: cGRPCD));
          if ((result.isNotEmpty)) {
            setState(() {
              route = [
                const DropdownMenuItem(child: Text("เลือก"), value: ""),
              ];
              for (int i = 0; i < result.length; i++) {
                route.add(DropdownMenuItem(
                    child: Text(result[i].cRTENM ?? ''),
                    value: result[i].cRTECD));
              }
            });
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {
      route = [];
      route.add(const DropdownMenuItem(child: Text('เลือก'), value: ''));
    }
  }
}
