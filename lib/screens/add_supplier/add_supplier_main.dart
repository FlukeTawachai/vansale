import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vansale/api/class/response/province/addressiteminfo.dart';
import 'package:vansale/api/webapiproxy.dart';
import 'package:vansale/screens/add_supplier/add_supplier_show_map.dart';

class AddSupplierMain extends StatefulWidget {
  final String typeMenuCode;
  AddSupplierMain(this.typeMenuCode);

  @override
  State<AddSupplierMain> createState() => _AddSupplierMainState();
}

class _AddSupplierMainState extends State<AddSupplierMain> {
  TextEditingController storeName = TextEditingController();
  TextEditingController address = TextEditingController();
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

  FocusNode nodeStoreTax = FocusNode();
  FocusNode nodeAddress = FocusNode();
  FocusNode nodeTel = FocusNode();
  FocusNode nodeContactName = FocusNode();
  FocusNode nodeContactTel = FocusNode();
  FocusNode nodeLine = FocusNode();
  late Future<bool> loadFunction;

  List<AddressItemInfo> lstProvices = [];
  List<AddressItemInfo> lstCities = [];
  List<AddressItemInfo> lstDistricts = [];

  var telFormatter = new MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

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
              // Row(
              //   children: [
              //     Expanded(
              //       child: mapBtn_(),
              //     ),
              //     Expanded(
              //       child: picProfile_(),
              //     ),
              //     Expanded(
              //       child: editBtn_(),
              //     ),
              //   ],
              // ),
              Expanded(
                child: ListView(
                  children: [
                    storeName_(widthScreen),
                    storeTax_(),
                    storeAddress_(),
                    // storeShipmentAddress_(),
                    province_(),
                    district_(),
                    subDistrict_(),
                    postCode_(),
                    // tel_(),
                    contactName_(),
                    contactTel_(),
                    line_(),
                    Container(height: 256),
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
                  AddSupplierShowMap(widget.typeMenuCode),
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

  Widget storeName_(double widthScreen) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ชื่อร้านค้า',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 48,
            // width: widthScreen * 0.72,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16),
                  controller: storeName,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeStoreTax);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget storeTax_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลขประจำตัวผู้เสียภาษี',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  focusNode: nodeStoreTax,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16),
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
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeAddress);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget storeAddress_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ที่อยู่',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  focusNode: nodeAddress,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16),
                  controller: address,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeContactName);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget storeShipmentAddress_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ที่จัดส่ง',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor('#00cb39'),
                      fontFamily: "Prompt",
                      fontSize: 16),
                  controller: storeName,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeContactName);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget province_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'จังหวัด',
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownProvince,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                    ),
                    onChanged: (newValue) async {
                      EasyLoading.show();
                      WebApiProxy proxy = WebApiProxy();
                      lstCities.clear();
                      var cities = AddressItemInfo(
                          name: 'เลือก', nameEN: "Select", postCode: '');
                      var allCities = await proxy.getCities(newValue ?? '');
                      lstCities.add(cities);
                      lstCities.addAll(allCities);
                      // lstCities = await proxy.getCities(newValue);

                      if (lstCities.isNotEmpty) {
                        lstDistricts.clear();
                        var districts = AddressItemInfo(
                            name: 'เลือก', nameEN: "Select", postCode: '');
                        var allDistricts = await proxy.getDistricts(
                            newValue ?? '', lstCities[0].name ?? '');
                        lstDistricts.add(districts);
                        lstDistricts.addAll(allDistricts);
                        // lstDistricts = await proxy.getDistricts(
                        //     newValue, lstCities[0].name);
                      }
                      EasyLoading.dismiss();

                      setState(() {
                        dropdownProvince = newValue ?? '';
                        dropdownDistrict = lstCities[0].name ?? '';
                        dropdownSubDistrict = lstDistricts[0].name ?? '';
                        postCode.text = lstDistricts[0].postCode ?? '';
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstProvices.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name ?? '',
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstProvices
                        .map<DropdownMenuItem<String>>((AddressItemInfo value) {
                      // dropdownProvinceColor = '#000000';
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(
                          value.name ?? '',
                          // style: TextStyle(
                          //     color: HexColor('${dropdownProvinceColor}')),
                        ),
                      );
                    }).toList(),
                  ),
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
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เขต/อำเภอ',
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownDistrict,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) async {
                      EasyLoading.show();
                      WebApiProxy proxy = WebApiProxy();
                      var allDistricts = await proxy.getDistricts(
                          dropdownProvince, newValue ?? '');

                      lstDistricts.addAll(allDistricts);
                      // print('++++++++++ ${lstDistricts[0].name} ++++++++++');
                      // lstDistricts =
                      //     await proxy.getDistricts(dropdownProvince, newValue);
                      EasyLoading.dismiss();

                      setState(() {
                        dropdownDistrict = newValue ?? '';
                        dropdownSubDistrict = lstDistricts[0].name ?? '';
                        // postCode.text = lstDistricts[0].postCode;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstCities.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name ?? '',
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstCities
                        .map<DropdownMenuItem<String>>((AddressItemInfo value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name ?? ''),
                      );
                    }).toList(),
                  ),
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
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'แขวง/ตำบล',
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownSubDistrict,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) {
                      var districtInfo =
                          lstDistricts.where((x) => x.name == newValue).first;

                      setState(() {
                        dropdownSubDistrict = newValue ?? '';
                        postCode.text = districtInfo.postCode ?? '';
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstDistricts.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name ?? '',
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstDistricts
                        .map<DropdownMenuItem<String>>((AddressItemInfo value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name ?? ''),
                      );
                    }).toList(),
                  ),
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
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'รหัสไปรษณีย์',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextFormField(
                readOnly: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
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
                      EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tel_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เบอร์โทร',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  focusNode: nodeTel,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
                  ),
                  inputFormatters: [
                    telFormatter,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  controller: tel,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeContactName);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactName_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ผู้ติดต่อ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  focusNode: nodeContactName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
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
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeContactTel);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactTel_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'เบอร์ติดต่อ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextField(
                  focusNode: nodeContactTel,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
                  ),
                  inputFormatters: [
                    telFormatter,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  controller: contactTel,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeLine);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget line_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ไลน์',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: TextFormField(
                focusNode: nodeLine,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
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
                      EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                ),
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
                    SizedBox(
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
                          AddSupplierShowMap(widget.typeMenuCode),
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

  Future initialLoad() async {
    WebApiProxy proxy = WebApiProxy();

    var defaultSelect =
        AddressItemInfo(name: 'เลือก', nameEN: "Select", postCode: '');
    var allProvices = await proxy.getAllProvinces();
    lstProvices.add(defaultSelect);
    lstCities.add(defaultSelect);
    lstDistricts.add(defaultSelect);
    lstProvices.addAll(allProvices);

    dropdownSubDistrict = lstDistricts[0].name ?? '';
    dropdownProvince = lstProvices[0].name ?? '';
    dropdownDistrict = lstCities[0].name ?? '';
    setState(() {});
  }
}
