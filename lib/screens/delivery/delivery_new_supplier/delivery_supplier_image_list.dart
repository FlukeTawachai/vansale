import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_select_image.dart';

class ImageStoreList extends StatefulWidget {
  final CustomerRequest request;
  const ImageStoreList({Key key, this.request}) : super(key: key);

  @override
  State<ImageStoreList> createState() => _ImageStoreListState();
}

class _ImageStoreListState extends State<ImageStoreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รูปร้านค้า'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                for (File imageFile in GlobalParam.imageStoreList)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        GlobalParam.deliveryImage = File(imageFile.path);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                DeliveryNewSupplierSelectImage(
                                    GlobalParam.typeMenuCode,
                                    request: widget.request,
                                    subMenu: '')));
                      },
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
