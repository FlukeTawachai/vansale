import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_list_basket.dart';

class SaleStoreListMainMenuHD extends StatefulWidget {
  final String? storeName;

  const SaleStoreListMainMenuHD({Key? key, this.storeName}) : super(key: key);

  @override
  State<SaleStoreListMainMenuHD> createState() =>
      _SaleStoreListMainMenuHDState();
}

class _SaleStoreListMainMenuHDState extends State<SaleStoreListMainMenuHD> {
  var store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    double debt = double.parse("0") - double.parse("0");
    double remainCredit = double.parse("0") - double.parse("0");
  }

  var storeDetail = [
    {
      'list': Container(
        //color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: GlobalParam.deliverySelectStore.cPHOTOPATH != ''
                          ? DecorationImage(
                              image: new NetworkImage(
                                'http://${GlobalParam.deliverySelectStore.cPHOTOSERV}/${GlobalParam.deliverySelectStore.cPHOTOPATH}',
                              ),
                              scale: 1.0,
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: new AssetImage(
                                "assets/images/no_image.png",
                              ),
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      right: 5.0,
                      bottom: 5.0,
                      left: 10.0,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            GlobalParam.deliverySelectStore.cCUSTNM!,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${GlobalParam.deliverySelectStore.cADDRESS} ${GlobalParam.deliverySelectStore.cSUBDIST} ${GlobalParam.deliverySelectStore.cDISTRICT} ${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              color: Colors.grey,
                              //fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            GlobalParam.deliverySelectStore.cCONTACTTEL!,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              color: Colors.black54,
                              //fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: Icon(
                      LineAwesomeIcons.user_check,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ประวัติ',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'เยี่ยมครั้งสุดท้าย',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        GlobalParam.deliveryStoreDetail.dCANDT ?? "",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'สั่งครั้งสุดท้าย',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        GlobalParam.deliveryStoreDetail.dSUCCDT ?? "",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'เลขบิลครั้งสุดท้าย',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                              minFontSize: 8.0,
                              maxFontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          width: 90.0,
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            GlobalParam.deliveryStoreDetail.cPOCD ?? "",
                            style: TextStyle(color: Colors.blue),
                            minFontSize: 8.0,
                            maxFontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          'ยอดสั่งซื้อ',
                          style: TextStyle(color: Colors.green),
                          minFontSize: 8.0,
                          maxFontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        width: 60.0,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          '${NumberFormat("#,###", "en_US").format(double.parse(GlobalParam.deliveryStoreDetail.iPOTOTAL??'0'))}',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          minFontSize: 8.0,
                          maxFontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: Icon(
                      LineAwesomeIcons.donate,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เครดิต',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ยอดค้าง',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.red,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${NumberFormat("#,###.##", "en_US").format(GlobalParam.deliveryDebt)} บาท',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.red,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'วงเงินเครดิต',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.grey,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${NumberFormat("#,###", "en_US").format(double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM ?? "0"))} บาท',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.grey,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'วงเงินคงเหลือ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${NumberFormat("#,###", "en_US").format(double.parse('${double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM ??"0") - double.parse(GlobalParam.deliveryStoreDetail.iCREDTERM??"0")}'))} บาท',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  /*SizedBox(
                    width: 50.0,
                  ),*/
                  /* Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.topLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: Icon(
                      LineAwesomeIcons.shopping_basket,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ตระกร้า',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                child: DeliveryStoreListBasket(),
              ),
            ),
          ],
        ),
      ),
    },
  ];
  Utility utility = Utility();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: storeDetail[index]['list'],
            ),
          );
        },
        autoplay: false,
        itemCount: storeDetail.length,
        //pagination: new SwiperPagination(),
        control: new SwiperControl(
          color: Colors.black,
          size: 20.0,
        ),
        layout: SwiperLayout.DEFAULT,
        //viewportFraction: 0.8,
        //scale: 0.9,
      ),
    );
  }
}
