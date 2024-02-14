import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getRouteTodayReq.dart';
import 'package:vansale/api/class/request/mobile/getStartWorkReq.dart';
import 'package:vansale/api/class/request/mobile/startStopWorkReq.dart';
import 'package:vansale/function/title_appbar.dart';
import 'package:vansale/screens/delivery/delivery_bill/print.dart';

import 'package:vansale/screens/delivery/delivery_startwork/delivery_startwork_main.dart';
import 'package:vansale/screens/main_menu/main_menu.dart';
import 'package:vansale/screens/login/login.dart';
import 'package:vansale/screens/startwork.dart';
import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/warehouse3_search_route..dart';

class HomePage extends StatefulWidget {
  final String typeMenuCode;
  HomePage(this.typeMenuCode);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cVEHINM = 'หมายเลขรถ 0002';
  String cPLATE = '1ฒจ 6477';
  String dayName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final moonLanding = new DateTime.now();
    // print(moonLanding.weekday); // 7
    if (moonLanding.weekday == 1) {
      dayName = '%จันทร์%';
    } else if (moonLanding.weekday == 2) {
      dayName = '%อังคาร%';
    } else if (moonLanding.weekday == 3) {
      dayName = '%พุธ%';
    } else if (moonLanding.weekday == 4) {
      dayName = '%หัส%';
    } else if (moonLanding.weekday == 5) {
      dayName = '%ศุกร์%';
    } else if (moonLanding.weekday == 6) {
      dayName = '%เสาร์%';
    } else if (moonLanding.weekday == 7) {
      dayName = '%ทั่วไป%';
    } else {
      dayName = '';
    }

    if (GlobalParam.typeMenuCode == 'T001' ||
        GlobalParam.typeMenuCode == 'T002') {
      getRouteToday();
    }

