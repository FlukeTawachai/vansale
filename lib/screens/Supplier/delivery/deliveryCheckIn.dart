import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_newCheckIn.dart';

import 'package:vansale/screens/delivery/delivery_store/delivery_store_home.dart';
import 'package:vansale/screens/googleMap/locationServices.dart';


class DeliveryCheckIn extends StatefulWidget {
  final String cPOCD;
  final bool openMap;
  DeliveryCheckIn(this.cPOCD, this.openMap);
  //const StartWork({ Key? key }) : super(key: key);

  @override
  _DeliveryCheckInState createState() => _DeliveryCheckInState();
}

class _DeliveryCheckInState extends State<DeliveryCheckIn> {
  var dateFormat = DateFormat('dd/MM/yyyy hh:mm');
  // bool _edit = false;
  String Code = "";
  String Name = "";

  Location _locationTracker = Location();
  StreamSubscription? _locationSubscription;
  bool discoverStores = true;
  Marker? marker;
  Circle? circle;
  GoogleMapController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentLocation();
    getLocationStore();
    getStoreDetail();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'เช็คอินร้านค้า',
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
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 24.0, left: 12.0, right: 12, bottom: 24),
                alignment: Alignment.center,
                child: Container(
                  //width: 300.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AppbarPage(
                              4.toString(), GlobalParam.typeMenuCode!),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Container(
                      height: 40.0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          // color: Colors.black,
                          height: 40.0,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.map_marker,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    '${GlobalParam.deliverySelectStore.cADDRESS} ${GlobalParam.deliverySelectStore.cSUBDIST} ${GlobalParam.deliverySelectStore.cDISTRICT} ${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 128),
              // Container(
              //   padding: const EdgeInsets.only(left: 30.0),
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'บันทึกภาพถ่าย',
              //     style: TextStyle(
              //       fontSize: 14.0,
              //       color: Colors.grey,
              //       //fontWeight: FontWeight.bold,
              //       fontFamily: 'Prompt',
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              //     alignment: Alignment.topCenter,
              //     child: FDottedLine(
              //         color: Colors.grey[600],
              //         strokeWidth: 2.0,
              //         dottedLength: 10.0,
              //         space: 2.0,
              //         child: imageFile != null
              //             ? Container(
              //                 width: 500.0,
              //                 height: 300.0,
              //                 alignment: Alignment.center,
              //                 color: Colors.black,
              //                 child: InkWell(
              //                   onTap: () {
              //                     _openCamera();
              //                   },
              //                   child: Container(
              //                     width: 500,
              //                     height: 300,
              //                     child: Image.file(
              //                       File(_image.path),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //               )
              //             : Container(
              //                 width: 500.0,
              //                 height: 300.0,
              //                 color: Colors.black,
              //                 child: InkWell(
              //                   onTap: () {
              //                     _openCamera();
              //                   },
              //                   child: Icon(
              //                     LineAwesomeIcons.camera,
              //                     color: Colors.white,
              //                     size: 100.0,
              //                   ),
              //                 ),
              //               )),
              //   ),
              // ),
              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "*กรุณาถ่ายภาพ",
              //       style: TextStyle(
              //         fontSize: 14.0,
              //         color: Colors.white,
              //         //fontWeight: FontWeight.bold,
              //         fontFamily: 'Prompt',
              //       ),
              //     ),
              //   ),
              // )

              Expanded(child: NewCheckIn())
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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => DeliveryStoreHome(
                                    GlobalParam.typeMenuCode!, "A Store")),
                            (Route<dynamic> route) => false);
                        // if (GlobalParam.typeMenuCode == "T001") {
                        //   // checkInLocation();
                        //   Navigator.of(context).pushAndRemoveUntil(
                        //       MaterialPageRoute(
                        //           builder: (context) => DeliveryStoreHome(
                        //               GlobalParam.typeMenuCode, "A Store")),
                        //       (Route<dynamic> route) => false);
                        // } else {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (comtext) =>
                        //           ConfirmPages("T008", "เช็คอิน")));
                        //   Future.delayed(
                        //       Duration(seconds: delay.getTimeDelay()), () {
                        //     Navigator.of(context).pushAndRemoveUntil(
                        //         MaterialPageRoute(
                        //             builder: (context) => HomePage("T002")),
                        //         (Route<dynamic> route) => false);
                        //   });
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(
                        //   //     builder: (BuildContext context) => CheckInMiles(
                        //   //         headerTitle: 'ใส่เลขไมล์',
                        //   //         title: 'ใส่เลขไมล์',
                        //   //         cancel: () {
                        //   //           Navigator.of(context).pushAndRemoveUntil(
                        //   //               MaterialPageRoute(
                        //   //                   builder: (context) =>
                        //   //                       HomePage("T002")),
                        //   //               (Route<dynamic> route) => false);
                        //   //         },
                        //   //         submit: () {
                        //   //           Navigator.of(context).push(
                        //   //               MaterialPageRoute(
                        //   //                   builder: (comtext) => ConfirmPages(
                        //   //                       "T008", "เช็คอิน")));
                        //   //           Future.delayed(
                        //   //               Duration(seconds: delay.getTimeDelay()),
                        //   //               () {
                        //   //             Navigator.of(context).pushAndRemoveUntil(
                        //   //                 MaterialPageRoute(
                        //   //                     builder: (context) =>
                        //   //                         HomePage("T002")),
                        //   //                 (Route<dynamic> route) => false);
                        //   //           });
                        //   //         }),
                        //   //   ),
                        //   // );
                        // }
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
                              child: Icon(
                                LineAwesomeIcons.map_marker,
                                color: Colors.green,
                                size: 25.0,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
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

  PickedFile? imageFile;
  File? _image;
  Future<void> _openCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 1000.0, maxWidth: 1000.0);
    setState(() {
      imageFile = image;
      _image = File(imageFile!.path);
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

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
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

  getLocationStore() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result =
          await proxy.getLocationStore(GlobalParam.deliverySelectStore.cCUSTCD!);
      if (result.cLATITUDE != '' && result.cLONGTITUDE != '') {
        discoverStores = true;
        print(
            '----------- Location Store: ${result.cLATITUDE},${result.cLONGTITUDE} -----------');
        GlobalParam.deliveryLocationStoreLatitude =
            double.parse(result.cLATITUDE!);
        GlobalParam.deliveryLocationStoreLongitude =
            double.parse(result.cLONGTITUDE!);
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

  checkInLocation() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addAndUpdateCheckIn(AddCheckInReq(
        cREFDOC: widget.cPOCD,
        iCHELAT: GlobalParam.currentLocationCheckIn!.latitude,
        iCHELNG: GlobalParam.currentLocationCheckIn!.longitude,
        cCHINTYPE: "TF",
        cCREABY: GlobalParam.userID,
      ));
      if (result.success == false) {
        wrongDialog(result.message);
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
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
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
