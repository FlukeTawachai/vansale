import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/apiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/api/class/request/mobile/searchBasket.dart';
import 'package:vansale/api/class/response/branch/branchinfo.dart';
import 'package:vansale/api/class/response/mapsalebranch/mapsalebranchinfo.dart';
import 'package:vansale/api/class/response/province/addressiteminfo.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeinfo.dart';
import 'package:vansale/api/webapiproxy.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_location.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_show_map.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum Status { active, inactive }

class DeliveryNewSupplierMain extends StatefulWidget {
  final String typeMenuCode;
  DeliveryNewSupplierMain(this.typeMenuCode);

  @override
  State<DeliveryNewSupplierMain> createState() =>
      _DeliveryNewSupplierMainState();
}

class _DeliveryNewSupplierMainState extends State<DeliveryNewSupplierMain> {
  TextEditingController storeName = TextEditingController();
  TextEditingController storeType = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController contactTel = TextEditingController();
  TextEditingController line = TextEditingController();
  TextEditingController credit = TextEditingController();
  TextEditingController limit = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController shipTo = TextEditingController();
  TextEditingController storeLocation = TextEditingController();
  TextEditingController storeAssetNumber = TextEditingController();
  TextEditingController storeDistance = TextEditingController();

  FocusNode nodeStoreTax = FocusNode();
  FocusNode nodeAddress = FocusNode();
  FocusNode nodeStoreLocation = FocusNode();
  FocusNode nodeStoreDistance = FocusNode();
  FocusNode nodeTel = FocusNode();
  FocusNode nodeContactName = FocusNode();
  FocusNode nodeContactTel = FocusNode();
  FocusNode nodeLine = FocusNode();
  FocusNode nodeLimit = FocusNode();
  FocusNode nodeCredit = FocusNode();

  MaskedTextController storeTax =
      MaskedTextController(mask: '0-0000-00000-00-0');
  String dropdownValue = 'Wholesale';
  String dropdownGroup = 'เงินสด';
  String dropdownProvince = 'กรุงเทพ';
  String dropdownDistrict = 'บางกะปิ';
  String dropdownSubDistrict = 'หัวหมาก';
  String dropdownBranch = '';
  String dropdownStoreType = 'Cash';
  String dropdownBasket = 'Y';
  String dropdownstoreGroup = 'Wholesale';
  String dropdownPriceTable = '001';
  String dropdownStoreAsset = '0001';
  String dropdownMon = '';
  String dropdownTue = '';
  String dropdownWed = '';
  String dropdownThu = '';
  String dropdownFri = '';
  String dropdownSat = '';
  String dropdownSun = '';
  String dropdownTest = '1';
  bool isMon = false;
  bool isTue = false;
  bool isWed = false;
  bool isThu = false;
  bool isFri = false;
  bool isSat = false;
  bool isSun = false;

  bool isMon_ = false;
  bool isTue_ = false;
  bool isWed_ = false;
  bool isThu_ = false;
  bool isFri_ = false;
  bool isSat_ = false;
  bool isSun_ = false;

