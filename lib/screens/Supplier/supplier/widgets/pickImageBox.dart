import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/models/pickImage.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

GetImage picker = new GetImage();

class PickImageBox extends StatefulWidget {
  final ProductsModel product;
  const PickImageBox({Key key, this.product}) : super(key: key);

  @override
  State<PickImageBox> createState() => _PickImageBoxState();
}

class _PickImageBoxState extends State<PickImageBox> {
  DateTime date;
  List<File> imgList;
  bool firstPickcer;

  @override
  void initState() {
    super.initState();
    imgList = picker.getImageFileList();
    firstPickcer = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        child: firstPickcer
            ? InkWell(
                onTap: () {
                  picker.pickImage(ImageSource.camera).then((value) => {
                        setState(() {
                          imgList = picker.getImageFileList();
                          firstPickcer = false;
                        })
                      });
                },
                child: (imgList.length == 0)
                    ? Icon(
                        LineAwesomeIcons.camera,
                        size: 96,
                      )
                    : (widget.product.id < imgList.length)
                        ? Image.file(
                            imgList[widget.product.id],
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 150.0,
                          )
                        : Icon(
                            LineAwesomeIcons.camera,
                            size: 96,
                          ),
              )
            : InkWell(
                onTap: () {
                  picker
                      .pickInserImage(ImageSource.camera, widget.product.id)
                      .then((image) => {
                            setState(() {
                              imgList = picker.getImageFileList();
                              firstPickcer = false;
                            })
                          });
                },
                child: (imgList.length == 0)
                    ? Icon(
                        LineAwesomeIcons.camera,
                        size: 96,
                      )
                    : (widget.product.id < imgList.length)
                        ? Image.file(
                            imgList[widget.product.id],
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 150.0,
                          )
                        : Icon(
                            LineAwesomeIcons.camera,
                            size: 96,
                          ),
              ));
  }
}
