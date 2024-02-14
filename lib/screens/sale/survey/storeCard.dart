import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/screens/sale/survey/sale_checkIn.dart';

class SaleSurveyCard extends StatefulWidget {
  //const DeliveryListToday({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final GetSaleStoreOrderResp store;
  SaleSurveyCard(this.typeMenuCode, this.store);
  @override
  _SaleSurveyCardState createState() => _SaleSurveyCardState();
}

class _SaleSurveyCardState extends State<SaleSurveyCard> {
  DateTime dt1 = DateTime.now();
  DateTime dt2 = DateTime.parse("2022-10-17T09:57:17.274Z");

  @override
  Widget build(BuildContext context) {
    Duration diff = dt1.difference(dt2);
    return Container(
      padding: const EdgeInsets.all(3.0),
      color: HexColor("#F2F3F4"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 250.0,
            child: Column(
              children: [
                Expanded(
                  child: Container(
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
                            image: widget.store.cPHOTOPATH != ''
                                ? DecorationImage(
                                    image: new NetworkImage(
                                      'http://${widget.store.cPHOTOSERV}/${widget.store.cPHOTOPATH}',
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
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.store.cCUSTNM,
                                        style: TextStyle(
                                          fontFamily: 'Prompt',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      diff.inDays < 30
                                          ? Text(
                                              "NEW",
                                              style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Colors.blue.shade400),
                                            )
                                          : Text(
                                              "",
                                              style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Colors.blue.shade400),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${widget.store.cADDRESS} ${widget.store.cSUBDIST} ${widget.store.cDISTANCS} ${widget.store.cPROVINCE} ${widget.store.cPOSTCD} ",
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
                              LineAwesomeIcons.dolly,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              GlobalParam.deliverySelectStore = RouteCusResp(
                                cGUID: widget.store.cGUID,
                                cCUSTCD: widget.store.cCUSTCD,
                                cCUSTNM: widget.store.cCUSTNM,
                                cCUSTBNM: widget.store.cCUSTBNM,
                                cTAXNO: widget.store.cTAXNO,
                                cTEL: widget.store.cTEL,
                                cCONTACT: widget.store.cCONTACT,
                                cCONTACTTEL: widget.store.cCONTACTTEL,
                                cLINEID: widget.store.cLINEID,
                                cBRANCD: widget.store.cBRANCD,
                                cCUSTTYPE: widget.store.cCUSTTYPE,
                                cPAYTYPE: widget.store.cPAYTYPE,
                                iCREDTERM: widget.store.iCREDTERM,
                                iCREDLIM: widget.store.iCREDLIM,
                                cTSELLCD: widget.store.cTSELLCD,
                                cISBASKET: widget.store.cISBASKET,
                                cSTATUS: widget.store.cSTATUS,
                                cGRPCD: widget.store.cGRPCD,
                                cRTECD: widget.store.cRTECD,
                                iSEQROUTE: widget.store.iSEQROUTE,
                                cISPHOTO: widget.store.cISPHOTO,
                                cPHOTOSERV: widget.store.cPHOTOSERV,
                                cPHOTOPATH: widget.store.cPHOTOPATH,
                                cPHOTONM: widget.store.cPHOTONM,
                                cADDRESS: widget.store.cADDRESS,
                                cDISTRICT: widget.store.cDISTRICT,
                                cSHIPTO: widget.store.cSHIPTO,
                                cLOCATION: widget.store.cLOCATION,
                                cPROVINCE: widget.store.cPROVINCE,
                                cSUBDIST: widget.store.cSUBDIST,
                                cPOSTCD: widget.store.cPOSTCD,
                                cDISTANCS: widget.store.cDISTANCS,
                                cASSET: widget.store.cASSET,
                                cLATITUDE: widget.store.cLATITUDE ?? "0",
                                cLONGTITUDE: widget.store.cLONGTITUDE ?? "0",
                                // cPREPAIRCFSTATUS: widget.store.cPREPAIRCFSTATUS,
                                // cPOSTATUS: widget.store.cPOSTATUS,
                                dCREADT: widget.store.dCREADT,
                                cCREABY: widget.store.cCREABY,
                                dUPDADT: widget.store.dUPDADT,
                                cUPDABY: widget.store.cUPDABY,
                              );
                              GlobalParam.surveyStore = widget.store;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SaleCheckIn(false, '01', widget.store),
                                ),
                              );
                            },
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //---------Column2
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          child: Icon(
                            LineAwesomeIcons.map_marked,
                            color: Colors.grey,
                            size: 20.0,
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
                                    'ระยะห่าง',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${widget.store.cDISTANCS} กม.",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.grey,
                                      fontSize: 14.0,
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
                              GlobalParam.deliverySelectStore.cCUSTCD =
                                  widget.store.cCUSTCD;
                              GlobalParam.deliverySelectStore.cLATITUDE =
                                  widget.store.cLATITUDE;
                              GlobalParam.deliverySelectStore.cLONGTITUDE =
                                  widget.store.cLONGTITUDE;
                              GlobalParam.deliverySelectStore.cCUSTCD =
                                  widget.store.cCUSTCD;
                              GlobalParam.deliverySelectStore.cADDRESS =
                                  widget.store.cADDRESS;
                              GlobalParam.deliverySelectStore.cSUBDIST =
                                  widget.store.cSUBDIST;
                              GlobalParam.deliverySelectStore.cDISTRICT =
                                  widget.store.cDISTRICT;
                              GlobalParam.deliverySelectStore.cPROVINCE =
                                  widget.store.cPROVINCE;
                              GlobalParam.deliverySelectStore.cPOSTCD =
                                  widget.store.cPOSTCD;
                              // for (var i = 0;
                              //     i < GlobalParam.deliveryListStores.length;
                              //     i++) {
                              //   if (GlobalParam.deliveryListStores[i].cCUSTCD ==
                              //       widget.store.cCUSTCD) {
                              //     GlobalParam.deliverySelectStore =
                              //         GlobalParam.deliveryListStores[i];
                              //   }
                              // }
                              if (GlobalParam.deliverySelectStore.cCUSTCD !=
                                      null &&
                                  GlobalParam.deliverySelectStore.cCUSTCD !=
                                      '') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SaleCheckIn(true, '02', widget.store),
                                  ),
                                );
                              }
                            },
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //---------Column3
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          child: Icon(
                            LineAwesomeIcons.user,
                            color: Colors.grey,
                            size: 20.0,
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
                                    widget.store.cCONTACT,
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
                                      widget.store.cTEL,
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
                ),
                //-----------col4
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
