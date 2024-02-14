import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/screens/googleMap/currentLocation.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:custom_marker/marker_icon.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key key}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  TextEditingController source = new TextEditingController();
  TextEditingController destination = new TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marker = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polyline = Set<Polyline>();
  List<LatLng> _polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _polyLineIdCounter = 1;
  final GlobalKey globalKey = GlobalKey();

  // static final Marker desMarker = Marker(
  //     markerId: MarkerId('desPlex'),
  //     infoWindow: InfoWindow(title: 'desGooglePlex'),
  //     icon: BitmapDescriptor.defaultMarker,
  //     position: LatLng(37.42796133580664, -122.085749655962));

  // static final Marker sourceMarker = Marker(
  //   markerId: MarkerId('sourcePlex'),
  //   infoWindow: InfoWindow(title: 'sourceGooglePlex'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(37.43296265331129, -122.08832357078792),
  // );

  // static final Polyline testPolyLine = Polyline(
  //     polylineId: PolylineId('testPolyLine'),
  //     points: [
  //       LatLng(37.43296265331129, -122.08832357078792),
  //       LatLng(37.42796133580664, -122.085749655962)
  //     ],
  //     width: 5,
  //     color: Colors.blue);

  // static final Polygon testPolygon = Polygon(
  //     polygonId: PolygonId('testPolygon'),
  //     points: [
  //       LatLng(37.43296265331129, -122.08832357078792),
  //       LatLng(37.42796133580664, -122.085749655962),
  //       LatLng(37.418, -122.092),
  //       LatLng(37.435, -122.092)
  //     ],
  //     strokeWidth: 5,
  //     strokeColor: Colors.blue,
  //     fillColor: Colors.transparent);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    destination.text = 'โรงพยาบาลบางปะกอก 9';
    source.text = 'ตลาดน้ำคลองลัดมะยม';
    // setMarker(LatLng(37.43296265331129, -122.08832357078792));
    startLocation();
    // getLocationStore();
  }

  void startLocation() async {
    // var directions =
    //     await LocationServices().getDirections(destination.text, source.text);

    // var place = await LocationServices().getPlace(destination.text);

    // setPlaceOnInit(place);

    // _goToPlace(
    //   directions["start_location"]['lat'],
    //   directions['start_location']['lng'],
    //   directions['bounds_ne'],
    //   directions['bounds_sw'],
    // );

    // setPolyLine(directions['polyline_decode']);

    final GoogleMapController controller = await _controller.future;
    double lat = GlobalParam.deliveryLocationStoreLatitude;
    double lng = GlobalParam.deliveryLocationStoreLongitude;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    setMarker(LatLng(lat, lng));
  }

  void setMarker(LatLng point) async {
    // Position position = await LocationServices().determinePosition();
    // // print('+++++++++++${position.latitude},${position.longitude}+++++++++++');

    // var desPoint = await LocationServices().getPlace(destination.text);
    // setPlaceOnInit(desPoint, LatLng(position.latitude, position.longitude));
    // final double lat = desPoint['geometry']['location']['lat'];
    // final double lng = desPoint['geometry']['location']['lng'];

    // await LocationServices().openGoogleMap(lat, lng);
    // List<PointLatLng> pointList = [
    //   PointLatLng(lat, lng),
    //   PointLatLng(point.latitude, point.longitude)
    // ];
    // _marker.add(Marker(
    //   markerId: MarkerId('Marker'),
    //   position: LatLng(point.latitude, point.longitude),
    // ));
    // setPolyLine(pointList);
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId('Marker'),
        position: LatLng(point.latitude, point.longitude),
      ));
    });
  }

  void setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;
    _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: _polygonLatLngs,
        strokeWidth: 5,
        strokeColor: Colors.blue,
        fillColor: Colors.transparent));
  }

  void setPolyLine(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polyLineIdCounter';
    _polyLineIdCounter++;
    _polyline.add(Polyline(
      polylineId: PolylineId(polylineIdVal),
      points: points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
      width: 5,
      color: Colors.blue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //         child: Column(
          //       children: [
          //         TextFormField(
          //           controller: source,
          //           textCapitalization: TextCapitalization.words,
          //           decoration: InputDecoration(hintText: 'Search source'),
          //           onChanged: (value) {
          //             print(value);
          //           },
          //         ),
          //         TextFormField(
          //           controller: destination,
          //           textCapitalization: TextCapitalization.words,
          //           decoration: InputDecoration(hintText: 'Search destination'),
          //           onChanged: (value) {
          //             print(value);
          //           },
          //         ),
          //       ],
          //     )),
          //     IconButton(
          //         onPressed: () async {
          //           var directions = await LocationServices()
          //               .getDirections(destination.text, source.text);

          //           // var place = await LocationServices().getPlace(source.text);

          //           _goToPlace(
          //             directions["start_location"]['lat'],
          //             directions['start_location']['lng'],
          //             directions['bounds_ne'],
          //             directions['bounds_sw'],
          //           );

          //           setPolyLine(directions['polyline_decode']);
          //         },
          //         icon: Icon(Icons.search))
          //   ],
          // ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              // markers: {
              // desMarker,
              // sourceMarker
              // },
              // polylines: {testPolyLine},
              // polygons: {testPolygon},
              markers: _marker,
              polygons: _polygons,
              polylines: _polyline,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // onTap: (point) {
              //   setState(() {
              //     _polygonLatLngs.add(point);
              //     setPolygon();
              //   });
              // },
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _goToTheLake(var point) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(point));
  // }

  Future<void> _goToPlace(double lat, double lng, Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        16));
    setMarker(LatLng(lat, lng));
  }

  Future<void> setPlaceOnInit(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    // controller.animateCamera(CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
    //         southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
    //         northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
    //     16));
    setMarker(LatLng(lat, lng));
  }

  getLocationStore() async {
    try {
      // nameOfRoute = "%${routeName.text}%";
      // setState(() {

      //   routeList.clear();
      // });

      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getLocationStore('CUST-18');
      if (result.cLATITUDE != '' && result.cLONGTITUDE != '') {
        // print(
        //     '----------- Location Store: ${result.cLATITUDE},${result.cLONGTITUDE} -----------');
        final GoogleMapController controller = await _controller.future;
        var lat = double.parse(result.cLATITUDE);
        var lng = double.parse(result.cLONGTITUDE);
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, lng), zoom: 12)));

        setMarker(LatLng(lat, lng));
      } else {
        wrongDialog('ไม่พบที่อยู่ร้าน');
      }
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
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
