import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/request/mobile/addProductTransferReq.dart';
import 'package:vansale/api/class/request/mobile/getVehicleWithBranchReq.dart';
import 'package:vansale/api/class/response/routeMobile/getBranchAllResp.dart';
import 'package:vansale/api/class/response/routeMobile/getVehicleWithBranchResp.dart';
import 'package:vansale/screens/branch_warehouse/branch_warehouse_transfer/batch_transfer.dart';
import 'package:vansale/screens/branch_warehouse/branch_warehouse_transfer/normal_transfer.dart';

class BranchWarehouseMain extends StatefulWidget {
  BranchWarehouseMain({Key key, this.typeMenuCode}) : super(key: key);
  String typeMenuCode;
  @override
  State<BranchWarehouseMain> createState() => _BranchWarehouseMainState();
}

class _BranchWarehouseMainState extends State<BranchWarehouseMain> {
  String selectedBranch;
  String selectedVehicle;
  String branchName = '';
  String vehicleName = '';
  String selectedWHTransfer;
  String selectedType;
  List<GetBranchAllResp> branchData = [];
  List<GetVehicleWithBranchResp> vehicleData = [];
  List<BranchWarehouse> branchWarehouses = [];
  List<DropdownMenuItem<String>> branchList = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];
  List<DropdownMenuItem<String>> vehicleList = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
  ];
  List<DropdownMenuItem<String>> transferList = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
    DropdownMenuItem(child: Text("โอนธรรมดา"), value: "01"),
    DropdownMenuItem(child: Text("โอนเป็นชุด"), value: "02"),
  ];
  List<DropdownMenuItem<String>> customerTypeList = [
    DropdownMenuItem(child: Text("เลือก"), value: ""),
    DropdownMenuItem(child: Text("ค้าปลีก"), value: "Retail"),
    DropdownMenuItem(child: Text("ค้าส่ง"), value: "Wholesale"),
  ];
  double widthScreen = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedBranch = "";
    selectedVehicle = "";
    selectedWHTransfer = '';
    selectedType = "";
    getBranchAll();
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('โอนย้าย'),
      ),
      body: ListView(
        children: [
          branch(),
          vehicle(),
          customerType(),
          whTransfer(),
        ],
      ),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget branch() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สาขา',
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: widthScreen * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                        value: selectedBranch,
                        hint: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "กรุณาเลือกสาขา",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 16,
                          color: selectedBranch == ""
                              ? HexColor('#000000')
                              : HexColor('#00cb39'),
                          // fontFamily: "Prompt",
                        ),
                        onChanged: (newValue) {
                          print("*******************$newValue");
                          setState(() {
                            selectedBranch = newValue;
                            for (var i = 0; i < branchData.length; i++) {
                              if (branchData[i].cBRANCD == newValue) {
                                branchName = branchData[i].cBRANNM;
                              }
                            }
                            if (newValue != '') {
                              getVehicleWithBranch(newValue);
                            }
                            selectedVehicle = "";
                            vehicleList = [
                              DropdownMenuItem(child: Text("เลือก"), value: ""),
                            ];
                          });
                        },
                        items: branchList))),
          )
        ],
      ),
    );
  }

  Widget vehicle() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'รถ',
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: widthScreen * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                        value: selectedVehicle,
                        hint: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "กรุณาเลือกรถ",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 16,
                          color: selectedVehicle == ""
                              ? HexColor('#000000')
                              : HexColor('#00cb39'),
                          // fontFamily: "Prompt",
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            for (var i = 0; i < vehicleData.length; i++) {
                              if (vehicleData[i].cVEHICD == newValue) {
                                vehicleName = vehicleData[i].cVEHINM;
                              }
                            }
                            selectedVehicle = newValue;
                          });
                        },
                        items: vehicleList))),
          )
        ],
      ),
    );
  }

  Widget whTransfer() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'โอน',
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  hint: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "เลือก",
                      style: TextStyle(
                        fontFamily: "Prompt",
                        fontSize: 16,
                        color: HexColor('#000000'),
                        // fontFamily: "Prompt",
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  isExpanded: true,
                  value: selectedWHTransfer,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: selectedWHTransfer == ""
                        ? HexColor('#000000')
                        : HexColor('#00cb39'),
                    // fontFamily: "Prompt",
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedWHTransfer = newValue;
                    });
                  },
                  items: transferList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customerType() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'กลุ่มร้านค้า',
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  hint: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "เลือก",
                      style: TextStyle(
                        fontFamily: "Prompt",
                        fontSize: 16,
                        color: HexColor('#000000'),
                        // fontFamily: "Prompt",
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  isExpanded: true,
                  value: selectedType,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: selectedType == ""
                        ? HexColor('#000000')
                        : HexColor('#00cb39'),
                    // fontFamily: "Prompt",
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue;
                    });
                  },
                  items: customerTypeList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonBar() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 0.0,
              child: InkWell(
                onTap: () {
                  if (selectedBranch == '') {
                    wrongDialog("กรุณาเลือกสาขา");
                  } else if (selectedVehicle == '') {
                    wrongDialog("กรุณาเลือกรถ");
                  } else if (selectedWHTransfer == '') {
                    wrongDialog("กรุณาเลือกการโอน");
                  } else if (selectedType == '') {
                    wrongDialog("กรุณาเลือกกลุ่มร้าน");
                  } else {
                    switch (selectedWHTransfer) {
                      case "01":

                        /// โอนธรรมดา
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NormalTransfer(widget.typeMenuCode, true)));
                        break;
                      case "02":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => BatchTransfer(
                              cBRANCD: selectedBranch,
                              cVEHICD: selectedVehicle,
                              cCUSTTYPE: selectedType,
                              code: "02",
                              reqData: AddProductTransferReq(
                                  cBRANCD: selectedBranch,
                                  cSENDER: selectedBranch,
                                  cSENDERNM: branchName,
                                  cRECEIVER: selectedVehicle,
                                  cRECEIVERNM: vehicleName),
                            ),
                          ),
                        );
                        break;
                    }
                  }
                },
                child: Container(
                  width: 100.0,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          LineAwesomeIcons.check_circle,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'โอนย้าย',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('แจ้งเตือน'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 16.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      'ตกลง',
                    );
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
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
          branchData = [];
          branchData.addAll(result);
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

  getVehicleWithBranch(String cBRANCD) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy
          .getVehicleWithBranch(GetVehicleWithBranchReq(cBRANCD: cBRANCD));
      if (result.isNotEmpty) {
        setState(() {
          vehicleData = [];
          vehicleData.addAll(result);
          for (var i = 0; i < result.length; i++) {
            vehicleList.add(DropdownMenuItem(
                value: result[i].cVEHICD, child: Text(result[i].cVEHINM)));
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }
}

class BranchWarehouse {
  const BranchWarehouse(this.code, this.name);
  final String code;
  final String name;
}

class Vehicle {
  const Vehicle(this.code, this.name);
  final String code;
  final String name;
}

class WHTransfer {
  const WHTransfer(this.code, this.name);
  final String code;
  final String name;
}
