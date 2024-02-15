import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/delivery/delivery_show_map.dart';

class DeliveryCustomerMain extends StatefulWidget {
  final String typeMenuCode;
  DeliveryCustomerMain(this.typeMenuCode);

  @override
  State<DeliveryCustomerMain> createState() => _DeliveryCustomerMainState();
}

class _DeliveryCustomerMainState extends State<DeliveryCustomerMain> {
  TextEditingController storeName = TextEditingController();
  TextEditingController storeType = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController contactTel = TextEditingController();
  TextEditingController line = TextEditingController();
  MaskedTextController storeTax =
      MaskedTextController(mask: '0-0000-00000-00-0');
  String dropdownValue = 'ร้านค้าส่ง';
  String dropdownGroup = 'เงินสด';
  String dropdownProvince = 'กรุงเทพ';
  String dropdownDistrict = 'บางกะปิ';
  String dropdownSubDistrict = 'หัวหมาก';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('เพิ่มร้านค้า'),
      ),
      backgroundColor: HexColor("#F2F3F4"),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: mapBtn_(),
                  ),
                  Expanded(
                    child: picProfile_(),
                  ),
                  Expanded(
                    child: editBtn_(),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    storeName_(),
                    storeTax_(),
                    storeAddress_(),
                    storeShipmentAddress_(),
                    province_(),
                    district_(),
                    subDistrict_(),
                    postCode_(),
                    tel_(),
                    contactName_(),
                    contactTel_(),
                    line_(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buttonBar_(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget mapBtn_() {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.only(top: 20.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: HexColor("#6c7e9b"),
          shape: const CircleBorder(),
        ),
        child: const Icon(
          LineAwesomeIcons.crosshairs,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  DeliveryShowMap(widget.typeMenuCode),
            ),
          );
        },
      ),
    );
  }

  Widget picProfile_() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        children: [
          Container(
            height: 115.0,
            //width: 120.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(150.0),
              border: Border.all(
                width: 1,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.0,
              backgroundImage: AssetImage('assets/images/Image.png'),
            ),
          ),
          Positioned(
            top: 60.0,
            right: 7.0,
            child: Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  LineAwesomeIcons.camera,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editBtn_() {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.only(top: 20.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black12,
          shape: const CircleBorder(),
        ),
        child: const Icon(
          LineAwesomeIcons.edit,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget storeName_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ชื่อร้านค้า',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: storeName,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget storeTax_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'เลขประจำตัวผู้เสียภาษี',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              controller: storeTax,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: '0-0000-00000-00-0',
                hintStyle: TextStyle(color: Colors.grey),
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

  Widget storeAddress_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ที่อยู่',
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
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: storeName,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget storeShipmentAddress_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ที่จัดส่ง',
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
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: storeName,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget province_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'จังหวัด',
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
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownProvince,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownProvince = newValue!;
                    });
                  },
                  items: <String>['กรุงเทพ', 'กาญจนบุรี']
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

  Widget district_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'เขต/อำเภอ',
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
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownDistrict,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownDistrict = newValue!;
                    });
                  },
                  items: <String>['บางกะปิ', 'วังทองหลาง']
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

  Widget subDistrict_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'แขวง/ตำบล',
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
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownSubDistrict,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownSubDistrict = newValue!;
                    });
                  },
                  items: <String>['หัวหมาก', 'วังทองหลาง']
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

  Widget postCode_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'รหัสไปรษณีย์',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              readOnly: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: postCode,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget tel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'เบอร์โทร',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: tel,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget contactName_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ผู้ติดต่อ',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: contactName,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget contactTel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'เบอร์ติดต่อ',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: contactTel,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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

  Widget line_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ไลน์',
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
              textAlign: TextAlign.left,
              style: TextStyle(
                color: HexColor('#00cb39'),
              ),
              controller: line,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
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
      height: 60.0,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
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
                            child: const Icon(
                              LineAwesomeIcons.times_circle,
                              size: 25.0,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //alignment: Alignment.centerLeft,
                            child: const Text(
                              'ยกเลิก',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      child: Divider(
                        height: 5.0,
                        indent: 65.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DeliveryShowMap(widget.typeMenuCode),
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
                            child: Icon(
                              LineAwesomeIcons.check_circle,
                              size: 25.0,
                              color: HexColor('#00cb39'),
                            ),
                          ),
                          const SizedBox(
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
                    SizedBox(
                      child: Divider(
                        height: 5.0,
                        indent: 65.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