    getProType();
    // getStartWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      color: Colors.green,
                    ),
                  ),
                  imageProfile_(),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    companyName_(),
                    userFName_(),
                    carNo_(),
                    licensePlate_(),
                  ],
                ),
              ),
              showGridMenu_(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: showStartWorkbtn_(widget.typeMenuCode),
    );
  }

  Widget appbar_() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.green,
      centerTitle: true,
      title: TitleName(0.toString()),
      leading: Container(),
      actions: [
        iconBell_(),
        icon3Dot_(widget.typeMenuCode),
      ],
    );
  }

  Widget showGridMenu_() {
    return Expanded(
      child: Container(
        alignment: widget.typeMenuCode == "T006"
            ? Alignment.topCenter
            : Alignment.center,
        color: HexColor("#F2F3F4"),
        height: MediaQuery.of(context).size.height / 2.8,
        child: MainMenu(widget.typeMenuCode),
      ),
    );
  }

  Widget showStartWorkbtn_(String menuCode) {
    switch (menuCode) {
      case "T001":
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 48.0,
          alignment: Alignment.center,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         alignment: Alignment.bottomCenter,
          //         height: 40.0,
          //         width: 65.0,
          //         padding: const EdgeInsets.all(5.0),
          //         decoration: BoxDecoration(
          //           color: Colors.green,
          //           borderRadius: BorderRadius.circular(150),
          //           border: new Border.all(
          //             color: Colors.white,
          //             width: 2.0,
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 5,
          //               blurRadius: 7,
          //               offset: Offset(0, 3), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Container(
          //           alignment: Alignment.center,
          //           child: IconButton(
          //             icon: const Icon(LineAwesomeIcons.shipping_fast),
          //             iconSize: 35.0,
          //             color: Colors.white,
          //             onPressed: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (BuildContext context) =>
          //                       DeliveryStartWork(widget.typeMenuCode),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         alignment: Alignment.center,
          //         child: Text(
          //           'START WORK',
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        );
        break;
      case "T002":
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 150.0,
          alignment: Alignment.center,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         alignment: Alignment.bottomCenter,
          //         height: 40.0,
          //         width: 65.0,
          //         padding: const EdgeInsets.all(5.0),
          //         decoration: BoxDecoration(
          //           color: Colors.green,
          //           borderRadius: BorderRadius.circular(150),
          //           border: new Border.all(
          //             color: Colors.white,
          //             width: 2.0,
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 5,
          //               blurRadius: 7,
          //               offset: Offset(0, 3), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Container(
          //           alignment: Alignment.center,
          //           child: IconButton(
          //             icon: const Icon(LineAwesomeIcons.shipping_fast),
          //             iconSize: 35.0,
          //             color: Colors.white,
          //             onPressed: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (BuildContext context) =>
          //                       StartWork(widget.typeMenuCode),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         alignment: Alignment.center,
          //         child: Text(
          //           'START WORK',
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        );
        break;
      default:
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 150.0,
        );
    }
  }

  Widget iconBell_() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
      child: Icon(
        LineAwesomeIcons.bell,
        color: Colors.black,
      ),
    );
  }

  Widget icon3Dot_(String typeMenuCode) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      child: GlobalParam.typeMenuCode == 'T001'
          ? Stack(children: [
              IconButton(
                  icon: Icon(
                    LineAwesomeIcons.print,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (typeMenuCode == 'T001') {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         Warehouse3SearchRoute('T001'),
                      //   ),
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BluPrintPOS(code: '001'),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                          (Route<dynamic> route) => false);
                    }
                  }),
              GlobalParam.bluetoothConnect == true
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 2),
                      child: Container(
                          child: Icon(Icons.warning, color: Colors.red)),
                    )
                  : Container()
            ])
          : Container(),
    );
  }

  Widget imageProfile_() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 130.0,
        height: 130.0,
        decoration: new BoxDecoration(
          color: Colors.grey,
          image: new DecorationImage(
            image: new AssetImage('assets/images/brandon.png'),
            scale: 1.0,
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
          border: new Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }

  Widget companyName_() {
    return Container(
      child: Text(
        'บจก. นายกัณฐ์เทรดดิ้ง',
        style: TextStyle(
          color: Colors.green,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget userFName_() {
    return Container(
      child: Text(
        'นายปิยวัฒน์ มีเสน',
        style: TextStyle(
          color: Colors.green,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget carNo_() {
    return Container(
      child: Text(
        'หมายเลขรถ 0002',
        style: TextStyle(
          color: Colors.green,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget licensePlate_() {
    return Container(
      child: Text(
        'ทะเบียนรถ 1ฒจ 6477 กรุงเทพ',
        style: TextStyle(
          color: Colors.green,
          fontSize: 14.0,
        ),
      ),
    );
  }

  getRouteToday() async {
    // if (cVEHINM == '') {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getRouteToday(
        GlobalParam.VEHICLE['cVEHICD'],
        GlobalParam.VEHICLE['cBRANCD'],
        dayName,
      );

      // var result = await proxy.getRouteToday(cVEHINM, cPLATE, '%พุธ%');

      if (result.cRTECD != '') {
        GlobalParam.deliveryRouteToday['cRTECD'] = result.cRTECD;
        GlobalParam.deliveryRouteToday['cRTENM'] = result.cRTENM;
        GlobalParam.deliveryRouteToday['cGRPCD'] = result.cGRPCD;
        GlobalParam.deliveryRouteToday['cBRANCD'] = result.cBRANCD;
        // print(
        //     '++++++++++++ ${GlobalParam.deliveryRouteToday['cRTECD']} : ${GlobalParam.deliveryRouteToday['cRTENM']} ++++++++++++');
      } else {
        wrongDialog('ไม่พบสายที่ต้องจัดส่ง');
      }
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    // } else {
    //   wrongDialog('ข้อมูลผิดพลาด');
    // }
  }

  getProType() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getProType();
      if ((result.isNotEmpty)) {
        // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
        GlobalParam.deliveryProType = result;
      }
      // print('++++++++++++ ${sumOfStore.length} ++++++++++++');
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getStartWork() async {
    try {
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(new DateTime.now());
      AllApiProxyMobile proxy = AllApiProxyMobile();
      String section = '';
      if (GlobalParam.typeMenuCode == 'T001') {
        section = 'TF';
      }
      if (GlobalParam.typeMenuCode == 'T002') {
        section = 'SL';
      }
      if (GlobalParam.typeMenuCode == 'T004') {
        section = 'ST';
      }
      var result = await proxy.getStartWork(GetStartWorkReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cUSRNM: GlobalParam.userData.cUSRNM,
          cSECTION: section,
          dINVENTDT: outputDate));
      if ((result.isNotEmpty)) {
        // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
        GlobalParam.startWorkList = result;
      }
      // print('++++++++++++ ${sumOfStore.length} ++++++++++++');
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    //path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}

class RouteModel {
  final String name;

  RouteModel(this.name);
}
