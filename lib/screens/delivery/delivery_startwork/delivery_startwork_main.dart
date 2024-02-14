import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/customer/order.dart';
import 'package:vansale/common_screen.dart/confirm2btn.dart';

class DeliveryStartWork extends StatefulWidget {
  final String typeMenuCode;
  DeliveryStartWork(this.typeMenuCode);

  @override
  State<DeliveryStartWork> createState() => _DeliveryStartWorkState();
}

class _DeliveryStartWorkState extends State<DeliveryStartWork> {
  String dropdownLicensePlate = '1กก1234 กรุงเทพมหานคร';

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
                  Utility.formatDatetimeToday(DateTime.now()),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                alignment: Alignment.center,
                child: Container(
                  //width: 300.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Order(widget.typeMenuCode),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Container(
                      height: 40.0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          // color: Colors.black,
                          height: 40.0,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.map_marker,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '123 แขวง/ตำบล เขต/อำเภอ จังหวัด ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.black,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownLicensePlate,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                            ),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Prompt",
                                              color: Colors.white,
                                              backgroundColor: Colors.black,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownLicensePlate = newValue;
                                              });
                                            },
                                            items: <String>[
                                              '1กก1234 กรุงเทพมหานคร',
                                              '2กข4567 พระนครศรีอยุธยา'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  constraints: BoxConstraints(
                                                    minHeight: 48.0,
                                                  ),
                                                  color: Colors.black,
                                                  child: AutoSizeText(
                                                    value,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                    ),
                                                    minFontSize: 8.0,
                                                    maxFontSize: 10.0,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  /*Container(
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
                                                  Code == ""
                                                      ? '7กฮ2552 พระนครศรีอยุธยา'
                                                      : Name,
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
                                  ),*/
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Confirm2btn(
                                widget.typeMenuCode,
                                "DeliveryStartWork",
                                "บันทึกข้อมูลการทำงาน",
                                "เรียบร้อยแล้ว"),
                          ),
                        );
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

  PickedFile imageFile;
  File _image;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1000.0, maxWidth: 1000.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile.path);
    });
  }
}
