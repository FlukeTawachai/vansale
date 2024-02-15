import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';

class RefuelEdit extends StatefulWidget {
  final String typeMenuCode;
  RefuelEdit(this.typeMenuCode);

  @override
  State<RefuelEdit> createState() => _RefuelEditState();
}

class _RefuelEditState extends State<RefuelEdit> {
  TextEditingController locationName =
      TextEditingController(text: 'บีพี หาดใหญ่');
  TextEditingController mile = TextEditingController(text: '258,633');
  TextEditingController distance = TextEditingController(text: '400');
  TextEditingController rate = TextEditingController(text: '10.5');
  TextEditingController qty = TextEditingController(text: '40.00');
  TextEditingController price = TextEditingController(text: '20.00');
  TextEditingController totalprice = TextEditingController(text: '1,200.00');
  String dropdownFuel = 'ดีเซล';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('บันทึกการเติมน้ำมัน'),
      ),
      backgroundColor: HexColor("#F2F3F4"),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  height: 70.0,
                  alignment: Alignment.center,
                  color: HexColor("#8291a9"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: location_(),
                      ),
                      Container(
                        child: btnEdit_(),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        picProfile_(),
                        countImage_(),
                        btnCamera_(),
                      ],
                    ),
                    locationName_(),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: fuel_(),
                          ),
                          Expanded(
                            child: mile_(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: distance_(),
                          ),
                          Expanded(
                            child: rate_(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: qty_(),
                          ),
                          Expanded(
                            child: price_(),
                          ),
                          Expanded(
                            child: totalprice_(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buttonBar_(),
      resizeToAvoidBottomInset: true,
    );
  }

  //Widget ......
  Widget location_() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            width: 30.0,
            child: Icon(
              LineAwesomeIcons.map_marker,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: AutoSizeText(
              'data',
              minFontSize: 10.0,
              maxFontSize: 16.0,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnEdit_() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: HexColor("#a5b4c7"),
          shape: CircleBorder(),
        ),
        child: Icon(
          LineAwesomeIcons.edit,
          color: Colors.white,
          size: 25.0,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget picProfile_() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(150.0),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/Image.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget countImage_() {
    return Positioned(
      top: 40.0,
      right: 105.0,
      child: Container(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
          ),
          child: Text(
            '5+',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget btnCamera_() {
    return Positioned(
      top: 40.0,
      right: 5.0,
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: HexColor("#a5b4c7"),
            shape: CircleBorder(),
          ),
          child: Container(
            height: 40.0,
            child: Icon(
              LineAwesomeIcons.camera,
              color: Colors.black,
              size: 25.0,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget locationName_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สถานที่เติม',
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
              controller: locationName,
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

  Widget fuel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เชื้อเพลิง',
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
                  value: dropdownFuel,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Prompt",
                    color: HexColor("#a8a8a8"),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownFuel = newValue!;
                    });
                  },
                  items: <String>['ดีเซล', 'เบนซิน']
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

  Widget mile_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลขไมล์',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
              controller: mile,
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

  Widget distance_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ระยะทาง (Km)',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#a5b4c7"),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              readOnly: true,
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: distance,
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

  Widget rate_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สิ้นเปลือง กม/ล.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#a5b4c7"),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              readOnly: true,
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: rate,
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

  Widget qty_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'จำนวนลิตร',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
              controller: qty,
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

  Widget price_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ราคาลิตรละ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
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

  Widget totalprice_() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ราคารวม',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
              controller: totalprice,
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

  Widget buttonBar_() {
    return Container(
      height: 130.0,
      decoration: BoxDecoration(
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
      ),
      child: ListView(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      'ราคารวม',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                    alignment: Alignment.centerRight,
                    child: Utility.formateNumberOrangeSym(1200.00),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20.0, top: 10.0),
            alignment: Alignment.centerRight,
            child: Text(
              'โปรดตรวจสอบราคารวม',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.white,
            child: Container(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ConfirmPage(
                          widget.typeMenuCode,
                          'บันทึกการเติมน้ำมัน',
                          'เรียบร้อยแล้ว'),
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
                                turns: new AlwaysStoppedAnimation(0 / 360),
                                child: Icon(
                                  LineAwesomeIcons.check_circle,
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
                                'บันทึก',
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
                      //     indent: 150.0,
                      //     endIndent: 150.0,
                      //     thickness: 2.0,
                      //     color: HexColor('#00cb39'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
