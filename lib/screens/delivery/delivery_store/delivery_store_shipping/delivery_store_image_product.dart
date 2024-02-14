import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:location/location.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addLOSSPROReq.dart';
import 'package:vansale/screens/Supplier/shipping/%E0%B8%BABasketsReturn.dart';


class DeliveryImageProduct extends StatefulWidget {
  final String typeMenuCode;
  DeliveryImageProduct(this.typeMenuCode);
  //const StartWork({ Key? key }) : super(key: key);

  @override
  _DeliveryImageProductState createState() => _DeliveryImageProductState();
}

class _DeliveryImageProductState extends State<DeliveryImageProduct> {
  var dateFormat = DateFormat('dd/MM/yyyy hh:mm');
  // bool _edit = false;
  String Code = "";
  String Name = "";
  String imgB64 = "";

  Location _locationTracker = Location();
  StreamSubscription _locationSubscription;
  LatLng currentLocation;
  bool imgIsNull = true;
  PickedFile imageFile;
  File _image;
  String base64Image;
  List<int> imageBytes;
  Uint8List bytes;

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
                  'รูปสินค้าเสีย',
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
                  dateFormat.format(DateTime.now()),
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
              //                     size: 24,
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     alignment: Alignment.centerLeft,
              //                     child: AutoSizeText(
              //                       '${GlobalParam.deliverySelectStore.cADDRESS} ${GlobalParam.deliverySelectStore.cSUBDIST} ${GlobalParam.deliverySelectStore.cDISTRICT} ${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 16.0,
              //                         fontWeight: FontWeight.bold,
              //                         fontFamily: 'Prompt',
              //                       ),
              //                       maxLines: 1,
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
              SizedBox(height: 64),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
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
                                openCamera();
                              },
                              child: Container(
                                width: 500,
                                height: 300,
                                child: Image.file(
                                  File(_image.path),
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
                                openCamera();
                              },
                              child: Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.white,
                                size: 100.0,
                              ),
                            ),
                          )),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "*กรุณาถ่ายภาพ",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ),
              // Container(
              //     height: 64,
              //     child: bytes == null ? Container() : Image.memory(bytes))
            ],
          ),
        ),
        bottomNavigationBar: Container(
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
                        saveLossPro(AddLOSSPROReq(
                            cPOCD: GlobalParam.deliveryPodtList[0].cPOCD,
                            cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
                            iQTY: '0',
                            iTOTAL: '0',
                            cIB64: "",
                            cSERVER: '',
                            cCREABY: GlobalParam.userID));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                LineAwesomeIcons.check_circle,
                                color: Colors.green,
                                size: 25.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
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

  Future<void> openCamera() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
      GlobalParam.deliveryImage = File(imageFile.path);

      final bytes = File(imageFile.path).readAsBytesSync();

      String img64 = base64Encode(bytes);
      setState(() {
        imgB64 = img64;
      });
      //EasyLoading.dismiss();
      // saveData();
      imgIsNull = false;
    });

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
      });
    }
  }

  saveLossPro(AddLOSSPROReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      // ignore: unrelated_type_equality_checks
      if (_image != '' && _image != null) {
        imageBytes = await _image.readAsBytes();
        base64Image = base64Encode(imageBytes);
        req.cIB64 = base64Image;
        req.cSERVER = '27.254.207.240:11110';
      }

      for (int i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        double price = 0.0;
        // ignore: unrelated_type_equality_checks
        if (GlobalParam.deliveryPodtList[i].iSSIZEQTY != 0.0) {
          price = double.parse(GlobalParam.deliveryPodtList[i].iSUNITPRICE);
          // ignore: unrelated_type_equality_checks
        } else if (GlobalParam.deliveryPodtList[i].iMSIZEQTY != 0.0) {
          price = double.parse(GlobalParam.deliveryPodtList[i].iMUNITPRICE);
          // ignore: unrelated_type_equality_checks
        } else if (GlobalParam.deliveryPodtList[i].iLSIZEQTY != 0.0) {
          price = double.parse(GlobalParam.deliveryPodtList[i].iLUNITPRICE);
        }
        var totail = 0.0;
        var qty = 0;
        if (GlobalParam.deliveryPodtList[i].iLOSSPRO != 0 &&
            GlobalParam.deliveryPodtList[i].iLOSSPRO != null) {
          totail += GlobalParam.deliveryPodtList[i].iLOSSPRO * price;
          qty += GlobalParam.deliveryPodtList[i].iLOSSPRO;
        }
        req.iQTY = '$qty';
        req.iTOTAL = '$totail';
      }
      // print(req.cIB64);
      // print(req.cCREABY);
      // print(req.iTOTAL);
      // print(req.iQTY);
      // print(req.cCUSTCD);
      // print(req.cPOCD);

      var result = await proxy.addLOSSPRO(req);
      if (result.success == false) {
        wrongDialog("${result.message}");
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (comtext) =>
              BasketReturn(typeMenuCode: GlobalParam.typeMenuCode)));
      // setState(() {
      //   bytes = Base64Decoder().convert(base64Image);
      // });
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
