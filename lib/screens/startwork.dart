import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/apiexception.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceivBillReq.dart';
import 'package:vansale/api/class/request/mobile/getStartWorkReq.dart';
import 'package:vansale/api/class/request/mobile/startStopWorkReq.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/screens/confirm_page1.dart';
import 'package:vansale/screens/home/home.dart';

class StartWork extends StatefulWidget {
  final String typeMenuCode;
  StartWork(this.typeMenuCode);
  //const StartWork({ Key? key }) : super(key: key);

  @override
  _StartWorkState createState() => _StartWorkState();
}

class _StartWorkState extends State<StartWork> {
  // bool edit = false;
  String Code = "";
  String Name =
      "${GlobalParam.VEHICLE['cPLATE']} ${GlobalParam.VEHICLE['cPPROVINCE']}";
  int newYear = 2566;
  String newDate = '';
  int mile = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(new DateTime.now());
    var dateList = outputDate.split("-");
    newYear = int.parse(dateList[0]) + 543;
    newDate = "${dateList[2]}/${dateList[1]}/$newYear";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                alignment: Alignment.center,
                child: Text(
                  'บันทึกข้อมูลการทำงาน',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.center,
                child: Text(
                  newDate,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 50.0, left: 10.0),
              //   alignment: Alignment.center,
              //   child: Container(
              //     //width: 300.0,
              //     child: OutlinedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (BuildContext context) =>
              //                 AppbarPage(4.toString(), widget.typeMenuCode),
              //           ),
              //         );
              //       },
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(5.0),
              //           ),
              //         ),
              //       ),
              //       child: Container(
              //         height: 40.0,
              //         child: Container(
              //           alignment: Alignment.centerLeft,
              //           child: Container(
              //             // color: Colors.black,
              //             height: 40.0,
              //             child: Row(
              //               children: [
              //                 Container(
              //                   width: 30.0,
              //                   alignment: Alignment.centerLeft,
              //                   child: Icon(
              //                     LineAwesomeIcons.map_marker,
              //                     color: Colors.white,
              //                     size: 25.0,
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(
              //                       '123 แขวง/ตำบล เขต/อำเภอ จังหวัด ',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 12.0,
              //                         fontWeight: FontWeight.bold,
              //                         fontFamily: 'Prompt',
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(30.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'ทะเบียนรถ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    alignment: Alignment.centerLeft,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          licenseplate(context);
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  Name,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: 'Prompt',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 20.0,
                                              child: Icon(
                                                LineAwesomeIcons.angle_down,
                                                color: Colors.grey,
                                                size: 20.0,
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
                          ),
                          //-------------------------
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 100.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'เลขไมล์',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.centerLeft,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.black,
                                      //primaryColorDark: Colors.grey,
                                    ),
                                    child: new TextFormField(
                                      maxLength: 7,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.green,
                                      style: TextStyle(color: Colors.white),
                                      decoration: new InputDecoration(
                                        /*border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey),
                                        ),*/
                                        counterText: "",
                                      ),
                                      onChanged: (value) {
                                        if (value != "") {
                                          setState(() {
                                            mile = int.parse(value);
                                          });
                                        }
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'บันทึกภาพถ่าย',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  alignment: Alignment.topCenter,
                  child: FDottedLine(
                      color: Colors.grey[600],
                      strokeWidth: 2.0,
                      dottedLength: 10.0,
                      space: 2.0,
                      child: imageFile != null
                          ? Container(
                              width: 500.0,
                              height: 300.0,
                              alignment: Alignment.center,
                              color: Colors.black,
                              child: InkWell(
                                onTap: () {
                                  _openCamera();
                                },
                                child: Container(
                                  width: 500,
                                  height: 300,
                                  child: Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 500.0,
                              height: 300.0,
                              color: Colors.black,
                              child: InkWell(
                                onTap: () {
                                  _openCamera();
                                },
                                child: Icon(
                                  LineAwesomeIcons.camera,
                                  color: Colors.white,
                                  size: 100.0,
                                ),
                              ),
                            )),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          height: 80.0,
          color: Colors.black87,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 35.0,
                              alignment: Alignment.center,
                              child: Icon(
                                LineAwesomeIcons.arrow_left,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'กลับหน้าหลัก',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        startStopWork();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 35.0,
                              alignment: Alignment.center,
                              child: Icon(
                                LineAwesomeIcons.car,
                                color: Colors.green,
                                size: 25.0,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.green,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  licenseplate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
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
                  Code = "001";
                  Name =
                      "${GlobalParam.VEHICLE['cPLATE']} ${GlobalParam.VEHICLE['cPPROVINCE']}";
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                "${GlobalParam.VEHICLE['cPLATE']} ${GlobalParam.VEHICLE['cPPROVINCE']}",
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
            //       Code = "002";
            //       Name = "2กข2222 นนทบุรี";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     '2กข2222 นนทบุรี',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       Code = "003";
            //       Name = "3จจ3333 ปทุมธานี";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     '3จจ3333 ปทุมธานี',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       Code = "004";
            //       Name = "4ชม4567 นครนายก";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     '4ชม4567 นครนายก',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       Code = "005";
            //       Name = "5รร5555 สมุทรปราการ";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     '5รร5555 สมุทรปราการ',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       Code = "006";
            //       Name = "8กก8888 นครปฐม";
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     '8กก8888 นครปฐม',
            //     style: TextStyle(
            //       fontFamily: 'Prompt',
            //       color: Colors.black,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  PickedFile? imageFile;
  File? _image;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile!.path);
      GlobalParam.deliveryImage = File(imageFile!.path);
      //EasyLoading.dismiss();
      // saveData();
      GlobalParam.imageStoreList = [];
      GlobalParam.imageStoreList.add(_image!);
    });
  }

  startStopWork() async {
    // if (cVEHINM == '') {
    try {
      // print("************** $nameOfRoute **************");

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

      var result = await proxy.startStopWork(StartStopWorkReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cREFCD: GlobalParam.VEHICLE['cVEHICD'],
        cUSRNM: GlobalParam.userData.cUSRNM,
        cSTATUS: "Y",
        cPLATE: Name,
        iMILE: mile,
        cSECTION: section,
        cCREABY: GlobalParam.userData.cUSRNM,
      ));
      if (result.success == true) {
        // wrongDialog('บันทึกเวลาเริ่มงานสำเร็จ');
        // getStartWork();
        addSupplierReceivBill("${result.result}");
      } else {
        wrongDialog("${result.message}");
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
        setState(() {
          GlobalParam.startWorkList = [];
          GlobalParam.startWorkList.addAll(result);
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(GlobalParam.typeMenuCode!)));
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addSupplierReceivBill(String ref) async {
    try {
      EasyLoading.show();
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var num = 0;
      if (GlobalParam.imageStoreList.length > 0) {
        for (int i = 0; i < GlobalParam.imageStoreList.length; i++) {
          List<int> imageBytes =
              await GlobalParam.imageStoreList[i].readAsBytes();
          print(imageBytes);
          String base64Image = base64Encode(imageBytes);
          var result = await proxy.addSupplierReceivBill(
              AddSupplierReceivBillReq(
                  cRECEIVENO: ref,
                  iSEQ: "${i + 1}",
                  cSERVER: "",
                  cIB64: base64Image,
                  cREFDOC: ref,
                  cTYPE: "SW",
                  cCREABY: GlobalParam.userID));
          EasyLoading.dismiss();
          if (result.success == false) {
            EasyLoading.dismiss();
            print(result.message);
          } else {
            num++;
            // EasyLoading.dismiss();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) =>
            //         HomePage(GlobalParam.typeMenuCode),
            //   ),
            // );
          }
        }
        if (num == GlobalParam.imageStoreList.length) {
          EasyLoading.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(GlobalParam.typeMenuCode!),
            ),
          );
        }
      } else {
        EasyLoading.dismiss();
        wrongDialog('กรุณาถ่ายรูปเลขไมล์');
      }
    } on ApiException catch (e) {
      EasyLoading.dismiss();
      print(e.cause);
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
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
