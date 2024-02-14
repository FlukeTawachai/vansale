import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/ic_vp_icons.dart';

class MoneyNew extends StatefulWidget {
  final String typeMenuCode;
  MoneyNew(this.typeMenuCode);
  @override
  State<MoneyNew> createState() => _MoneyNewState();
}

class _MoneyNewState extends State<MoneyNew> {
  String dropdownName = 'ค่าซ่อมรถ';
  TextEditingController price = TextEditingController();
  TextEditingController remark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ส่งเงิน - บันทึกค่าใช้จ่าย'),
      ),
      body: ListView(
        children: [
          _name(),
          _price(),
          _remark(),
        ],
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  Widget _name() {
    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ค่าใช้จ่าย',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            height: 52.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownName,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Prompt",
                    color: HexColor("#a8a8a8"),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownName = newValue!;
                    });
                  },
                  items: <String>['ค่าซ่อมรถ', 'ค่า...']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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

  Widget _price() {
    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'จำนวนเงิน',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
              ),
              controller: price,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remark() {
    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'หมายเหตุ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.left,
              maxLines: 5,
              style: TextStyle(
                color: Colors.grey,
              ),
              controller: remark,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnSave() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 80.0,
      color: Colors.white,
      /*decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),*/
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icvp.check_circle_solid,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                        /*child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(30 / 360),
                          
                        ),*/
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'บันทึกค่าใช้จ่าย',
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
              // SizedBox(
              //   child: Divider(
              //     height: 5.0,
              //     indent: 105.0,
              //     endIndent: 100.0,
              //     thickness: 2.0,
              //     color: HexColor('#00cb39'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
