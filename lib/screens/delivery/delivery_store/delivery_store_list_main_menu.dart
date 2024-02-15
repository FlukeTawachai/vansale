import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_list_basket.dart';

class DeliveryStoreListMainMenuHD extends StatefulWidget {
  final String storeName;

  const DeliveryStoreListMainMenuHD({Key? key, required this.storeName})
      : super(key: key);

  @override
  State<DeliveryStoreListMainMenuHD> createState() =>
      _DeliveryStoreListMainMenuHDState();
}

class _DeliveryStoreListMainMenuHDState
    extends State<DeliveryStoreListMainMenuHD> {
  var store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    double debt = double.parse(GlobalParam.deliveryStoreDetail.iTOTAL!) -
        double.parse(GlobalParam.deliveryStoreDetail.iPAID!);
    double remainCredit =
        double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM!) -
            double.parse(GlobalParam.deliveryStoreDetail.iCREDTERM!);
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
                const SizedBox(
                  width: 20.0,
                ),
                Container(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: GlobalParam.deliverySelectStore.cPHOTOPATH != ''
                          ? DecorationImage(
                              image: NetworkImage(
                                'http://${GlobalParam.deliverySelectStore.cPHOTOSERV}/${GlobalParam.deliverySelectStore.cPHOTOPATH}',
                              ),
                              scale: 1.0,
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(
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
                            style: const TextStyle(
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
                            "${GlobalParam.deliverySelectStore.cADDRESS} ${GlobalParam.deliverySelectStore.cSUBDIST} ${GlobalParam.deliverySelectStore.cDISTRICT} ${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}",
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                    child: const Icon(
                      LineAwesomeIcons.user_check,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
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
                      child: const AutoSizeText(
                        'เยี่ยมครั้งสุดท้าย',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        GlobalParam.deliveryStoreDetail.dCANDT!,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
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
                      child: const AutoSizeText(
                        'สั่งครั้งสุดท้าย',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                        minFontSize: 8.0,
                        maxFontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        GlobalParam.deliveryStoreDetail.dSUCCDT!,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
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
                            child: const AutoSizeText(
                              'เลขบิลครั้งสุดท้าย',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                              minFontSize: 8.0,
                              maxFontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          width: 90.0,
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            GlobalParam.deliveryStoreDetail.cPOCD!,
                            style: const TextStyle(color: Colors.blue),
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
                        child: const AutoSizeText(
                          'ยอดสั่งซื้อ',
                          style: TextStyle(color: Colors.green),
                          minFontSize: 8.0,
                          maxFontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        width: 60.0,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          NumberFormat("#,###", "en_US").format(double.parse(
                              GlobalParam.deliveryStoreDetail.iPOTOTAL!)),
                          style: const TextStyle(
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
                    child: const Icon(
                      LineAwesomeIcons.donate,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
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
                      child: const Text(
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
                        '${NumberFormat("#,###", "en_US").format(GlobalParam.deliveryDebt)} บาท',
                        style: const TextStyle(
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
                      child: const Text(
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
                        '${NumberFormat("#,###", "en_US").format(double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM!))} บาท',
                        style: const TextStyle(
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
                      child: const Text(
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
                        '${NumberFormat("#,###", "en_US").format(double.parse('${double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM!) - double.parse(GlobalParam.deliveryStoreDetail.iCREDTERM!)}'))} บาท',
                        style: const TextStyle(
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
                    child: const Icon(
                      LineAwesomeIcons.shopping_basket,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
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
            const SizedBox(
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
        control: SwiperControl(
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
