import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/delivery/delivery_show_map.dart';
import 'package:vansale/screens/new_supplier_main/new_supplier_show_map.dart';

enum Status { active, inactive }

class NewSupplierMain extends StatefulWidget {
  final String typeMenuCode;
  NewSupplierMain(this.typeMenuCode);

  @override
  State<NewSupplierMain> createState() => _NewSupplierMainState();
}

class _NewSupplierMainState extends State<NewSupplierMain> {
  TextEditingController storeName = TextEditingController();
  TextEditingController storeType = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController contactTel = TextEditingController();
  TextEditingController line = TextEditingController();
  TextEditingController credit = TextEditingController();
  TextEditingController limit = TextEditingController();

  MaskedTextController storeTax =
      MaskedTextController(mask: '0-0000-00000-00-0');
  String dropdownValue = 'ร้านค้าส่ง';
  String dropdownGroup = 'เงินสด';
  String dropdownProvince = 'กรุงเทพ';
  String dropdownDistrict = 'บางกะปิ';
  String dropdownSubDistrict = 'หัวหมาก';
  String dropdownBranch = 'สำนักงานใหญ่';
  String dropdownStoreType = 'เงินสด';
  String dropdownBasket = 'มัดจำ';
  String dropdownstoreGroup = 'ขายส่ง';
  String dropdownPriceTable = '001';
  String dropdownStoreAsset = 'ทรัพย์สิน1';
  String dropdownMon = 'สาย1';
  String dropdownTue = 'สาย1';
  String dropdownWed = 'สาย1';
  String dropdownThu = 'สาย1';
  String dropdownFri = 'สาย1';
  String dropdownSat = 'สาย1';
  String dropdownSun = 'สาย1';
  bool isMon = false;
  bool isTue = false;
  bool isWed = false;
  bool isThu = false;
  bool isFri = false;
  bool isSat = false;
  bool isSun = false;
  Status _data = Status.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('เพิ่มร้านค้า'),
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
                    location_(),
                    tel_(),
                    contactName_(),
                    contactTel_(),
                    line_(),
                    branch_(),
                    storeType_(),
                    creadit_(),
                    limit_(),
                    basket_(),
                    group_(),
                    priceTable_(),
                    storeAsset_(),
                    groupDate_(),
                    status_(),
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
          shape: CircleBorder(),
        ),
        child: Icon(
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
            child: CircleAvatar(
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
                  shape: CircleBorder(),
                ),
                child: Icon(
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
          shape: CircleBorder(),
        ),
        child: Icon(
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
            child: Text(
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

  Widget storeTax_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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
              decoration: new InputDecoration(
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
            child: Text(
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

  Widget storeShipmentAddress_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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

  Widget province_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownProvince = newValue;
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
            child: Text(
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
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownDistrict = newValue;
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
            child: Text(
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
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownSubDistrict = newValue;
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
            child: Text(
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

  Widget location_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'โลเคชั่น',
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

  Widget tel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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

  Widget contactName_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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

  Widget contactTel_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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

  Widget line_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
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

  Widget branch_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สาขา',
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
                  value: dropdownBranch,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownBranch = newValue;
                    });
                  },
                  items: <String>['สำนักงานใหญ่', 'สาขา ราชบุรี']
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

  Widget storeType_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ประเภทร้านค้า',
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
                  value: dropdownStoreType,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownStoreType = newValue;
                    });
                  },
                  items: <String>['เงินสด', 'เงินเชื่อ']
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

  Widget creadit_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เครดิต/วัน',
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
              controller: credit,
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

  Widget limit_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'วงเงินเครดิต/บาท',
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
              controller: limit,
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

  Widget basket_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ตะกร้า',
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
                  value: dropdownBasket,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownBasket = newValue;
                    });
                  },
                  items: <String>['มัดจำ', 'ไม่มัดจำ']
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

  Widget group_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'กลุ่มร้านค้า',
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
                  value: dropdownstoreGroup,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownstoreGroup = newValue;
                    });
                  },
                  items: <String>['ขายส่ง', 'ขายปลีก']
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

  Widget priceTable_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ตารางราคาขาย',
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
                  value: dropdownPriceTable,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownPriceTable = newValue;
                    });
                  },
                  items: <String>['001', '002']
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

  Widget storeAsset_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ทรัพย์สิน',
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
                  value: dropdownStoreAsset,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor("#a8a8a8"),
                    fontFamily: "Prompt",
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownStoreAsset = newValue;
                    });
                  },
                  items: <String>['ทรัพย์สิน1', 'ทรัพย์สิน2']
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

  Widget groupDate_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'กลุ่ม/สาย',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isMon,
                    onChanged: (bool value) {
                      setState(() {
                        isMon = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันจันทร์',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownMon,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownMon = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isTue,
                    onChanged: (bool value) {
                      setState(() {
                        isTue = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันอังคาร',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownTue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownTue = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isWed,
                    onChanged: (bool value) {
                      setState(() {
                        isWed = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันพุธ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownWed,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownWed = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isThu,
                    onChanged: (bool value) {
                      setState(() {
                        isThu = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันพฤหัส',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownThu,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownThu = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isFri,
                    onChanged: (bool value) {
                      setState(() {
                        isFri = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันศุกร์',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownFri,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownFri = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isSat,
                    onChanged: (bool value) {
                      setState(() {
                        isSat = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันเสาร์',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownSat,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownSat = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isSun,
                    onChanged: (bool value) {
                      setState(() {
                        isSun = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'กลุ่มวันอาทิตย์',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                          value: dropdownSun,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#a8a8a8"),
                            fontFamily: "Prompt",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownSun = newValue;
                            });
                          },
                          items: <String>['สาย1', 'สาย2']
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget status_() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'สถานะ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Radio<Status>(
                    value: Status.active,
                    groupValue: _data,
                    onChanged: (Status value) {
                      setState(() {
                        _data = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'ใช้งาน',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Radio<Status>(
                    value: Status.inactive,
                    groupValue: _data,
                    onChanged: (Status value) {
                      setState(() {
                        _data = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'ไม่ใช้งาน',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
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
                            child: Icon(
                              LineAwesomeIcons.times_circle,
                              size: 25.0,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //alignment: Alignment.centerLeft,
                            child: Text(
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
                    /*SizedBox(
                      child: Divider(
                        height: 5.0,
                        indent: 65.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                        color: Colors.black45,
                      ),
                    ),*/
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
                          NewSupplierShowMap(widget.typeMenuCode),
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
                    /*SizedBox(
                      child: Divider(
                        height: 5.0,
                        indent: 65.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),*/
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
