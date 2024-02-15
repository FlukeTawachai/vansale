import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';

String mtTotal = '';

class Details_Main_BasketReturn extends StatefulWidget {
  final bool? IsSale;

  const Details_Main_BasketReturn({Key? key, this.IsSale}) : super(key: key);
  @override
  State<Details_Main_BasketReturn> createState() =>
      _Details_Main_BasketReturnState();
}

class _Details_Main_BasketReturnState extends State<Details_Main_BasketReturn> {
  double widthScreen = 0.0;
  double saleProductPrice = 0.0;
  double saleTotalPrice = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.IsSale == true) {
      if (GlobalParam.saleOrder.cCUSTCD != "" &&
          GlobalParam.saleOrder.aPRODUCT!.isNotEmpty == true) {
            
          }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 122,
      //width: 360,

      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: widthScreen * 0.2,
                  height: 64,
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
                Container(
                  width: widthScreen * 0.6,
                  child: Center(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: widthScreen * 0.6,
                          // height: 48,
                          child: Text(
                            GlobalParam.deliverySelectStore?.cCUSTNM ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            child: address(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: widthScreen * 0.2,
                  child: icon(),
                ),
                Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: number_of_entries(),
                        ),
                        Container(
                          child: Container(
                            child: account_number(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pic() {
    return Container(
      // width: 60.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
        image: GlobalParam.deliverySelectStore?.cPHOTOPATH != ''
            ? DecorationImage(
                image: new NetworkImage(
                  'http://${GlobalParam.deliverySelectStore?.cPHOTOSERV}/${GlobalParam.deliverySelectStore?.cPHOTOPATH}',
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
    );
  }

  Widget storename() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            GlobalParam.deliverySelectStore?.cCUSTBNM ?? '',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget address() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${GlobalParam.deliverySelectStore?.cADDRESS} ${GlobalParam.deliverySelectStore?.cSUBDIST} ${GlobalParam.deliverySelectStore?.cDISTRICT} ${GlobalParam.deliverySelectStore?.cPROVINCE} ${GlobalParam.deliverySelectStore?.cPOSTCD}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
    );
  }

  Widget icon() {
    return Container(
      width: 70,
      //alignment: Alignment.centerRight,
      child: Icon(
        FontAwesomeIcons.box,
        size: 20.0,
        color: Colors.grey,
      ),
    );
  }

  Widget number_of_entries() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${(double.tryParse(GlobalParam.deliveryStoreSum?.iitems ?? "0") ?? 0).toInt()} รายการ, ${(double.tryParse(GlobalParam.deliveryStoreSum?.ibasket ?? "0") ?? 0).toInt()} ตะกร้า",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }

  Widget account_number() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            GlobalParam.deliveryStoreSum?.cPOCD ?? '',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }
}

class Details_Main_BasketReturn_Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 70,
      //width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: label1(),
                  ),
                  Container(
                    child: Container(
                      child: label2(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: label3(),
          ),
        ],
      ),
    );
  }

  Widget label1() {
    // double totalItem = 0;
    // double totalIncom = 0;
    // double totalCancel = 0;
    // double totalReGood = 0;
    // double totalReBad = 0;
    // for (int i = 0; i < GlobalParam.deliveryProIncom.length; i++) {
    //   var qty = 0.0;
    //   var price = 0.0;
    //   qty = double.tryParse('${GlobalParam.deliveryProIncom[i].iINCOMPRO}') ??
    //       0.0;
    //   if (double.tryParse(GlobalParam.deliveryProIncom[i].iSSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryProIncom[i].iSUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryProIncom[i].iMSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryProIncom[i].iMUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryProIncom[i].iLSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryProIncom[i].iLUNITPRICE);
    //   }
    //   totalIncom += qty * price;
    // }

    // for (int i = 0; i < GlobalParam.deliveryPodCancel.length; i++) {
    //   var qty = 0.0;
    //   var price = 0.0;
    //   qty = double.tryParse('${GlobalParam.deliveryPodCancel[i].iCANCLEPRO}');
    //   if (double.tryParse(GlobalParam.deliveryPodCancel[i].iSSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryPodCancel[i].iSUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryPodCancel[i].iMSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryPodCancel[i].iMUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryPodCancel[i].iLSIZEQTY) > 0) {
    //     price = double.tryParse(GlobalParam.deliveryPodCancel[i].iLUNITPRICE);
    //   }
    //   totalCancel += qty * price;
    // }

    // for (int i = 0; i < GlobalParam.deliveryReturnGoodPro.length; i++) {
    //   var qty = 0.0;
    //   var price = 0.0;
    //   qty =
    //       double.tryParse('${GlobalParam.deliveryReturnGoodPro[i].iCANCLEPRO}');
    //   if (double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iSSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iSUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iMSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iMUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iLSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnGoodPro[i].iLUNITPRICE);
    //   }
    //   totalReGood += qty * price;
    // }

    // for (int i = 0; i < GlobalParam.deliveryReturnBadPro.length; i++) {
    //   var qty = 0.0;
    //   var price = 0.0;
    //   qty =
    //       double.tryParse('${GlobalParam.deliveryReturnBadPro[i].iCANCLEPRO}');
    //   if (double.tryParse(GlobalParam.deliveryReturnBadPro[i].iSSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnBadPro[i].iSUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryReturnBadPro[i].iMSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnBadPro[i].iMUNITPRICE);
    //   }
    //   if (double.tryParse(GlobalParam.deliveryReturnBadPro[i].iLSIZEQTY) > 0) {
    //     price =
    //         double.tryParse(GlobalParam.deliveryReturnBadPro[i].iLUNITPRICE);
    //   }
    //   totalReBad += qty * price;
    // }
    // String totalPay =
    //     '${(double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL) ?? 0.0) - totalIncom - totalCancel - totalReGood - totalReBad}';
    // String totalPay2 =
    //     '${(double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL) ?? 0.0) - totalIncom - totalCancel - totalReGood - totalReBad - GlobalParam.basketReturn['basketReturnPrice']}';
    // mtTotal = '$totalPay2';

    String totalPay =
        '${(double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL ?? "0") ?? 0.0)}';
    String totalPay2 =
        '${(double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL ?? "0") ?? 0.0) - GlobalParam.basketReturn['basketReturnPrice']!}';
    mtTotal = '$totalPay2';
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ราคาสินค้า    $totalPay บาท',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ]),
    );
  }

  Widget label2() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ส่วนลดสินค้า    ${GlobalParam.basketReturn['basketReturnPrice']} บาท',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ]),
    );
  }

  Widget label3() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: substringPay(mtTotal),
      ),
    );
  }

  substringPay(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];

    var aa = RichText(
      text: TextSpan(
        text: '$bb',
        style: TextStyle(
          fontSize: 18,
          color: HexColor('#fc971e'),
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: 'THB',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Prompt',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}

class Details_Main_BasketReturn_more extends StatelessWidget {
  var nf = NumberFormat("###.0#", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      //color: Color.fromRGBO(233, 233, 233, 1.0),
      //height: 70,
      //width: 480,
      child: Column(
        children: [
          Container(
            child: label1(),
          ),
          Container(
            child: label2(),
          ),
          Container(
            child: label3(),
          ),
          Container(
            child: label4(),
          ),
        ],
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ยอดค้างชำระ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '0 บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label2() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ส่วนลดท้ายบิล',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '0 บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label3() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ยอดปัจจุบัน',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '${nf.format(double.parse(mtTotal))} บาท',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ]),
    );
  }

  Widget label4() {
    String totalCashCheck = '3100.00';
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'รวมทั้งหมด',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            // padding: const EdgeInsets.only(top: 5.0, left: 50.0, right: 7.0),
            child: substringCashCheck(mtTotal),
          ),
        ],
      ),
    );
  }

  substringCashCheck(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];
    var aa = RichText(
      text: TextSpan(
        text: '$bb',
        style: TextStyle(
          fontSize: 18,
          color: HexColor('#fc971e'),
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: 'THB',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Prompt',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
