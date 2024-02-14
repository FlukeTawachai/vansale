import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getGroupRouteReq.dart';
import 'package:vansale/api/class/response/routeMobile/getCustInRouteResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';
import 'package:vansale/screens/home/home.dart';

class StoreInRoute extends StatefulWidget {
  final GetGroupRouteReq request;
  const StoreInRoute({
    Key key,
    this.request,
  }) : super(key: key);

  @override
  State<StoreInRoute> createState() => _StoreInRouteState();
}

class _StoreInRouteState extends State<StoreInRoute> {
  List<GetCustInRouteResp> storeList = [];
  List<GetCustInRouteResp> showStoreList = [];
  double widthScreen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustInRoute(widget.request, true);
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("รายการร้านค้า"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemCount: showStoreList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.all(3.0),
                      color: HexColor("#F2F3F4"),
                      child: Column(
                        children: [
                          listDetail_(showStoreList[index]),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ],
                      ));
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          onSubmitted: (value) {
                            if (value != '' && value != null) {
                              widget.request.cCUSTNM = "%$value%";
                              getCustInRoute(widget.request, false);
                            } else {
                              showStoreList = storeList;
                            }
                          },
                          style: TextStyle(
                            fontFamily: 'Prompt',
                          ),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "ค้นหา",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 5.0, top: 5.0),
                            prefixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: HexColor('#6c7e9b'),
                                ),
                                onPressed: () {},
                                iconSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget listDetail_(GetCustInRouteResp storeTotal) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 96,
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
                    image: storeTotal.cPHOTOPATH != ''
                        ? DecorationImage(
                            image: new NetworkImage(
                              'http://${storeTotal.cPHOTOSERV}/${storeTotal.cPHOTOPATH}',
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
                    height: 96,
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            storeTotal.cCUSTNM,
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
                       Container(
                            width: widthScreen * 0.6,
                            height: 48,
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${storeTotal.cADDRESS} ${storeTotal.cSUBDIST} ${storeTotal.cDISTRICT} ${storeTotal.cPROVINCE} ${storeTotal.cPOSTCD} ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              maxLines: 3,
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
                      color: Colors.grey,
                    ),
                    onPressed: () {},
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
                            'เบอร์ติดต่อ',
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
                              '${storeTotal.cCONTACTTEL} ระยะห่าง ${storeTotal.cDISTANCS} กม.',
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
                      openMaps(double.parse(storeTotal.cLATITUDE),
                          double.parse(storeTotal.cLONGTITUDE));

                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             HomePage(GlobalParam.typeMenuCode)),
                      //     (Route<dynamic> route) => false);
                    },
                    iconSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCustInRoute(GetGroupRouteReq req, bool first) async {
    if (req != null) {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();

        var result = await proxy.getCustInRoute(req);
        if ((result.isNotEmpty)) {
          setState(() {
            if (first == true) {
              storeList = result;
            }
            showStoreList = result;
          });
        }
      } on SocketException catch (e) {
        wrongDialog(e.message);
      } on Exception catch (e) {
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog("Request is null");
    }
  }

  openMaps(double lat, double lng) async {
    await LocationServices().openGoogleMap(lat, lng);
  }
}
