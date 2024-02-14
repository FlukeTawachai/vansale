// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:longdo_maps_api3_flutter/longdo_maps_api3_flutter.dart';
// import 'package:vansale/api/class/request/customer/customerrequest.dart';
// import 'package:vansale/api/class/utility.dart';
// import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_select_image.dart';

// class DeliveryNewSupplierShowMap extends StatefulWidget {
//   final String typeMenuCode;
//   final CustomerRequest request;
//   DeliveryNewSupplierShowMap(this.typeMenuCode, {this.request});

//   @override
//   State<DeliveryNewSupplierShowMap> createState() =>
//       _DeliveryNewSupplierShowMapState();
// }

// class _DeliveryNewSupplierShowMapState
//     extends State<DeliveryNewSupplierShowMap> {
//   final map = GlobalKey<LongdoMapState>();
//   final GlobalKey<ScaffoldMessengerState> messenger =
//       GlobalKey<ScaffoldMessengerState>();
//   Object marker;
//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   bool isInit = false;
//   Position _currentPosition;
//   List<LatLng> lstLocation = [];
//   Future<bool> processFunction;

//   @override
//   void initState() {
    
//     super.initState();
//     processFunction = initLocation();

//     isInit = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: processFunction,
//         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (!isInit) {
//             WidgetsBinding.instance.addPostFrameCallback(
//                 (_) => Future.delayed(const Duration(seconds: 2), () {
//                       addMarker(context);
//                     }));
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback(
//                 (_) => Future.delayed(const Duration(seconds: 1), () {
//                       Geolocator.getCurrentPosition(
//                               desiredAccuracy: LocationAccuracy.best)
//                           .then((value) {
//                         print('Location update.');
//                         _currentPosition = value;
//                         updatePinOnMap();
//                       });
//                     }));
//           }

//           return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text('เพิ่มร้านค้า'),
//             ),
//             backgroundColor: Colors.black12,
//             body: LongdoMapWidget(
//               bundleId: "localhost",
//               apiKey: "207ebbb6c5b600a80fb7fae8244d930e",
//               key: map,
//             ),
//             bottomNavigationBar: btnSaveLocation(),
//           );
//         });
//   }

//   Widget searchLocation() {
//     return Container(
//       height: 60.0,
//       color: Colors.transparent,
//       child: Container(
//         alignment: Alignment.centerLeft,
//         color: Colors.transparent,
//         height: 60.0,
//         child: Container(
//           alignment: Alignment.center,
//           margin: const EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: TextField(
//                     style: TextStyle(
//                       fontFamily: 'Prompt',
//                     ),
//                     textInputAction: TextInputAction.search,
//                     decoration: InputDecoration(
//                       hintText: "ค้นหาตำแหน่ง...",
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.only(left: 5.0, top: 5.0),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.search,
//                           color: HexColor('#6c7e9b'),
//                         ),
//                         onPressed: () {},
//                         iconSize: 25.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 70.0,
//                 alignment: Alignment.center,
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: HexColor("#6c7e9b"),
//                     shape: CircleBorder(),
//                   ),
//                   child: Icon(
//                     LineAwesomeIcons.crosshairs,
//                     color: Colors.white,
//                     size: 15.0,
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget btnSaveLocation() {
//     return Container(
//       height: 60.0,
//       color: Colors.white,
//       child: Container(
//         child: InkWell(
//           onTap: () {
//             widget.request.address.latitude =
//                 _currentPosition.latitude.toString();
//             widget.request.address.longtitude =
//                 _currentPosition.longitude.toString();

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                     DeliveryNewSupplierSelectImage(widget.typeMenuCode,
//                         request: widget.request),
//               ),
//             );
//           },
//           child: Container(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       child: RotationTransition(
//                         turns: new AlwaysStoppedAnimation(30 / 360),
//                         child: Icon(
//                           LineAwesomeIcons.location_arrow,
//                           size: 25.0,
//                           color: HexColor('#00cb39'),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10.0,
//                     ),
//                     Container(
//                       //alignment: Alignment.centerLeft,
//                       child: Text(
//                         'บันทึกตำแหน่ง',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: HexColor('#00cb39'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               /*SizedBox(
//                 child: Divider(
//                   height: 5.0,
//                   indent: 130.0,
//                   endIndent: 120.0,
//                   thickness: 2.0,
//                   color: HexColor('#00cb39'),
//                 ),
//               ),*/
//             ],
//           )),
//         ),
//       ),
//     );
//   }

//   Future<bool> initLocation() async {
//     LocationPermission permission;

//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         throw Exception('Location permission is not allow.');
//       }
//     }

//     print('Get location');
//     _currentPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     //myLocation = await location.getLocation();
//     return true;
//   }

//   addMarker(context) {
//     if (!isInit) {
//       map.currentState?.ui('DPad', 'visible', 0);
//       map.currentState?.ui('Toolbar', 'visible', 0);
//       //map.currentState?.ui('Scale', 'visible', 0);
//       map.currentState?.ui('Zoombar', 'visible', 0);
//       map.currentState?.ui('LayerSelector', 'visible', 0);

//       print('Create marker');
//       marker = map.currentState?.object(
//         "Marker",
//         "1",
//         [
//           {"lon": _currentPosition.longitude, "lat": _currentPosition.latitude},
//           {"detail": "Home"}
//         ],
//       );
//       map.currentState?.call("Overlays.add", [marker]);

//       print('Update bounds.');
//       lstLocation.add(LatLng(
//           lat: _currentPosition.latitude, lon: _currentPosition.longitude));

//       var bound = Utility.boundsFromLatLngList(lstLocation);
//       map.currentState?.call('bound', [bound]);
//       isInit = true;
//     }
//     /*
//     location.onLocationChanged.listen((LocationData cLoc) {
//       // cLoc contains the lat and long of the
//       // current user's position in real time,
//       // so we're holding on to it
//       myLocation = cLoc;

//       updatePinOnMap();
//     });
//     */
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((value) {
//       print('Location update.');
//       _currentPosition = value;
//       updatePinOnMap();
//     });
//     /*
//       location.getLocation().then((value) {
//         myLocation = value;
//         updatePinOnMap();
//       });
//       */
//   }

//   void updatePinOnMap() async {
//     print('Update marker');

//     map.currentState?.objectCall(marker, 'move', [
//       {"lon": _currentPosition.longitude, "lat": _currentPosition.latitude},
//       true
//     ]);
//     setState(() {});
//   }
// }
