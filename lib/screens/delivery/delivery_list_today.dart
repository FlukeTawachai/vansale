import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';

class DeliveryListToday extends StatefulWidget {
  //const DeliveryListToday({ Key? key }) : super(key: key);

  final List<RouteCusResp> showStore;
  final List<PoHDAndPoDTResp> sumOfStore;
  DeliveryListToday(this.showStore, this.sumOfStore);
  @override
  _DeliveryListTodayState createState() => _DeliveryListTodayState();
}

class _DeliveryListTodayState extends State<DeliveryListToday> {
  List<RouteCusResp> store = GlobalParam.deliveryListStores;
  double total = 3200.00;
  double widthScreen;
  List<PoHDAndPoDTResp> storeTotal = [];

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return widget.showStore.length == 0
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemCount: widget.showStore.length,
            itemBuilder: (BuildContext context, int index) {
              // getPocdOfcustomer(widget.showStore[index].cCUSTCD);
              for (int i = 0; i < widget.sumOfStore.length; i++) {
                if (widget.showStore[index].cCUSTCD ==
                    widget.sumOfStore[i].cCUSTCD) {
                  storeTotal.add(widget.sumOfStore[i]);
                }
              }
              // print(
              //     '============ ${storeTotal.length} : ${widget.showStore.length} ============');
              return storeTotal.length == 0
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.all(3.0),
                      color: HexColor("#F2F3F4"),
                      child: Column(
                        children: [
                          listDetail_(index, storeTotal[index]),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ],
                      ));
            },
          );
  }

  Widget listDetail_(index, PoHDAndPoDTResp storeTotal) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: widget.showStore[index].cPHOTOPATH != ''
                        ? DecorationImage(
                            image: new NetworkImage(
                              'http://${widget.showStore[index].cPHOTOSERV}/${widget.showStore[index].cPHOTOPATH}',
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.showStore[index].cCUSTNM,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Flexible(
                          child: Container(
                            width: widthScreen * 0.6,
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.showStore[index].cADDRESS} ${widget.showStore[index].cSUBDIST} ${widget.showStore[index].cDISTRICT} ${widget.showStore[index].cPROVINCE} ${widget.showStore[index].cPOSTCD}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  child: IconButton(
                    icon: Icon(
                      LineAwesomeIcons.dolly,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         DeliveryStoreHome(widget.typeMenuCode,historys[index]['name']),
                      //   ),
                      // );
                      GlobalParam.deliverySelectStore = widget.showStore[index];
                      GlobalParam.deliveryStoreSum = storeTotal;
                      GlobalParam.deliveryStoreReturn = PoHDAndPoDTResp(
                          cCUSTCD: storeTotal.cCUSTCD,
                          cPOCD: storeTotal.cPOCD,
                          iTOTAL: '0',
                          iitems: '0',
                          ibasket: '0');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DeliveryCheckIn(storeTotal.cPOCD, false)
                            // CurrentLocation(openMap: false),
                            ),
                      );
                    },
                    iconSize: 20.0,
                  ),
                ),
              ],
            ),
          ),

          //-------------
          Container(
            padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 60.0,
                  child: Icon(
                    LineAwesomeIcons.map_marked,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ระยะทาง',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.showStore[index].cDISTANCS} กม.',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  child: IconButton(
                    icon: Icon(
                      LineAwesomeIcons.location_arrow,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      GlobalParam.deliverySelectStore = widget.showStore[index];
                      GlobalParam.deliveryStoreSum = storeTotal;
                      GlobalParam.deliveryStoreReturn = PoHDAndPoDTResp(
                          cCUSTCD: storeTotal.cCUSTCD,
                          cPOCD: storeTotal.cPOCD,
                          iTOTAL: '0',
                          iitems: '0',
                          ibasket: '0');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                // CurrentLocation(openMap: true),
                                DeliveryCheckIn(storeTotal.cPOCD, true)),
                      );
                    },
                    iconSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          //------------------------------
          Container(
            padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              children: [
                Container(
                  width: 60.0,
                  child: Icon(
                    LineAwesomeIcons.user,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.showStore[index].cCONTACT,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.showStore[index].cCONTACTTEL,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  alignment: Alignment.centerRight,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      icon: Icon(
                        LineAwesomeIcons.phone,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                      iconSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //---------------------
          Container(
            padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.0,
                  child: Icon(
                    FontAwesomeIcons.boxes,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${double.parse(storeTotal.iitems).toStringAsFixed(0)} รายการ ,${double.parse(storeTotal.ibasket).toStringAsFixed(0)} ตะกร้า',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${storeTotal.cPOCD}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Utility.formateNumberOrenge(
                            double.parse(storeTotal.iTOTAL)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'THB',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 14.0,
                              color: Colors.grey,
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
    );
  }
}
