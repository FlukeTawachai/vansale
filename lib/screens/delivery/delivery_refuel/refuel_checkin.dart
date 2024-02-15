import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addCheckInReq.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/screens/delivery/delivery_refuel/refuel_image.dart';
import 'package:vansale/screens/delivery/delivery_refuel/refuel_map_checkin.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';

class RefuelCheckIn extends StatefulWidget {
  RefuelCheckIn();
  //const StartWork({ Key? key }) : super(key: key);

  @override
  _RefuelCheckInState createState() => _RefuelCheckInState();
}

class _RefuelCheckInState extends State<RefuelCheckIn> {
  var dateFormat = DateFormat('dd/MM/yyyy hh:mm');
  // bool _edit = false;
  String Code = "";
  String Name = "";

  Location _locationTracker = Location();
  late StreamSubscription _locationSubscription;
  bool discoverStores = true;
  late Marker marker;
  late Circle circle;
  late GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentLocation();
    // getLocationStore();
    // getStoreDetail();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'เช็คอินเติมน้ำมัน',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          centerTitle: true,
        ),
        // backgroundColor: Colors.black87,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   padding: const EdgeInsets.only(top: 50.0),
              //   alignment: Alignment.center,
              //   child: Text(
              //     'เช็คอินร้านค้า',
              //     style: TextStyle(
              //       fontSize: 18.0,
              //       color: Colors.white,
              //       //fontWeight: FontWeight.bold,
              //       fontFamily: 'Prompt',
              //     ),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.center,
                child: Text(
                  dateFormat.format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),

              Expanded(
                  child: RefuelMapCheckIn(
                openMap: null,
              ))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          height: 80.0,
          color: Colors.white,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        checkInLocation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RefuelImage(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 35.0,
                              alignment: Alignment.center,
                              child: const Icon(
                                LineAwesomeIcons.map_marker,
                                color: Colors.green,
                                size: 25.0,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'เช็คอิน',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late PickedFile imageFile;
  late File _image;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1000.0, maxWidth: 1000.0);
    setState(() {
      imageFile = image!;
      _image = File(imageFile.path);
    });
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/focus02.png");
    return byteData.buffer.asUint8List();
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      _locationSubscription.cancel();

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
            tilt: 0,
            zoom: 18.00)));
        updateMarkerAndCircle(newLocalData, imageData);
      });

      // await getLocationStore();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  openMaps() async {
    // Position position = await LocationServices().determinePosition();
    // var desPoint = await LocationServices().getPlace('โรงพยาบาลบางปะกอก 9');

    // final double lat = desPoint['geometry']['location']['lat'];
    // final double lng = desPoint['geometry']['location']['lng'];

    double lat = GlobalParam.deliveryLocationStoreLatitude!;
    double lng = GlobalParam.deliveryLocationStoreLongitude!;

    await LocationServices().openGoogleMap(lat, lng);
  }

  checkInLocation() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addAndUpdateCheckIn(AddCheckInReq(
        cREFDOC: '',
        iCHELAT: GlobalParam.currentLocationCheckIn!.latitude,
        iCHELNG: GlobalParam.currentLocationCheckIn!.longitude,
        cCHINTYPE: "RF",
        cCREABY: GlobalParam.userID,
      ));
      if (result.success == false) {
        wrongDialog(result.message);
      } else {
        GlobalParam.refuelRff = result.result;
      }
      // setState(() {});
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

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    setState(() {
      marker = Marker(
          markerId: const MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: const CircleId("car"),
          radius: newLocalData.accuracy!,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  getStoreDetail() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getStoreDetail(
          GetStoreDetailReq(cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD));
      if (result.cCUSTCD != '') {
        GlobalParam.deliveryStoreDetail = result;
        getHisBasket();
        // print(result.iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getHisBasket() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getHisBasket(
          GetStoreDetailReq(cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD));
      if (result.isNotEmpty) {
        GlobalParam.deliveryHisBasket = result;
        GlobalParam.deliveryDebt =
            double.parse(GlobalParam.deliveryStoreDetail.iTOTAL!) -
                double.parse(GlobalParam.deliveryStoreDetail.iPAID!);
        GlobalParam.deliveryRemainCredit =
            double.parse(GlobalParam.deliveryStoreDetail.iCREDLIM!) -
                double.parse(GlobalParam.deliveryStoreDetail.iCREDTERM!);
        // print(result[0].iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }
}
