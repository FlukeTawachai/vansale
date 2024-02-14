import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/apiexception.dart';
import 'package:vansale/api/class/globalparam.dart';

import 'package:vansale/api/class/request/mobile/addSupplierReceivBillReq.dart';

import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_basket_signature.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_proBad.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_proMiss.dart';

class StockReturnImage extends StatefulWidget {
  final String code;
  final String cREFDOC;
  StockReturnImage(this.code, this.cREFDOC);

  @override
  State<StockReturnImage> createState() => _StockReturnImageState();
}

class _StockReturnImageState extends State<StockReturnImage> {
  PickedFile imageFile;
  // final ImagePicker _picker = ImagePicker();
  File file;
  Timer timer;
  bool imgIsNull = true;
  List<File> imageList = [];
  double widthScreen;
  File _image;

  @override
  void initState() {
    super.initState();
    GlobalParam.imageStoreList = [];
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ถ่ายรูปใบเสร็จ'),
      ),
      backgroundColor: Colors.black12,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: showImage(),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: widthScreen * 0.30,
                child: btnSelectImage(),
              ),
            ),
            Expanded(
              child: Container(
                width: widthScreen * 0.30,
                child: btnSavedata(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    return GlobalParam.imageStoreList.length > 0
        ? GridView.builder(
            shrinkWrap: true,
            //physics: new NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15.0),
            itemCount: GlobalParam.imageStoreList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              /*childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height)/2.2,*/
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  deleteImgDialog('ต้องการลบรูปนี้หรือไม่', index);
                },
                child: Container(
                  color: Colors.white,
                  child: GlobalParam.imageStoreList[index] == null
                      ? Image.asset(
                          'assets/images/Image.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(GlobalParam.imageStoreList[index].path),
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
          )
        : Container();
  }

  Widget btnSelectImage() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          actionsheet(context);
        },
        child: Container(
          child: Icon(
            LineAwesomeIcons.camera,
            color: HexColor('#00cb39'),
            size: 50.0,
          ),
        ),
      ),
    );
  }

  Widget btnSavedata() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          saveData();
        },
        child:
            // imgIsNull == true
            //     ? Container()
            //     : Container(
            //         child: Center(
            //             child: Text("ตกลง",
            //                 style: TextStyle(
            //                   fontFamily: "Prompt",
            //                   fontSize: 18,
            //                   color: HexColor('#00cb39'),
            //                 ))),
            //       )
            Container(
          child: Center(
              child: Text(
            'บันทึก',
            style: TextStyle(fontSize: 18),
          )),
        ),
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
                  openCamera();
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                'ถ่ายภาพ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            // CupertinoActionSheetAction(
            //   onPressed: () {
            //     setState(() {
            //       selectImage();
            //       Navigator.of(context).pop();
            //     });
            //   },
            //   child: Text(
            //     'เลือกรูปภาพ',
            //     style: TextStyle(
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

  Future<void> openCamera() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
      GlobalParam.deliveryImage = File(imageFile.path);
      //EasyLoading.dismiss();
      // saveData();
      imgIsNull = false;
      if (imageList.length <= 5) {
        GlobalParam.imageStoreList.add(_image);
      } else {
        GlobalParam.imageStoreList.removeAt(0);
        GlobalParam.imageStoreList.add(_image);
      }
    });
  }

  Future<void> selectImage() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
      GlobalParam.deliveryImage = File(imageFile.path);
      // EasyLoading.dismiss();
      // saveData();
      imgIsNull = false;
      if (imageList.length <= 5) {
        GlobalParam.imageStoreList.add(_image);
      } else {
        GlobalParam.imageStoreList.removeAt(0);
        GlobalParam.imageStoreList.add(_image);
      }
    });
  }
  /*Future<void> selectImage() async {
    EasyLoading.show();
    final selectedImage = (await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1800.0,
      maxWidth: 1800.0,
    ));

    file = selectedImage.path as File;
    print(file);
    EasyLoading.dismiss();
  }*/

  saveData() async {
    try {
      EasyLoading.show();
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var loop = 0;
      if (GlobalParam.imageStoreList.length > 0) {
        for (int i = 0; i < GlobalParam.imageStoreList.length; i++) {
          String cTYPE = '';
          loop++;
          if (widget.code == '01') {
            cTYPE = 'BRBTS';
          }
          if (widget.code == '02') {
            cTYPE = 'BDPTS';
          }
          if (widget.code == '03') {
            cTYPE = 'BBPTS';
          }
          List<int> imageBytes =
              await GlobalParam.imageStoreList[i].readAsBytes();
          // print(imageBytes);
          String base64Image = base64Encode(imageBytes);
          var result =
              await proxy.addSupplierReceivBill(AddSupplierReceivBillReq(
                  cRECEIVENO: widget.cREFDOC,
                  iSEQ: "${i + 1}",
                  cSERVER: "27.254.207.240:11110",
                  cIB64: base64Image,
                  // cIB64: "",
                  cREFDOC: widget.cREFDOC,
                  cTYPE: cTYPE,
                  cCREABY: GlobalParam.userID));
          EasyLoading.dismiss();
          if (result.success == false) {
            EasyLoading.dismiss();
            print(result.message);
          }
          // else {
          //   EasyLoading.dismiss();
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           HomePage(GlobalParam.typeMenuCode),
          //     ),
          //   );
          // }
        }
        EasyLoading.dismiss();
        if (loop == GlobalParam.imageStoreList.length) {
          if (widget.code == '01') {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         StockReturnMissPro(GlobalParam.typeMenuCode, true)));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StockBasketReturnSignature(
                      cVEHICD: GlobalParam.stockSupSelect.cSUPCD,
                      item: GlobalParam.stockReturnBasketItem,
                      total: GlobalParam.stockReturnBasketTotal,
                      cREF: widget.cREFDOC,
                    )));
          }
          if (widget.code == '02') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    StockReturnBadPro(GlobalParam.typeMenuCode, true)));
          }
          if (widget.code == '03') {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePage(GlobalParam.typeMenuCode)),
                (Route route) => false);
          }
        }
      } else {
        EasyLoading.dismiss();
        wrongDialog('กรุณาถ่ายรูปบิล');
      }
    } on ApiException catch (e) {
      EasyLoading.dismiss();
      print(e.cause);
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  deleteImgDialog(String msg, int index) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('ลบรูป'),
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
                  child: const Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    setState(() {
                      GlobalParam.imageStoreList.removeAt(index);
                    });
                  },
                  child: const Text('ยืนยัน'),
                ),
              ],
            ),
          ),
        ],
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
                  child: const Text('ok'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