  Status _data = Status.active;
  List<AddressItemInfo> lstProvices = [];
  List<AddressItemInfo> lstCities = [];
  List<AddressItemInfo> lstDistricts = [];
  List<RouteInfo> lstMondayRoutes = [];
  List<RouteInfo> lstTuesdayRoutes = [];
  List<RouteInfo> lstWednesDayRoutes = [];
  List<RouteInfo> lstThursdayRoutes = [];
  List<RouteInfo> lstFridayRoutes = [];
  List<RouteInfo> lstSaturdayRoutes = [];
  List<RouteInfo> lstSundayRoutes = [];
  late Future<bool> loadFunction;
  late List<Map<String, String>> lstBasket;
  late List<Map<String, String>> lstShopType;
  late List<Map<String, String>> lstShopGroup;
  List<BranchInfo> lstBranch = [];
  List<MapBranchSaleInfo> lstSaleTable = [];
  List<Map<String, String>> lstAsset = [
    {"Text": "เลือก", "Value": ""},
    {"Text": "ร้านค้าสั่งซื้อ", "Value": "M"},
    {"Text": "สั่งซื้ออัตโนมัติ", "Value": "A"},
  ];
  late List<Map<String, String>> lstTestColor;
  late PickedFile? imageFile;
  // final ImagePicker _picker = ImagePicker();
  late File file;
  var telFormatter = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void initState() {
    super.initState();

    credit.text = '0';
    limit.text = '0';

    lstBasket = [
      {"Text": "เลือก", "Value": ""},
      {"Text": "มัดจำ", "Value": "Y"},
      {"Text": "ไม่มัดจำ", "Value": "N"}
    ];

    lstShopType = [
      {"Text": "เลือก", "Value": ""},
      {"Text": "ค้าปลีก", "Value": "Retail"},
      {"Text": "ค้าส่ง", "Value": "Wholesale"},
    ];

    lstShopGroup = [
      {"Text": "เลือก", "Value": ""},
      {"Text": "เงินสด", "Value": "Cash"},
      // {"Text": "เงินเชื่อ", "Value": "Credit"}
    ];

    loadFunction = initialLoad();

    dropdownstoreGroup = '';
    dropdownStoreAsset = '';
    dropdownGroup = '';
    dropdownBranch = '';
    dropdownStoreType = 'Cash';
    dropdownBasket = '';
    dropdownPriceTable = '';
    // getBasket(SearchBasketReq(cBASKCD: '%%', cBASKNM: '%%'));
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: loadFunction,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

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
                        branch_(),
                        storeName_(widthScreen),
                        storeTax_(),
                        storeAddress_(),
                        // storeShipmentAddress_(),
                        province_(),
                        district_(),
                        subDistrict_(),
                        postCode_(),
                        // location_(),
                        // distance_(),
                        // tel_(),
                        contactName_(),
                        contactTel_(),
                        line_(),

                        storeType_(),
                        // creadit_(),
                        // limit_(),
                        group_(),
                        priceTable_(),
                        basket_(),
                        // storeAsset_(widthScreen),
                        groupDate_(widthScreen),
                        // status_(),
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
      },
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
          saveData();
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
            // child: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   radius: 60.0,
            //   backgroundImage: imageFile == null
            //       ? const AssetImage('assets/images/Image.png')
            //       : FileImage(
            //           File(_image.path),
            //         ),
            // ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60.0,
              child: imageFile == null
                  ? Image.asset('assets/images/Image.png')
                  : Image.file(File(imageFile!.path)),
            ),
          ),
          Positioned(
            top: 60.0,
            right: 7.0,
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
              onPressed: () {
                actionsheet(context);
              },
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

  Widget storeName_(double widthScreen) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
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
                    fontSize: 16,
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
            child: const Text(
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
            child: TextField(
                focusNode: nodeStoreTax,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: storeTax,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: '0-0000-00000-00-0',
                  hintStyle: TextStyle(color: HexColor('#68879A')),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 15, right: 15),
                ),
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(nodeAddress);
                }),
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
            child: const Text(
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
                    fontSize: 16,
                  ),
                  controller: address,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeStoreLocation);
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
            child: const Text(
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
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
                ),
                controller: shipTo,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
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

  Widget province_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
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
                      var allCities = await proxy.getCities(newValue!);
                      lstCities.add(cities);
                      lstCities.addAll(allCities);
                      // lstCities = await proxy.getCities(newValue);

                      if (lstCities.isNotEmpty) {
                        lstDistricts.clear();
                        var districts = AddressItemInfo(
                            name: 'เลือก', nameEN: "Select", postCode: '');
                        var allDistricts = await proxy.getDistricts(
                            newValue, lstCities[0].name ?? '');
                        lstDistricts.add(districts);
                        lstDistricts.addAll(allDistricts);
                        // lstDistricts = await proxy.getDistricts(
                        //     newValue, lstCities[0].name);
                      }
                      EasyLoading.dismiss();

                      setState(() {
                        dropdownProvince = newValue;
                        dropdownDistrict = lstCities[0].name!;
                        dropdownSubDistrict = lstDistricts[0].name!;
                        postCode.text = lstDistricts[0].postCode!;
                      });
                      FocusScope.of(context).requestFocus(nodeStoreLocation);
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstProvices.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name!,
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
                          value.name!,
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
            child: const Text(
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
                      var allDistricts =
                          await proxy.getDistricts(dropdownProvince, newValue!);

                      lstDistricts.addAll(allDistricts);
                      // print('++++++++++ ${lstDistricts[0].name} ++++++++++');
                      // lstDistricts =
                      //     await proxy.getDistricts(dropdownProvince, newValue);
                      EasyLoading.dismiss();

                      setState(() {
                        dropdownDistrict = newValue;
                        dropdownSubDistrict = lstDistricts[0].name!;
                        // postCode.text = lstDistricts[0].postCode;
                      });
                      FocusScope.of(context).requestFocus(nodeStoreLocation);
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstCities.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name!,
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
                        child: Text(value.name!),
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
            child: const Text(
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
                        dropdownSubDistrict = newValue!;
                        postCode.text = districtInfo.postCode!;
                      });
                      FocusScope.of(context).requestFocus(nodeStoreLocation);
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstDistricts.map((value) {
                        String color = '#00cb39';
                        if (value.name == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.name!,
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
                        child: Text(value.name!),
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
            child: const Text(
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
                decoration: const InputDecoration(
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

  Widget location_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'จุดสังเกต',
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
                  focusNode: nodeStoreLocation,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
                  ),
                  controller: storeLocation,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeStoreDistance);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget distance_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ระยะห่างจากสาขาถึงร้านค้า(กิโลเมตร)',
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
                  focusNode: nodeStoreDistance,
                  // maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
                  ),
                  controller: storeDistance,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(nodeTel);
                  }),
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
            child: const Text(
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    telFormatter,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 16,
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
            child: const Text(
              'ชื่อผู้ติดต่อ',
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
                  decoration: const InputDecoration(
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
            child: const Text(
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    telFormatter,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: HexColor('#00cb39'),
                    fontFamily: "Prompt",
                    fontSize: 14,
                  ),
                  controller: contactTel,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: '000-000-0000',
                    hintStyle: TextStyle(color: HexColor('#68879A')),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 0, top: 0, right: 15),
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
            child: const Text(
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
              child: TextField(
                focusNode: nodeLine,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
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
                      EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget branch_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownBranch,
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
                      ApiProxyMobile proxy2 = ApiProxyMobile();
                      // lstSaleTable = await proxy.getAllMapBranchSale(newValue);
                      // if (lstSaleTable.isEmpty) {
                      //   lstSaleTable = [
                      //     MapBranchSaleInfo(priceCode: '', priceName: 'เลือก')
                      //   ];
                      // }

                      // reset
                      setState(() {
                        dropdownProvince = 'เลือก';
                        dropdownDistrict = 'เลือก';
                        dropdownSubDistrict = 'เลือก';
                        postCode.text = '';
                        dropdownPriceTable = '';
                        dropdownMon = '';
                        dropdownTue = '';
                        dropdownWed = '';
                        dropdownThu = '';
                        dropdownFri = '';
                        dropdownSat = '';
                        dropdownSun = '';
                      });

                      var defaultSelect = AddressItemInfo(
                          name: 'เลือก', nameEN: "Select", postCode: '');

                      lstMondayRoutes = [];
                      lstTuesdayRoutes = [];
                      lstWednesDayRoutes = [];
                      lstThursdayRoutes = [];
                      lstFridayRoutes = [];
                      lstSaturdayRoutes = [];
                      lstSundayRoutes = [];
                      lstProvices = [];
                      lstDistricts = [];
                      lstCities = [];
                      lstSaleTable = [];
                      lstProvices.add(defaultSelect);
                      lstCities.add(defaultSelect);
                      lstDistricts.add(defaultSelect);
                      lstSaleTable = [
                        MapBranchSaleInfo(priceCode: '', priceName: 'เลือก')
                      ];

                      if (newValue!.isNotEmpty) {
                        var dd = Uri.parse(newValue)
                            .toString()
                            .replaceAll(r'%09', '');
                        var allProvices = await proxy2.getProvincescBRANCD(dd);
                        var tableAll = await proxy.getAllMapBranchSale(dd);
                        var tableAll_ = tableAll
                            .where((element) => element.priceSelected == 'Y')
                            .toList();
                        lstSaleTable.addAll(tableAll_);

                        if (allProvices.success == true) {
                          for (var x in allProvices.result) {
                            lstProvices.add(AddressItemInfo(
                                name: x['cNAME'] ?? '',
                                nameEN: x['cNAME_EN'] ?? '',
                                postCode: x['cPOSTCODE'] ?? ''));
                          }
                          var allRoutes = await proxy.getAllRoutes();
                          var allRoutes_ = allRoutes
                              .where((element) => element.branch == dd)
                              .toList();
                          lstMondayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRMON')
                              .toList();
                          lstTuesdayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRTUE')
                              .toList();
                          lstWednesDayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRWED')
                              .toList();
                          lstThursdayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRTHU')
                              .toList();
                          lstFridayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRFRI')
                              .toList();
                          lstSaturdayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRSAT')
                              .toList();
                          lstSundayRoutes = allRoutes_
                              .where((element) => element.groupCode == 'GRSUN')
                              .toList();
                        } else {}
                      } else {}

                      lstMondayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstTuesdayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstWednesDayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstThursdayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstFridayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstSaturdayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
                      lstSundayRoutes.insert(
                          0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));

                      EasyLoading.dismiss();

                      setState(() {
                        dropdownBranch = newValue;
                        dropdownPriceTable = lstSaleTable[0].priceCode!;
                      });

                      // FocusScope.of(context).requestFocus(nodeCredit);
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstBranch.map((value) {
                        String color = '#00cb39';
                        if (value.branchName == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.branchName!,
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstBranch
                        .map<DropdownMenuItem<String>>((BranchInfo value) {
                      return DropdownMenuItem<String>(
                        value: value.branchCode,
                        child: Text(value.branchName!),
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

  Widget storeType_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ประเภทร้านค้า',
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
                    value: dropdownStoreType,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownStoreType = newValue!;
                      });
                      FocusScope.of(context).requestFocus(nodeCredit);
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstShopGroup.map((value) {
                        String color = '#00cb39';
                        if (value["Text"] == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value["Text"]!,
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstShopGroup.map<DropdownMenuItem<String>>(
                        (Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value["Value"],
                        child: Text(value["Text"]!),
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

  Widget creadit_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'เครดิต/วัน',
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
            child: TextField(
                focusNode: nodeCredit,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
                ),
                controller: credit,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                ),
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(nodeLimit);
                }),
          ),
        ],
      ),
    );
  }

  Widget limit_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'วงเงินเครดิต/บาท',
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
                focusNode: nodeLimit,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: HexColor('#00cb39'),
                  fontFamily: "Prompt",
                  fontSize: 16,
                ),
                controller: limit,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                ),
                onChanged: (string) {
                  string = _formatNumber(string.replaceAll(',', ''));
                  limit.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget basket_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ตะกร้า',
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
                    value: dropdownBasket,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownBasket = newValue!;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstBasket.map((value) {
                        String color = '#00cb39';
                        if (value["Text"] == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value["Text"]!,
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstBasket.map<DropdownMenuItem<String>>(
                        (Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value["Value"],
                        child: Text(value["Text"]!),
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

  Widget group_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'กลุ่มร้านค้า',
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
                    value: dropdownstoreGroup,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownstoreGroup = newValue!;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstShopType.map((value) {
                        String color = '#00cb39';
                        if (value["Text"] == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value["Text"]!,
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstShopType.map<DropdownMenuItem<String>>(
                        (Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value["Value"],
                        child: Text(value["Text"]!),
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

  Widget priceTable_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'ตารางราคาขาย',
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
                    value: dropdownPriceTable,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontFamily: "Prompt",
                      fontSize: 16,
                      color: HexColor('#000000'),
                      // fontFamily: "Prompt",
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownPriceTable = newValue!;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return lstSaleTable.map((value) {
                        String color = '#00cb39';
                        if (value.priceName == 'เลือก') {
                          color = '#68879A';
                        }
                        return Text(
                          value.priceName!,
                          style: TextStyle(
                              color: HexColor(color),
                              fontFamily: "Prompt",
                              fontSize: 16),
                        );
                      }).toList();
                    },
                    items: lstSaleTable.map<DropdownMenuItem<String>>(
                        (MapBranchSaleInfo value) {
                      return DropdownMenuItem<String>(
                        value: value.priceCode,
                        child: Text(value.priceName!),
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

  Widget storeAsset_(double widthSreen) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: widthSreen * 0.39,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'วิธีการสั้งซื้อ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // Spacer(),
              // Container(
              //   width: widthSreen * 0.48,
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'จำนวน',
              //     style: TextStyle(
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 48,
                width: widthSreen * 0.9,
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
                        value: dropdownStoreAsset,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 14,
                          color: HexColor('#000000'),
                          // fontFamily: "Prompt",
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownStoreAsset = newValue!;
                          });
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return lstAsset.map((value) {
                            String color = '#00cb39';
                            if (value['Text'] == 'เลือก') {
                              color = '#68879A';
                            }
                            return Text(
                              value["Text"]!,
                              style: TextStyle(
                                  color: HexColor(color),
                                  fontFamily: "Prompt",
                                  fontSize: 16),
                            );
                          }).toList();
                        },
                        items: lstAsset.map<DropdownMenuItem<String>>(
                            (Map<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value["Value"],
                            child: Text(value["Text"]!),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(),
              // Container(
              //   height: 48,
              //   width: widthSreen * 0.48,
              //   alignment: Alignment.centerLeft,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.circular(5.0),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextField(
              //       // textInputAction: TextInputAction.next,
              //       keyboardType: TextInputType.number,
              //       inputFormatters: <TextInputFormatter>[
              //         FilteringTextInputFormatter.digitsOnly
              //       ],
              //       style: TextStyle(
              //         color: HexColor('#00cb39'),
              //         fontFamily: "Prompt",
              //         fontSize: 14,
              //       ),
              //       controller: storeAssetNumber,
              //       decoration: new InputDecoration(
              //         border: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorBorder: InputBorder.none,
              //         disabledBorder: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget groupDate_(double widthSreen) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'กลุ่ม/สาย',
              style: TextStyle(
                color: Colors.black,
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
                    onChanged: (value) {
                      setState(() {
                        isMon = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันจันทร์',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isMon_,
                    onChanged: isMon
                        ? (value) {
                            setState(() {
                              isMon_ = value!;
                            });
                          }
                        : null,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownMon,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isMon
                                ? (newValue) {
                                    setState(() {
                                      dropdownMon = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstMondayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstMondayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
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
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isTue,
                  onChanged: (value) {
                    setState(() {
                      isTue = value!;
                    });
                  },
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันอังคาร',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isTue_,
                  onChanged: isTue
                      ? (value) {
                          setState(() {
                            isTue_ = value!;
                          });
                        }
                      : null,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownTue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isTue
                                ? (newValue) {
                                    setState(() {
                                      dropdownTue = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstTuesdayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstTuesdayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isWed,
                  onChanged: (value) {
                    setState(() {
                      isWed = value!;
                    });
                  },
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันพุธ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isWed_,
                  onChanged: isWed
                      ? (value) {
                          setState(() {
                            isWed_ = value!;
                          });
                        }
                      : null,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownWed,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isWed
                                ? (newValue) {
                                    setState(() {
                                      dropdownWed = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstWednesDayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstWednesDayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
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
                    onChanged: (value) {
                      setState(() {
                        isThu = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันพฤหัส',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isThu_,
                    onChanged: isThu
                        ? (value) {
                            setState(() {
                              isThu_ = value!;
                            });
                          }
                        : null,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownThu,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isThu
                                ? (newValue) {
                                    setState(() {
                                      dropdownThu = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstThursdayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstThursdayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isFri,
                  onChanged: (value) {
                    setState(() {
                      isFri = value!;
                    });
                  },
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันศุกร์',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: HexColor("#4e73be"),
                    value: isFri_,
                    onChanged: isFri
                        ? (value) {
                            setState(() {
                              isFri_ = value!;
                            });
                          }
                        : null,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownFri,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isFri
                                ? (newValue) {
                                    setState(() {
                                      dropdownFri = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstFridayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstFridayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isSat,
                  onChanged: (value) {
                    setState(() {
                      isSat = value!;
                    });
                  },
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันเสาร์',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isSat_,
                  onChanged: isSat
                      ? (value) {
                          setState(() {
                            isSat_ = value!;
                          });
                        }
                      : null,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownSat,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isSat
                                ? (newValue) {
                                    setState(() {
                                      dropdownSat = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstSaturdayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstSaturdayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isSun,
                  onChanged: (value) {
                    setState(() {
                      isSun = value!;
                    });
                  },
                ),
                SizedBox(
                  width: widthSreen * 0.18,
                  child: const Text(
                    'วันอาทิตย์',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: HexColor("#4e73be"),
                  value: isSun_,
                  onChanged: isSun
                      ? (value) {
                          setState(() {
                            isSun_ = value!;
                          });
                        }
                      : null,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    width: widthSreen * 0.48,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownSun,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 14,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: isSun
                                ? (newValue) {
                                    setState(() {
                                      dropdownSun = newValue!;
                                    });
                                  }
                                : null,
                            selectedItemBuilder: (BuildContext context) {
                              return lstSundayRoutes.map((value) {
                                if (value.routeCode == '') {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#68879A'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                } else {
                                  return Text(
                                    value.routeName!,
                                    style: TextStyle(
                                        color: HexColor('#00cb39'),
                                        fontFamily: "Prompt",
                                        fontSize: 14),
                                  );
                                }
                              }).toList();
                            },
                            items: lstSundayRoutes
                                .map<DropdownMenuItem<String>>(
                                    (RouteInfo value) {
                              return DropdownMenuItem<String>(
                                value: value.routeCode,
                                child: Text(value.routeName!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget status_() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'สถานะ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Radio<Status>(
                value: Status.active,
                groupValue: _data,
                onChanged: (value) {
                  setState(() {
                    _data = value!;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  'ใช้งาน',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Radio<Status>(
                value: Status.inactive,
                groupValue: _data,
                onChanged: (value) {
                  setState(() {
                    _data = value!;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  'ไม่ใช้งาน',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
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
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
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
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                onTap: () {
                  String output = storeName.text.replaceAll(' ', '');
                  if (output == '') {
                    wrongDialog('กรุณาระบุชื่อร้าน');
                  } else {
                    if (dropdownProvince == 'เลือก') {
                      wrongDialog('กรุณาเลือกจังหวัด');
                    } else {
                      if (dropdownDistrict == 'เลือก') {
                        wrongDialog('กรุณาเลือกเขต/อำเภอ');
                      } else {
                        if (dropdownSubDistrict == 'เลือก') {
                          wrongDialog('กรุณาเลือกแขวง/ตำบล');
                        } else {
                          if (dropdownBranch == 'เลือก' ||
                              dropdownBranch == '') {
                            wrongDialog('กรุณาเลือกสาขา');
                          } else {
                            if (dropdownStoreType == 'เลือก' ||
                                dropdownStoreType == '') {
                              wrongDialog('กรุณาเลือกประเภทร้านค้า');
                            } else {
                              if (dropdownstoreGroup == 'เลือก' ||
                                  dropdownstoreGroup == '') {
                                wrongDialog('กรุณาเลือกกลุ่มร้านค้า');
                              } else {
                                if (dropdownPriceTable == 'เลือก' ||
                                    dropdownPriceTable == '') {
                                  wrongDialog('กรุณาเลือกตารางราคาขาย');
                                } else {
                                  if (dropdownBasket == 'เลือก' ||
                                      dropdownBasket == '') {
                                    wrongDialog('กรุณาเลือกตะกร้า');
                                  } else {
                                    saveData();
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
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

  actionsheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'ยกเลิก',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  openCamera();
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ถ่ายภาพ',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  selectImage();
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'เลือกรูปภาพ',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  late File _image;
  Future<void> openCamera() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile!.path);
      GlobalParam.deliveryImage = File(imageFile!.path);
      //EasyLoading.dismiss();
    });
  }

  Future<void> selectImage() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile!.path);
      GlobalParam.deliveryImage = File(imageFile!.path);
      // EasyLoading.dismiss();
    });
  }

  Future<bool> initialLoad() async {
    WebApiProxy proxy = WebApiProxy();

    dropdownStoreType = 'Cash';
    dropdownBasket = 'Y';
    dropdownstoreGroup = 'Wholesale';
    dropdownPriceTable = '001';
    dropdownStoreAsset = '0001';

    var defaultSelect =
        AddressItemInfo(name: 'เลือก', nameEN: "Select", postCode: '');
    lstProvices.add(defaultSelect);
    lstCities.add(defaultSelect);
    lstDistricts.add(defaultSelect);

    dropdownSubDistrict = lstDistricts[0].name!;
    dropdownProvince = lstProvices[0].name!;
    dropdownDistrict = lstCities[0].name!;
    //String province = '';
    // if (lstProvices.isNotEmpty) {
    //   dropdownProvince = lstProvices[0].name;
    //   lstCities = await proxy.getCities(dropdownProvince);
    // }

    // if (lstCities.isNotEmpty) {
    // dropdownDistrict = lstCities[0].name;
    //   lstDistricts =
    //       await proxy.getDistricts(dropdownProvince, dropdownDistrict);
    // }

    // if (lstDistricts.isNotEmpty) {
    //   dropdownSubDistrict = lstDistricts[0].name;
    //   postCode.text = lstDistricts[0].postCode;
    // }
    lstMondayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstTuesdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstWednesDayRoutes.insert(
        0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstThursdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstFridayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstSaturdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstSundayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));

    lstBranch.add(BranchInfo(branchCode: '', branchName: 'เลือก'));
    var branchAll = await proxy.getAllBranches();
    lstBranch.addAll(branchAll);
    if (lstBranch.isEmpty) {
      lstBranch.add(BranchInfo(branchCode: '', branchName: 'เลือก'));
    }
    dropdownBranch = lstBranch[0].branchCode!;

    if (dropdownBranch.isEmpty) {
      lstSaleTable = [MapBranchSaleInfo(priceCode: '', priceName: 'เลือก')];
    } else {
      // lstSaleTable = await proxy.getAllMapBranchSale(dropdownBranch);
      List<MapBranchSaleInfo> allTable =
          await proxy.getAllMapBranchSale(dropdownBranch);
      MapBranchSaleInfo firstItem =
          MapBranchSaleInfo(priceCode: '', priceName: 'เลือก');

      lstSaleTable.add(firstItem);
      lstSaleTable.addAll(allTable);
    }

    if (lstSaleTable.isEmpty) {
      lstSaleTable = [MapBranchSaleInfo(priceCode: '', priceName: 'เลือก')];
    }

    dropdownPriceTable = lstSaleTable[0].priceCode!;

    if (GlobalParam.updateCustomerID != '') {
      print('*************** ${GlobalParam.updateCustomerID}');
      getCustomer(GlobalParam.updateCustomerID);
      getCustomerGroup(GlobalParam.updateCustomerID);
    }

    return true;
  }

  clearScreen() async {
    EasyLoading.show();

    WebApiProxy proxy = WebApiProxy();

    dropdownStoreType = 'Cash';
    dropdownBasket = 'Y';
    dropdownstoreGroup = 'Wholesale';
    dropdownPriceTable = '001';
    dropdownStoreAsset = '0001';
    // lstProvices = await proxy.getAllProvinces();
    //String province = '';
    if (lstProvices.isNotEmpty) {
      dropdownProvince = lstProvices[0].name!;

      lstCities = await proxy.getCities(dropdownProvince);
    }

    if (lstCities.isNotEmpty) {
      dropdownDistrict = lstCities[0].name!;
      lstDistricts =
          await proxy.getDistricts(dropdownProvince, dropdownDistrict);
    }

    if (lstDistricts.isNotEmpty) {
      dropdownSubDistrict = lstDistricts[0].name!;
      postCode.text = lstDistricts[0].postCode!;
    }

    var allRoutes = await proxy.getAllRoutes();

    lstMondayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRMON').toList();
    lstTuesdayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRTUE').toList();
    lstWednesDayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRWED').toList();
    lstThursdayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRTHU').toList();
    lstFridayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRFRI').toList();
    lstSaturdayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRSAT').toList();
    lstSundayRoutes =
        allRoutes.where((element) => element.groupCode == 'GRSUN').toList();

    lstMondayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstTuesdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstWednesDayRoutes.insert(
        0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstThursdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstFridayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstSaturdayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));
    lstSundayRoutes.insert(0, RouteInfo(routeCode: '', routeName: 'ไม่ระบุ'));

    lstBranch = await proxy.getAllBranches();
    if (lstBranch.isEmpty) {
      lstBranch.add(BranchInfo(branchCode: '', branchName: 'ไม่ระบุ'));
    }
    dropdownBranch = lstBranch[0].branchCode!;

    if (dropdownBranch.isEmpty) {
      lstSaleTable = [MapBranchSaleInfo(priceCode: '', priceName: 'ไม่ระบุ')];
    } else {
      lstSaleTable = await proxy.getAllMapBranchSale(dropdownBranch);
    }

    if (lstSaleTable.isEmpty) {
      lstSaleTable = [MapBranchSaleInfo(priceCode: '', priceName: 'ไม่ระบุ')];
    }

    dropdownPriceTable = lstSaleTable[0].priceCode!;

    EasyLoading.dismiss();
  }

  saveData() async {
    bool routeCheck = false;
    if (credit.text.isEmpty) {
      return;
    }

    if (limit.text.isEmpty) {
      return;
    }

    if (int.tryParse(credit.text) == null) {
      return;
    }

    if (double.tryParse(limit.text) == null) {
      return;
    }
    double distance = 0.0;
    if (storeDistance.text != '') {
      distance = double.parse(storeDistance.text);
    }

    if (dropdownStoreAsset == "") {
      dropdownStoreAsset = "A";
    }

    CustomerRequest request = CustomerRequest(
        autoPO: 'M',
        customerID: '',
        customerName: storeName.text,
        branchCode: dropdownBranch,
        customerBranchName: '',
        taxNo: storeTax.text,
        telNo: tel.text,
        contactName: contactName.text,
        contactTel: contactTel.text,
        line: line.text,
        type: dropdownstoreGroup,
        payType: dropdownStoreType,
        creditTerm: int.parse(credit.text),
        creditLimit: double.parse(limit.text),
        saleTableCode: dropdownPriceTable,
        isBasket: 'N',
        isPhoto: 'N',
        distancs: distance,
        photo: Photo(name: '', server: '', path: ''),
        address: Address(
            address: address.text,
            shipTo: shipTo.text,
            location: storeLocation.text,
            postCode: postCode.text,
            province: dropdownProvince,
            district: dropdownDistrict,
            subDistrict: dropdownSubDistrict),
        asset: dropdownStoreAsset,
        routes: [],
        status: (_data == Status.active) ? 'Y' : 'N',
        updateUser: 'Mobile');
    var activeerror = true;
    if (isMon && activeerror) {
      if (dropdownMon == '') {
        wrongDialog('กรุณาระบุสายวันจันทร์');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRMON',
            routeCode: dropdownMon,
            auto: isMon_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isTue && activeerror) {
      if (dropdownTue == '') {
        wrongDialog('กรุณาระบุสายวันอังคาร');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRTUE',
            routeCode: dropdownTue,
            auto: isTue_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isWed && activeerror) {
      if (dropdownWed == '') {
        wrongDialog('กรุณาระบุสายวันพุธ');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRWED',
            routeCode: dropdownWed,
            auto: isWed_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isThu && activeerror) {
      if (dropdownThu == '') {
        wrongDialog('กรุณาระบุสายวันพฤหัสบดี');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRTHU',
            routeCode: dropdownThu,
            auto: isThu_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isFri && activeerror) {
      if (dropdownFri == '') {
        wrongDialog('กรุณาระบุสายวันศุกร์');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRFRI',
            routeCode: dropdownFri,
            auto: isFri_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isSat && activeerror) {
      if (dropdownSat == '') {
        wrongDialog('กรุณาระบุสายวันเสาร์');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRSAT',
            routeCode: dropdownSat,
            auto: isSat_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }
    if (isSun && activeerror) {
      if (dropdownSun == '') {
        wrongDialog('กรุณาระบุสายวันอาทิตน์');
        activeerror = false;
      } else {
        request.routes!.add(RouteRequest(
            groupCode: 'GRSUN',
            routeCode: dropdownSun,
            auto: isSun_ ? 'A' : 'M'));
        routeCheck = true;
      }
    }

    if (routeCheck == true && activeerror) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                LocationStore(openMap: false, request: request)
            // DeliveryNewSupplierShowMap(widget.typeMenuCode, request: request),
            ),
      );
    } else if (!isMon &&
        !isTue &&
        !isWed &&
        !isThu &&
        !isFri &&
        !isSat &&
        !isSun) {
      wrongDialog('กรุณาเลือกกลุ่ม/สายอย่างน้อย 1 รายการ');
    }
  }

  getBasket(SearchBasketReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBasket(req);
      GlobalParam.deliveryBasketList = result;

      GlobalParam.deliveryBasketShow = result;

      lstAsset.add({"Text": "เลือก", "Value": ""});

      for (int i = 0; i < result.length; i++) {
        Map<String, String> data = {
          "Text": result[i].cBASKNM!,
          "Value": result[i].cBASKCD!
        };
        lstAsset.add(data);
      }

      if (result.isEmpty) {
        wrongDialog('ไม่พบรายการตะกร้า');
      }
      setState(() {});
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

  getCustomer(String req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getCustomer(req);

      if (result.isNotEmpty) {
        GetCustomerResp customer = result[0];

        WebApiProxy proxy = WebApiProxy();
        var allCities =
            await proxy.getCities(customer.cPROVINCE!).then((data) async {
          lstCities.addAll(data);
          var allDistricts = await proxy
              .getDistricts(customer.cPROVINCE!, customer.cDISTRICT!)
              .then((value) async {
            lstDistricts.addAll(value);
            var tableAll = await proxy
                .getAllMapBranchSale(customer.cBRANCD!)
                .then((value) {
              lstSaleTable.addAll(value);
              setState(() {
                dropdownSubDistrict = lstDistricts[0].name!;
                storeName.text = customer.cCUSTNM!;
                storeTax.text = customer.cTAXNO;
                storeType.text = customer.cCUSTTYPE!;
                postCode.text = customer.cPOSTCD!;
                tel.text = customer.cTEL!;
                contactName.text = customer.cCONTACT!;
                contactTel.text = customer.cCONTACTTEL!;
                line.text = customer.cLINEID!;
                credit.text = '${customer.iCREDTERM}';
                limit.text = customer.iCREDLIM!;
                address.text = customer.cADDRESS!;
                shipTo.text = customer.cSHIPTO!;
                storeLocation.text = customer.cLOCATION!;
                storeAssetNumber.text = '0';
                storeDistance.text = customer.cDISTANCS!;

                dropdownValue = customer.cCUSTTYPE!;
                dropdownGroup = customer.cPAYTYPE!;
                dropdownProvince = customer.cPROVINCE!;
                dropdownDistrict = customer.cDISTRICT!;
                dropdownSubDistrict = customer.cSUBDIST!;
                dropdownBranch = customer.cBRANCD!;
                dropdownStoreType = customer.cPAYTYPE!.replaceAll(' ', '');
                dropdownBasket = customer.cISBASKET!;
                dropdownstoreGroup = customer.cCUSTTYPE!;
                dropdownPriceTable = customer.cTSELLCD!;
              });
            });
          });
        });

        // if (lstDistricts.length > 1) {
        //   // setState(() {
        //   //   dropdownDistrict = customer.cDISTRICT;
        //   // });
        // }
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  getCustomerGroup(String req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getCustomerGroup(req);
      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          if (result[i].cGRPCD == "GRMON") {
            isMon = true;
            dropdownMon = result[i].cRTECD!;
          }
          if (result[i].cGRPCD == "GRTUE") {
            isTue = true;
            dropdownTue = result[i].cRTECD!;
          }
          if (result[i].cGRPCD == "GRWED") {
            isWed = true;
            dropdownWed = result[i].cRTECD!;
          }
          if (result[i].cGRPCD == "GRTHU") {
            isThu = true;
            dropdownThu = result[i].cRTECD!;
          }
          if (result[i].cGRPCD == "GRFRI") {
            isFri = true;
            dropdownFri = result[i].cRTECD!;
          }
          if (result[i].cGRPCD == "GRSUN") {
            isSun = true;
            dropdownSun = result[i].cRTECD!;
          }
        }
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }
}
