import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Utility {
  //Formate Number xx,xxx.00
  static String formatNumber(double _number) {
    String result;
    final formatNum = NumberFormat("#,###.##", "en_US");
    result = formatNum.format(_number);
    return result;
  }

//Format DateTime 01/01/65
  static String formatDatetimeYesterday(DateTime _datetime) {
    String result;
    var formatterDay = DateFormat('dd');
    var formatterMonth = DateFormat('MM');
    result = formatterDay.format(_datetime.add(Duration(days: -1))) +
        "/" +
        formatterMonth.format(_datetime.add(Duration(days: -1))) +
        "/" +
        (_datetime.year + 43).toString().substring(2);
    return result;
  }

  //Format DateTime 01/01/65
  static String formatDatetimeToday(DateTime _datetime) {
    String result;
    var formatterDay = DateFormat('dd');
    var formatterMonth = DateFormat('MM');
    result = formatterDay.format(_datetime) +
        "/" +
        formatterMonth.format(_datetime) +
        "/" +
        (_datetime.year + 43).toString().substring(2);
    return result;
  }

  //Format DateTime 01/01/65
  static String formatDatetimeTomorrow(DateTime _datetime) {
    String result;
    var formatterDay = DateFormat('dd');
    var formatterMonth = DateFormat('MM');
    result = formatterDay.format(DateTime.now().add(Duration(days: 1))) +
        "/" +
        formatterMonth.format(DateTime.now().add(Duration(days: 1))) +
        "/" +
        (DateTime.now().year + 43).toString().substring(2);
    return result;
  }

//Formate Number xx,xxx.00 Orange Color Symbol ฿
  static Widget formateNumberOrenge(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0": '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

//Formate Number xx,xxx.00 Orange Color Symbol ฿
  static Widget formateNumberOrangeSym(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              '฿',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

//Formate Number xx,xxx.00 Orange Color บาท
  static Widget formateNumberOrangeTxtBaht(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              'บาท',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

//Formate Number xx,xxx.00 Black Color Symbol ฿
  static Widget formateNumberBKSym(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              '฿',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

//Formate Number xx,xxx.00 black Color บาท
  static Widget formateNumberBKTxtBaht(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              'บาท',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  //Formate Number xx,xxx.00 black Color
  static Widget formateNumberBK(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  //Formate Number xx,xxx.00 green Color
  static Widget formateNumberGN18(double _number, double fontsize) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: fontsize,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  //Formate Number xx,xxx.00 orange Color
  static Widget formateNumberOR18(double _number, double fontsize) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: fontsize,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
        ],
      ),
    );
    return result;
  }

  //Formate Number xx,xxx.00 Green Color Symbol ฿
  static Widget formateNumberGNSym(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              '฿',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

//Formate Number xx,xxx.00 green Color บาท
  static Widget formateNumberGNTxtBaht(double _number) {
    String number = _number.toStringAsFixed(2);
    final formatNum = NumberFormat("#,###.##", "en_US");
    String beforedot = '';
    String afterdot = '';
    var result;
    var subS = number.toString().split('.');
    beforedot = subS[0].toString();
    afterdot = subS[1].toString();
    result = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? "0" : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? "00" : afterdot,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          Container(
            child: Text(
              'บาท',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  //warnning dialog
  static warnningDialog(BuildContext context, String txtmessage) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Container(
          alignment: Alignment.center,
          height: 100.0,
          child: Text(
            txtmessage,
            style: TextStyle(
                color: HexColor("#2e2e2e"),
                fontFamily: 'Prompt',
                fontSize: 16.0),
          ),
        ),
        actions: [
          // Close the dialog
          CupertinoButton(
            child: Text(
              'ตกลง',
              style: TextStyle(
                  color: HexColor("#00cb39"),
                  fontFamily: 'Prompt',
                  fontSize: 16.0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  static confirmDialog(BuildContext context, String txtmessage) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Container(
          alignment: Alignment.center,
          height: 100.0,
          child: Text(
            txtmessage,
            style: TextStyle(
                color: HexColor("#2e2e2e"),
                fontFamily: 'Prompt',
                fontSize: 16.0),
          ),
        ),
        actions: [
          CupertinoButton(
              child: Text(
                'ยกเลิก',
                style: TextStyle(
                    color: HexColor("#2e2e2e"),
                    fontFamily: 'Prompt',
                    fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          CupertinoButton(
            child: Text(
              'ยืนยัน',
              style: TextStyle(
                  color: HexColor("#00cb39"),
                  fontFamily: 'Prompt',
                  fontSize: 16.0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // Semi-axes of WGS-84 geoidal reference
  static const double WGS84_a = 6378137.0; // Major semiaxis [m]
  static const double WGS84_b = 6356752.3; // Minor semiaxis [m]

  static double getDistanceFromLatLng(
      double lat1, double lng1, double lat2, double lng2) {
    double lat = (lat1 + lat2) / 2 * 0.01745;
    double dx = 111.3 * cos(lat) * (lng1 - lng2);
    double dy = 111.3 * (lat1 - lat2);

    return sqrt(dx * dx + dy * dy);
  }

  static LatLngBound boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    if (list.length > 1) {
      LatLng pos1 = list[0];
      double maxDistance = 0;
      for (int i = 1; i < list.length; i++) {
        LatLng pos2 = list[i];
        double distance =
            getDistanceFromLatLng(pos1.lat!, pos1.lon!, pos2.lat!, pos2.lon!);
        if (maxDistance == 0 || distance > maxDistance) {
          maxDistance = distance;
        }
      }

      double halfSizeInKm = (maxDistance * 0.2) / 2;
      for (LatLng latLng in list) {
        var posBound = getBoundingBox(latLng, halfSizeInKm);

        if (x0 == null) {
          x0 = x1 = posBound.minLat;
          y0 = y1 = posBound.minLon;
        } else {
          if (posBound.maxLat! > x1!) x1 = posBound.maxLat;
          if (posBound.minLat! < x0) x0 = posBound.minLat;
          if (posBound.maxLon! > y1!) y1 = posBound.maxLon;
          if (posBound.minLon! < y0!) y0 = posBound.minLon;
        }
      }
    } else {
      var posBound = getBoundingBox(list[0], 2);
      x0 = posBound.minLat;
      x1 = posBound.maxLat;
      y0 = posBound.minLon;
      y1 = posBound.maxLon;
    }
    return LatLngBound(maxLat: x1, minLat: x0, maxLon: y1, minLon: y0);
  }

  // 'halfSideInKm' is the half length of the bounding box you want in kilometers.
  static LatLngBound getBoundingBox(LatLng point, double halfSideInKm) {
    // Bounding box surrounding the point at given coordinates,
    // assuming local approximation of Earth surface as a sphere
    // of radius given by WGS84
    var lat = deg2rad(point.lat!);
    var lon = deg2rad(point.lon!);
    var halfSide = 1000 * halfSideInKm;

    // Radius of Earth at given latitude
    var radius = WGS84EarthRadius(lat);
    // Radius of the parallel at given latitude
    var pradius = radius * cos(lat);

    var latMin = lat - halfSide / radius;
    var latMax = lat + halfSide / radius;
    var lonMin = lon - halfSide / pradius;
    var lonMax = lon + halfSide / pradius;

    return LatLngBound(
        minLat: rad2deg(latMin),
        minLon: rad2deg(lonMin),
        maxLat: rad2deg(latMax),
        maxLon: rad2deg(lonMax));
  }

  // degrees to radians
  static double deg2rad(double degrees) {
    return pi * degrees / 180.0;
  }

  // radians to degrees
  static double rad2deg(double radians) {
    return 180.0 * radians / pi;
  }

  // Earth radius at a given latitude, according to the WGS-84 ellipsoid [m]
  static double WGS84EarthRadius(double lat) {
    // http://en.wikipedia.org/wiki/Earth_radius
    var An = WGS84_a * WGS84_a * cos(lat);
    var Bn = WGS84_b * WGS84_b * sin(lat);
    var Ad = WGS84_a * cos(lat);
    var Bd = WGS84_b * sin(lat);
    return sqrt((An * An + Bn * Bn) / (Ad * Ad + Bd * Bd));
  }
}

class LatLngBound {
  double? minLon = 0;
  double? maxLon = 0;
  double? minLat = 0;
  double? maxLat = 0;

  LatLngBound({this.maxLat, this.minLat, this.maxLon, this.minLon});

  Map<String, dynamic> toJson() =>
      {"minLon": minLon, "minLat": minLat, "maxLon": maxLon, "maxLat": maxLat};
}

class LatLng {
  double? lat = 0;
  double? lon = 0;

  LatLng({this.lat, this.lon});
}
