import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/apiexception.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customer_attach_request.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/api/webapiproxy.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_supplier_image_list.dart';
import 'package:vansale/screens/delivery/delivery_refuel/delivery_refuel_edit.dart';

class DeliveryNewSupplierSelectImage extends StatefulWidget {
  final String typeMenuCode;
  final CustomerRequest request;
  final String subMenu;
  DeliveryNewSupplierSelectImage(this.typeMenuCode,
      {required this.request, required this.subMenu});

  @override
  State<DeliveryNewSupplierSelectImage> createState() =>
      _DeliveryNewSupplierSelectImageState();
}

class _DeliveryNewSupplierSelectImageState
    extends State<DeliveryNewSupplierSelectImage> {
  late PickedFile imageFile;
  // final ImagePicker _picker = ImagePicker();
  late File file;
  late Timer timer;
  bool imgIsNull = true;
  List<File> imageList = [];
  late double widthScreen;

  @override
  void initState() {
    super.initState();
    GlobalParam.imageStoreList = [];
    if (GlobalParam.deliveryImage != null) {
      _image = GlobalParam.deliveryImage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ถ่ายรูปร้านค้า'),
      ),
      backgroundColor: Colors.black12,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: showImage(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ImageStoreList(
                          request: widget.request,
                        )));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         ImageStoreList(imageFileList: imageList)));
              },
              child: SizedBox(
                width: widthScreen * 0.30,
                height: 60,
                child: Stack(children: [
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _image == null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#68879A'),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: HexColor('#68879A'),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      matchTextDirection: true,
                                      repeat: ImageRepeat.noRepeat,
                                      image: FileImage(
                                        File(_image.path),
                                      ),
                                    )),
                              ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        '${GlobalParam.imageStoreList.length}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: widthScreen * 0.30,
                child: btnSelectImage(),
              ),
            ),
            Expanded(
              child: SizedBox(
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
    return Container(
      color: Colors.white,
      child: imageFile == null
          ? (_image == null)
              ? Image.asset(
                  'assets/images/Image.png',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(_image.path),
                  fit: BoxFit.cover,
                )
          : Image.file(
              File(_image.path),
              fit: BoxFit.cover,
            ),
    );
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
          if (widget.subMenu == '004') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryRefuelEdit(widget.typeMenuCode),
              ),
            );
          } else {
            if (GlobalParam.imageStoreList.length > 0) {
              saveData();
            } else {
              wrongDialog('ถ่ายรูปอย่างน้อย 1 รูป');
            }
          }
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
          child: const Center(
              child: Text(
            'บันทึก',
            style: TextStyle(fontSize: 18),
          )),
        ),
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

  /*Future<void> openCamera() async {
    EasyLoading.show();
    final selectedImage = (await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1800.0,
      maxWidth: 1800.0,
    ));
    print(selectedImage.path);
    file = selectedImage.path as File;
    print(file);
    EasyLoading.dismiss();
  }*/

  late File _image;
  Future<void> openCamera() async {
    //EasyLoading.show();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1800.0, maxWidth: 1800.0);
    setState(() {
      imageFile = image!;
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
      imageFile = image!;
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
    print('++++++++++++++++++++++++++++++++${widget.request.distancs}');
    try {
      if (widget.request.customerID != "test010test") {
        EasyLoading.show();
        WebApiProxy proxy = WebApiProxy();
        if (GlobalParam.updateCustomerID != '') {
          var result = await proxy.updateCustomer(
              GlobalParam.updateCustomerID, widget.request);
          if (result.success!) {
            List<int> imageBytes =
                await GlobalParam.deliveryImage!.readAsBytes();
            print(imageBytes);
            String base64Image = base64Encode(imageBytes);
            String filename = p.basename(_image.path);
            CustomerAttachRequest request = CustomerAttachRequest(
                customerId: widget.request.customerID,
                fileName: filename,
                image: base64Image);
            var result2 = await proxy.attachCustomerImage(request);
            print(result2.message);

            EasyLoading.dismiss();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ConfirmPage(
                    widget.typeMenuCode, 'แก้ไขร้านค้า', 'เรียบร้อยแล้ว'),
              ),
            );
          } else {
            EasyLoading.dismiss();
            print(result.message);
          }
        } else {
          var result = await proxy.createCustomer(widget.request);
          if (result.success!) {
            List<int> imageBytes =
                await GlobalParam.deliveryImage!.readAsBytes();
            print(imageBytes);
            String base64Image = base64Encode(imageBytes);
            String filename = p.basename(_image.path);
            CustomerAttachRequest request = CustomerAttachRequest(
                customerId: result.customerID,
                fileName: filename,
                image: base64Image);
            var result2 = await proxy.attachCustomerImage(request);
            print(result2.message);

            EasyLoading.dismiss();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ConfirmPage(
                    widget.typeMenuCode, 'เพิ่มร้านค้า', 'เรียบร้อยแล้ว'),
              ),
            );
          } else {
            EasyLoading.dismiss();
            print(result.message);
          }
        }
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DeliveryCheckIn(GlobalParam.typeMenuCode!, false)));
      }
    } on ApiException catch (e) {
      EasyLoading.dismiss();
      print(e.cause);
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }
}
