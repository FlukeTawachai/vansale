import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_select_image.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';
import 'package:vansale/screens/home/home.dart';

class LocationStore extends StatefulWidget {
  final bool openMap;
  final CustomerRequest request;
  LocationStore({Key key, this.openMap, this.request}) : super(key: key);
  @override
  _LocationStoreState createState() => _LocationStoreState();
}

class _LocationStoreState extends State<LocationStore> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  bool discoverStores = true;
  double lat;
  double lng;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/focus02.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
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

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
          lat = newLocalData.latitude;
          lng = newLocalData.longitude;
        }
      });

      // getLocationStore();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  bool openBtnSaveLocation = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        openBtnSaveLocation = true;
      });
    });
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
      appBar: AppBar(title: Text('ตำแหน่งร้าน'), centerTitle: true),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 48, 16),
        child: FloatingActionButton(
            child: Icon(Icons.location_searching),
            onPressed: () {
              getCurrentLocation();
            }),
      ),
      bottomNavigationBar: btnSaveLocation(),
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

  Widget btnSaveLocation() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: openBtnSaveLocation
          ? Container(
              child: InkWell(
                onTap: () {
                  widget.request.address.latitude = lat.toString();
                  widget.request.address.longtitude = lng.toString();
                  GlobalParam.deliveryImage = null;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DeliveryNewSupplierSelectImage(
                              GlobalParam.typeMenuCode,
                              request: widget.request,
                              subMenu: ''),
                    ),
                  );
                },
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: RotationTransition(
                              turns: new AlwaysStoppedAnimation(30 / 360),
                              child: Icon(
                                LineAwesomeIcons.location_arrow,
                                size: 25.0,
                                color: HexColor('#00cb39'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //alignment: Alignment.centerLeft,
                            child: Text(
                              'บันทึกตำแหน่ง',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: HexColor('#00cb39'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*SizedBox(
                child: Divider(
                  height: 5.0,
                  indent: 130.0,
                  endIndent: 120.0,
                  thickness: 2.0,
                  color: HexColor('#00cb39'),
                ),
              ),*/
                  ],
                )),
              ),
            )
          : Container(),
    );
  }
}
