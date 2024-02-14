import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/common_screen.dart/confirm_new_supplier_page.dart';

class NewSupplierSelectImage extends StatefulWidget {
  final String typeMenuCode;
  NewSupplierSelectImage(this.typeMenuCode);

  @override
  State<NewSupplierSelectImage> createState() => _NewSupplierSelectImageState();
}

class _NewSupplierSelectImageState extends State<NewSupplierSelectImage> {
  late PickedFile imageFile;
  // final ImagePicker _picker = ImagePicker();
  late File file;
  late Timer timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ถ่ายรูปร้านค้า'),
      ),
      backgroundColor: Colors.black12,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: showImage(),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: btnSelectImage(),
              ),
            ),
            Expanded(
              child: Container(
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
          ? Image.asset(
              'assets/images/Image.png',
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
      child: Container(
        child: IconButton(
          onPressed: () {
            actionsheet(context);
          },
          icon: Icon(
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ConfirmNewSupplierPage(
                  widget.typeMenuCode, 'เพิ่มร้านค้า', 'เรียบร้อยแล้ว'),
            ),
          );
        },
        child: Container(
          child: Icon(
            LineAwesomeIcons.arrow_right,
            size: 30.0,
          ),
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
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  selectImage();
                  Navigator.of(context).pop();
                });
              },
              child: Text(
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
}
