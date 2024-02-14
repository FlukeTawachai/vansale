import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/request/mobile/getCustomerOfBranchReq.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerOfBranchResp.dart';
import 'package:vansale/screens/delivery/delivery_map/map_street_view.dart';

class MapStores extends StatefulWidget {
  final GetCustomerOfBranchReq req;
  const MapStores({Key? key, required this.req}) : super(key: key);

  @override
  State<MapStores> createState() => _MapStoresState();
}

class _MapStoresState extends State<MapStores> {
  List<GetCustomerOfBranchResp> storeList = [];
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  LatLng showLocation =
      const LatLng(13.751533, 100.493688); //location to show in map
  late GoogleMapController _controller;
  MapType _currentMapType = MapType.normal;
  List<DropdownMenuItem<String>> group = [
    const DropdownMenuItem(child: Text("พื้นฐาน"), value: "1"),
    const DropdownMenuItem(child: Text("ดาวเทียม"), value: "2"),
  ];
  String selectType = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustInRoute(widget.req);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("แผนที่"),
      ),
      body: Stack(children: [
        GoogleMap(
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: showLocation, //initial position
            zoom: 15.0, //initial zoom level
          ),
          markers: getmarkers(), //markers to show on map
          mapType: _currentMapType, //map type
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Spacer(),
              Container(
                width: widthScreen * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                            value: selectType,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 16,
                              color: HexColor('#000000'),
                              // fontFamily: "Prompt",
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == "1") {
                                  _currentMapType = MapType.normal;
                                  selectType = "1";
                                } else if (value == "2") {
                                  _currentMapType = MapType.hybrid;
                                  selectType = "2";
                                }
                              });
                            },
                            items: group))),
              ),
              // IconButton(
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => StreetViewPanoramaInitDemo()));
              //     },
              //     icon: Icon(Icons.location_city))
            ],
          ),
        )
      ]),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    if (storeList.length > 0) {
      setState(() {
        for (var item in storeList) {
          BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
          String part = "assets/images/map-pin01.png";
          if (item.cGRPCD == "GRMON") {
            part = "assets/images/map-pin02.png";
          }

          if (item.cGRPCD == "GRTUE") {
            part = "assets/images/map-pin03.png";
          }
          if (item.cGRPCD == "GRWED") {
            part = "assets/images/map-pin04.png";
          }
          if (item.cGRPCD == "GRTHU") {
            part = "assets/images/map-pin05.png";
          }
          if (item.cGRPCD == "GRFRI") {
            part = "assets/images/map-pin06.png";
          }
          if (item.cGRPCD == "GRSAT") {
            part = "assets/images/map-pin07.png";
          }

          BitmapDescriptor.fromAssetImage(const ImageConfiguration(), part)
              .then(
            (icon) {
              markers.add(Marker(
                //add first marker
                markerId: MarkerId(LatLng(double.parse(item.cLATITUDE ?? '0'),
                        double.parse(item.cLONGTITUDE ?? '0'))
                    .toString()),
                position: LatLng(double.parse(item.cLATITUDE ?? '0'),
                    double.parse(item.cLONGTITUDE ?? '0')), //position of marker
                infoWindow: InfoWindow(
                  //popup info
                  title: "${item.iSEQROUTE} ${item.cCUSTCD} ${item.cCUSTNM}",
                  snippet:
                      '${item.cADDRESS} ${item.cSUBDIST} ${item.cDISTRICT} ${item.cPROVINCE} ${item.cPOSTCD}',
                ),
                // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                icon: icon,
              ));
            },
          );
        }
      });
    }

    return markers;
  }

  getCustInRoute(GetCustomerOfBranchReq req) async {
    if (req != null) {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();

        var result = await proxy.getCustomerOfBranch(req);
        if ((result.isNotEmpty)) {
          setState(() {
            for (var item in result) {
              if (item.cLATITUDE != null && item.cLONGTITUDE != null) {
                storeList.add(item);
              }
            }
          });

          _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(double.parse(storeList[0].cLATITUDE ?? '0'),
                      double.parse(storeList[0].cLONGTITUDE ?? '0')),
                  zoom: 5.00)));
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
}
