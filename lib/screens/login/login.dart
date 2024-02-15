import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/database/dbHelper.dart';
import 'package:vansale/screens/add_supplier/add_supplier_main.dart';
import 'package:vansale/screens/delivery/delivery_map/map_selectBranch.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/namo/signature_screen.dart';
import 'package:vansale/screens/navigatorStore/selectGroupRoute.dart';
import 'package:vansale/screens/wifiPrinter/wifiPrinter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String typeName = "";
  String typeCode = "";
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBManager.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#f6f6f6'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WifiPrinter()));
                  },
                  icon: const Icon(Icons.print_sharp))
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              logo_(),
              userName_(),
              password_(),
              type_(),
              const Divider(
                indent: 15.0,
                endIndent: 15.0,
                thickness: 1.0,
                color: Colors.black45,
              ),
              const SizedBox(
                height: 10.0,
              ),
              rememberPassword_(),
              btnLogin_(),
              // Divider(
              //   indent: 130.0,
              //   endIndent: 130.0,
              //   thickness: 1.0,
              //   color: HexColor('#00cb39'),
              // ),
            ],
          ),
          bottomNavigationBar: appVersion(),

          /* Container(
            child: Text(GlobalParam.appVersion),
          ),*/
        ),
      ),
    );
  }

  Widget appVersion() {
    return Container(
      padding: const EdgeInsets.only(right: 10.0),
      height: 30.0,
      alignment: Alignment.bottomRight,
      child: Text(
        GlobalParam.appVersion,
        style: const TextStyle(fontSize: 10.0),
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
                  typeCode = "T001";
                  typeName = "ฝ่ายขนส่ง";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายขนส่ง',
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
                  typeCode = "T002";
                  typeName = "ฝ่ายขาย";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายขาย',
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
                  typeCode = "T003";
                  typeName = "ฝ่ายร้านค้า";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายร้านค้า',
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
                  typeCode = "T004";
                  typeName = "ฝ่ายคลังสาขา";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายคลังสาขา',
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
                  typeCode = "T005";
                  typeName = "โกดัง 2";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'โกดัง 2',
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
                  typeCode = "T006";
                  typeName = "ฝ่ายจัดสินค้า";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายจัดสินค้า',
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
                  typeCode = "T007";
                  typeName = "ฝ่ายตรวจสอบ";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายตรวจสอบ',
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
                  typeCode = "T008";
                  typeName = "ฝ่ายซัพพลายเออร์";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'ฝ่ายซัพพลายเออร์',
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
                  typeCode = "T009";
                  typeName = "เพิ่มร้านค้า";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'เพิ่มร้านค้า',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       typeCode = "T010";
            //       typeName = "ลายเซ็น";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     'ลายเซ็น',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  typeCode = "T011";
                  typeName = "แผนที่นำทาง";
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'แผนที่นำทาง',
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

  Widget logo_() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      height: 200.0,
      width: 200.0,
      child: Image.asset('assets/images/Vansale_Logo.png'),
    );
  }

  Widget userName_() {
    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 5.0, top: 15.0),
      child: TextFormField(
        controller: userName,
        keyboardType: TextInputType.name,
        style: TextStyle(
            color: Theme.of(context).copyWith().textTheme.headline1!.color!),
        decoration: InputDecoration(
          labelText: "ชื่อผู้ใช้งาน",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(1.0))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green)),
          prefixIcon: const Icon(
            LineAwesomeIcons.user,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget password_() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 15.0, top: 0.0),
      child: TextFormField(
        controller: password,
        obscureText: true,
        keyboardType: TextInputType.name,
        style: TextStyle(
            color: Theme.of(context).copyWith().textTheme.headline1!.color),
        decoration: InputDecoration(
          /*hintText: '••••••',
          hintStyle: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 35.0,
          ),*/
          labelText: 'พาสเวิร์ด',
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(1.0))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green)),
          prefixIcon: const Icon(
            LineAwesomeIcons.lock,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget type_() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 12.0, top: 2.0, bottom: 2.0),
      child: InkWell(
        onTap: () {
          actionsheet(context);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0),
          child: Row(
            children: [
              Container(
                child: const Icon(
                  LineAwesomeIcons.bars,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Container(
                child: Text(
                  typeCode == "" ? 'ประเภท' : typeName,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rememberPassword_() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    LineAwesomeIcons.check_circle,
                    color: HexColor('#00cb39'),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Text(
                    'จดจำ',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                child: const Text(
                  'ลืมพาสเวิร์ด?',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnLogin_() {
    return Container(
      width: 140.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 70.0),
      child: InkWell(
        child: Container(
          height: 48,
          width: 128,
          decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: HexColor('#00cb39'))),
          child: Center(
            child: Text(
              'เข้าสู่ระบบ',
              style: TextStyle(
                color: HexColor('#00cb39'),
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        onTap: () {
          disableMenu();
          GlobalParam.typeMenuCode = typeCode;

          /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainMenu(typeCode),
            ),
          );*/

          //loginClick();
        },
      ),
    );
  }

  disableMenu() {
    switch (typeCode) {
      case 'T001':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T002':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T003':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T004':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T006':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T008':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(typeCode),
          ),
        );
        break;
      case 'T009':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AddSupplierMain(typeCode),
          ),
        );
        break;
      case 'T010':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignatureTest(
              typeMenuCode: typeCode,
            ),
          ),
        );
        break;
      case 'T011':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SelectGroupRoute(),
          ),
        );
        break;
    }
  }

  /*void loginClick() async {
    try {
      ApiProxy proxy = ApiProxy();
      var token = await proxy.login('vpadmin', '123456');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainMenu(Type),
        ),
      );
    } on ApiResponseException catch (e) {
      print(e.cause);
    }
  }*/
}
