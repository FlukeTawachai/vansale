import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_select_image.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';
import 'package:vansale/screens/home/home.dart';

class DesNavigator extends StatefulWidget {
  DesNavigator({Key key, this.openMap}) : super(key: key);
  final bool openMap;

  @override
  _DesNavigatorState createState() => _DesNavigatorState();
}

class _DesNavigatorState extends State<DesNavigator> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  final Set<Marker> markers = new Set();
  Circle circle;
  GoogleMapController _controller;
  bool discoverStores = true;
  LatLng start = LatLng(19.025392, 99.920011);
  LatLng destination = LatLng(19.030729, 99.924072);
  List<LatLng> polylineCoordinates = [];

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/focus02.png");
    return byteData.buffer.asUint8List();
  }

  void getPolyPoint() async {
    // You must enable Billing on the Google Cloud Project at https://console.cloud.google.com/project/_/billing/enable Learn more at https://developers.google.com/maps/gmp-get-started
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyD-bNWUzkY9Vjek2Z5uIjFS1fuhG8xUpUY",
        PointLatLng(19.025392, 99.920011),
        PointLatLng(19.030729, 99.924072));

    if (result.points.isEmpty) {
      result.points.forEach((element) =>
          polylineCoordinates.add(LatLng(element.latitude, element.longitude)));
    }

    // setState(() {});
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    setState(() {
      var current = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarker);
      var des = Marker(
          markerId: MarkerId("home"),
          position: destination,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarker);
      markers.clear();
      markers.add(current);
      markers.add(des);
      // marker = Marker(
      //     markerId: MarkerId("home"),
      //     position: latlng,
      //     rotation: newLocalData.heading,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      // updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          GlobalParam.currentLocationCheckIn =
              LatLng(newLocalData.latitude, newLocalData.longitude);
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 16.00)));
          // updateMarkerAndCircle(newLocalData, imageData);
        }
      });

      // getLocationStore();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    getPolyPoint();
  }

  openMaps() async {
    // Position position = await LocationServices().determinePosition();
    // var desPoint = await LocationServices().getPlace('โรงพยาบาลบางปะกอก 9');

    // final double lat = desPoint['geometry']['location']['lat'];
    // final double lng = desPoint['geometry']['location']['lng'];

    double lat = GlobalParam.deliveryLocationStoreLatitude;
    double lng = GlobalParam.deliveryLocationStoreLongitude;

    await LocationServices().openGoogleMap(lat, lng);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('แผนที่ร้านค้า'), centerTitle: true),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          markers: markers,
          circles: Set.of((circle != null) ? [circle] : []),
          polylines: {
            Polyline(
                polylineId: PolylineId('route'), points: polylineCoordinates)
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.fromLTRB(0, 0, 48, 16),
      //   child: FloatingActionButton(
      //       child: Icon(Icons.location_searching),
      //       onPressed: () {
      //         getCurrentLocation();
      //       }),
      // ),
    );
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
        discoverStores = true;
        print(
            '----------- Location Store: ${result.cLATITUDE},${result.cLONGTITUDE} -----------');
        GlobalParam.deliveryLocationStoreLatitude =
            double.parse(result.cLATITUDE);
        GlobalParam.deliveryLocationStoreLongitude =
            double.parse(result.cLONGTITUDE);
        if (widget.openMap == true) {
          openMaps();
        }
      } else {
        discoverStores = false;
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
