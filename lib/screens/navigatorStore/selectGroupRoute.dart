import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getGroupRouteReq.dart';
import 'package:vansale/api/class/response/routeMobile/getBranchAllResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustInRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getGroupRouteResp.dart';
import 'package:vansale/screens/navigatorStore/storeInRoute.dart';

class SelectGroupRoute extends StatefulWidget {
  const SelectGroupRoute({Key key}) : super(key: key);

  @override
  State<SelectGroupRoute> createState() => _SelectGroupRouteState();
}

class _SelectGroupRouteState extends State<SelectGroupRoute> {
  @override
  void initState() {
    super.initState();

    getBranchAll();
  }

  String selectBranch = '';
  String selectGroup = '';
  String selectRoute = '';
  List<DropdownMenuItem<String>> branchList = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];
  List<DropdownMenuItem<String>> group = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
    DropdownMenuItem(child: Text("วันจันทร์"), value: "GRMON"),
    DropdownMenuItem(child: Text("วันอังคาร"), value: "GRTUE"),
    DropdownMenuItem(child: Text("วันพุธ"), value: "GRWED"),
    DropdownMenuItem(child: Text("วันพฤหัสบดี"), value: "GRTHU"),
    DropdownMenuItem(child: Text("ศุกร์"), value: "GRFRI"),
    DropdownMenuItem(child: Text("เสาร์"), value: "GRSAT"),
    DropdownMenuItem(child: Text("อาทิตย์"), value: "GRSUN"),
  ];

  List<DropdownMenuItem<String>> route = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];

  getBranchAll() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBranchAll();
      if ((result.isNotEmpty)) {
        // if (GlobalParam.VEHICLE["cBRANCD"] != "") {
        //   selectBranch = GlobalParam.VEHICLE["cBRANCD"];
        // }
        setState(() {
          for (var i = 0; i < result.length; i++) {
            branchList.add(DropdownMenuItem(
                value: result[i].cBRANCD, child: Text(result[i].cBRANNM)));
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
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
            Container(
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
                          onChanged: (String value) {
                            getRouteGroup(value);
                            setState(() {
                              selectBranch = value;
                            });
                          },
                          items: branchList))),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                          onChanged: (String value) {
                            getRouteGroup(value);
                            setState(() {
                              selectGroup = value;
                            });
                          },
                          items: group))),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                          onChanged: (String value) {
                            setState(() {
                              selectRoute = value;
                            });
                          },
                          items: route))),
            )
          ],
        ),
        SizedBox(
          height: 48,
        ),
        InkWell(
          onTap: () {
            if (selectBranch != "") {
              if (selectGroup != "") {
                if (selectRoute != "") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StoreInRoute(
                          request: GetGroupRouteReq(
                              cBRANCD: selectBranch,
                              cGRPCD: selectGroup,
                              cRTECD: selectRoute,
                              cCUSTNM: "%%"))));
                } else {
                  wrongDialog("กรุณาเลือกสาย");
                }
              } else {
                wrongDialog("กรุณาเลือกกลุ่ม");
              }
            } else {
              wrongDialog("กรุณาเลือกสาขา");
            }
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
        )
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

  getRouteGroup(String cGRPCD) async {
    if (cGRPCD != '') {
      if (cGRPCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getRouteGroup(
              GetGroupRouteReq(cBRANCD: selectBranch, cGRPCD: cGRPCD));
          if ((result.isNotEmpty)) {
            route = [];
            route.add(DropdownMenuItem(child: Text('เลือก'), value: ''));
            setState(() {
              for (int i = 0; i < result.length; i++) {
                route.add(DropdownMenuItem(
                    child: Text(result[i].cRTENM), value: result[i].cRTECD));
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
      route.add(DropdownMenuItem(child: Text('เลือก'), value: ''));
    }
  }
}
