import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/branch_warehouse/branch_warehouse_transfer/batch_transfer.dart';
import 'package:vansale/screens/sale/sale_transfer_product/sale_batch_transfer.dart';

class SaleTransferProdMain extends StatefulWidget {
  const SaleTransferProdMain({Key key}) : super(key: key);

  @override
  State<SaleTransferProdMain> createState() => _SaleTransferProdMainState();
}

class _SaleTransferProdMainState extends State<SaleTransferProdMain> {
  BranchWarehouse selectedBranch;
  List<BranchWarehouse> branchWarehouses = <BranchWarehouse>[
    const BranchWarehouse("BCH002", 'สาขา ราชบุรี'),
    const BranchWarehouse("BCH003", 'สาขา หาดใหญ่')
  ];

  Vehicle selectedVehicle;
  List<Vehicle> vehicles = <Vehicle>[
    const Vehicle("V001", 'หมายเลขรถ 0001'),
    const Vehicle("V002", 'หมายเลขรถ 0002')
  ];

  WHTransfer selectedWHTransfer;
  List<WHTransfer> whTransfers = <WHTransfer>[
    const WHTransfer("001", 'โอนธรรมดา'),
    const WHTransfer("002", 'โอนเป็นชุด')
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedBranch = null;
    selectedVehicle = null;
    selectedWHTransfer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('โอนย้าย'),
      ),
      body: ListView(
        children: [
          branch(),
          vehicle(),
          whTransfer(),
        ],
      ),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget branch() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สาขา',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<BranchWarehouse>(
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
                  isExpanded: true,
                  value: selectedBranch,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                  onChanged: (BranchWarehouse newValue) {
                    setState(() {
                      selectedBranch = newValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return branchWarehouses.map((value) {
                      String color = '#00cb39';
                      if (value.code == null) {
                        color = '#68879A';
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: HexColor('$color'),
                            fontFamily: "Prompt",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      );
                    }).toList();
                  },
                  items: branchWarehouses.map((BranchWarehouse _warehouse) {
                    return new DropdownMenuItem<BranchWarehouse>(
                      value: _warehouse,
                      child: new Text(
                        _warehouse.name,
                        style: new TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicle() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'รถ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Vehicle>(
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
                  isExpanded: true,
                  value: selectedVehicle,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 16,
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                  onChanged: (Vehicle newValue) {
                    setState(() {
                      selectedVehicle = newValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return vehicles.map((value) {
                      String color = '#00cb39';
                      if (value.code == null) {
                        color = '#68879A';
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: HexColor('$color'),
                            fontFamily: "Prompt",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      );
                    }).toList();
                  },
                  items: vehicles.map((Vehicle _vehicle) {
                    return new DropdownMenuItem<Vehicle>(
                      value: _vehicle,
                      child: new Text(
                        _vehicle.name,
                        style: new TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget whTransfer() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'โอน',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<WHTransfer>(
                  hint: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "กรุณาเลือกการโอน",
                      style: TextStyle(
                        color: Colors.black26,
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
                    color: HexColor('#000000'),
                    // fontFamily: "Prompt",
                  ),
                  onChanged: (WHTransfer newValue) {
                    setState(() {
                      selectedWHTransfer = newValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return whTransfers.map((value) {
                      String color = '#00cb39';
                      if (value.code == null) {
                        color = '#68879A';
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: HexColor('$color'),
                            fontFamily: "Prompt",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      );
                    }).toList();
                  },
                  items: whTransfers.map((WHTransfer _whTransfer) {
                    return new DropdownMenuItem<WHTransfer>(
                      value: _whTransfer,
                      child: new Text(
                        _whTransfer.name,
                        style: new TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
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
                  if (selectedBranch == null) {
                    wrongDialog("กรุณาเลือกสาขา");
                  } else if (selectedVehicle == null) {
                    wrongDialog("กรุณาเลือกรถ");
                  } else if (selectedWHTransfer == null) {
                    wrongDialog("กรุณาเลือกการโอน");
                  } else {
                    switch (selectedWHTransfer.code) {
                      case "001":
                        break;
                      case "002":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SaleBatchTransfer(),
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
