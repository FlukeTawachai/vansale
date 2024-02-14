// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/globalparam.dart';

class DeliveryStoreProductCheckList extends StatefulWidget {
  @override
  State<DeliveryStoreProductCheckList> createState() =>
      _DeliveryStoreProductCheckListState();
}

class _DeliveryStoreProductCheckListState
    extends State<DeliveryStoreProductCheckList> {
  var IncomPro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GlobalParam.deliveryPodtShow.length > 0
        ? ListView.builder(
            reverse: false,
            padding: const EdgeInsets.all(5),
            itemCount: GlobalParam.deliveryPodtShow.length,
            itemBuilder: (BuildContext context, int index) {
              double item = double.parse(
                      GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!);
              var unit = '';
              var unitCode = '';
              var unitPrice = '';
              if (double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cSUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iSUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cSUOMCD!;
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cMUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iMUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cMUOMCD!;
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cLUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iLUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cLUOMCD!;
              }
              return Container(
                color: HexColor("#F2F3F4"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 110.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 100.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                image: GlobalParam.deliveryPodtShow[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          'http://${GlobalParam.deliveryPodtShow[index].cPHOTOSERV}/${GlobalParam.deliveryPodtShow[index].cPHOTOPATH}',
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
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey)),
                          ),
                          //----------------------1
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    GlobalParam
                                        .deliveryPodtShow[index].cPRODNM!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Prompt',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: GlobalParam
                                                          .deliveryPodtShow
                                                          .length >
                                                      0
                                                  ? Text(
                                                      '${item.toStringAsFixed(0)} $unit',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Prompt',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    )
                                                  : Text(
                                                      ' ตะกร้า',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Prompt',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                GlobalParam
                                                    .deliveryPodtShow[index]
                                                    .cPOCD!,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Prompt',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: 100.0,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 36.0,
                                            width: 64.0,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'สินค้าขาด',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: 96.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: TextField(
                                                  // controller: IncomPro,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    color: HexColor('#00cb39'),
                                                    fontFamily: 'Prompt',
                                                  ),
                                                  cursorColor: Colors.black,
                                                  decoration:
                                                      new InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onChanged: (value) {
                                                    int iINCOMPRO = 0;

                                                    setState(() {
                                                      if (value == '' ||
                                                          value == null) {
                                                        for (int j = 0;
                                                            j <
                                                                GlobalParam
                                                                    .deliveryUnitList
                                                                    .length;
                                                            j++) {
                                                          if (GlobalParam
                                                                      .deliveryUnitList[j]
                                                                  ["cPRODCD"] ==
                                                              GlobalParam
                                                                  .deliveryPodtShow[
                                                                      index]
                                                                  .cPRODCD) {
                                                            if (GlobalParam
                                                                        .deliveryUnitList[j]
                                                                    [
                                                                    "cUOMCD"] ==
                                                                unitCode) {
                                                              GlobalParam
                                                                  .deliveryUnitList
                                                                  .removeAt(j);
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        iINCOMPRO =
                                                            int.parse(value);
                                                        var data = {
                                                          "cPRODCD": GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .cPRODCD,
                                                          "cUOMCD": unitCode,
                                                          "cUOMNM": unit,
                                                          "iPRICE": unitPrice,
                                                          "iTOTAL":
                                                              double.parse(
                                                                  '$iINCOMPRO')
                                                        };
                                                        GlobalParam
                                                            .deliveryUnitList
                                                            .add(data);
                                                      }
                                                    });

                                                    for (int i = 0;
                                                        i <
                                                            GlobalParam
                                                                .deliveryPodtList
                                                                .length;
                                                        i++) {
                                                      // ignore: unrelated_type_equality_checks
                                                      if (GlobalParam
                                                              .deliveryPodtList[
                                                                  i]
                                                              .iSEQ ==
                                                          GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .iSEQ) {
                                                        GlobalParam
                                                            .deliveryPodtList[i]
                                                            .iINCOMPRO = iINCOMPRO;
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
