import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/request/mobile/getRefuelReq.dart';
import 'package:vansale/api/class/response/routeMobile/getRefuel.dart';
import 'package:vansale/api/class/response/routeMobile/searchRefuelResp.dart';

class DeliveryRefuelListDetail extends StatefulWidget {
  final SearchRefuelResp data;
  const DeliveryRefuelListDetail({required Key? key, required this.data})
      : super(key: key);

  @override
  State<DeliveryRefuelListDetail> createState() =>
      _DeliveryRefuelListDetailState();
}

class _DeliveryRefuelListDetailState extends State<DeliveryRefuelListDetail> {
  List<String> images = [];
  int activeIndex = 0;
  var outputFormat = DateFormat('dd-MM-yyyy');
  final formatNum = NumberFormat("#,###.##", "en_US");
  GetRefuelResp dataRefuel = GetRefuelResp(
    cGUID: "",
    cBRANCD: "",
    dINVENTDT: "",
    cVEHICD: "",
    cVEHINM: "",
    cPLATE: "",
    cPROVINCE: "",
    cLOCATION: "",
    cFUELNM: "",
    iMILEAGE: "0",
    iKM: "0",
    iFUELRATE: "0",
    iLITER: "0",
    iPRICE: "0",
    iTOTAL: "0",
    cCREABY: "",
    cUPDABY: "",
    dCREADT: "",
    dUPDADT: "",
    cREFDOC: "",
    aRFIMAGE: [],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRefuel(GetRefuelReq(cGUID: widget.data.cGUID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F2F3F4"),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ข้อมูลการเติมน้ำมัน',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          carouselSlider_(),
          indicator_(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(3.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  location_(),
                  dotline_(),
                  date_(),
                  dotline_(),
                  locationName_(),
                  dotline_(),
                  refuel_(),
                  dotline_(),
                  mile_(),
                  dotline_(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: total_(),
    );
  }

  Widget carouselSlider_() {
    if (images.isNotEmpty) {
      return Container(
        child: CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            height: 250.0,
            viewportFraction: 0.65,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final image = images[index];
            return buildImage(image, index);
          },
        ),
      );
    } else {
      return Container(
        height: 250,
        width: 250,
        padding: const EdgeInsets.only(top: 10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/no_image.png",
              ),
              scale: 1.0,
              fit: BoxFit.cover,
            )),
      );
    }
  }

  Widget indicator_() {
    return Container(
        padding: const EdgeInsets.all(0),
        height: 25.0,
        child: buildIndicator());
  }

  Widget buildImage(String image, int index) => Container(
        height: 250,
        width: 250,
        padding: const EdgeInsets.only(top: 10.0),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(15.0),
        //   child: Image.asset(
        //     images[index],
        //     fit: BoxFit.cover,
        //     height: 250,
        //     width: 250,
        //   ),

        // ),
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(
                images[index],
              ),
              scale: 1.0,
              fit: BoxFit.cover,
            )),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: const ScrollingDotsEffect(
          activeDotColor: Colors.green,
          dotColor: Colors.grey,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  Widget location_() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            LineAwesomeIcons.map_marker,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: const AutoSizeText(
                'Bangkok',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                minFontSize: 10.0,
                maxFontSize: 16.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget date_() {
    var outputDate = '';
    if (dataRefuel.dINVENTDT != "") {
      outputDate = outputFormat.format(DateTime.parse(dataRefuel.dINVENTDT!));
    }

    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            LineAwesomeIcons.calendar,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const SizedBox(
            width: 100.0,
            child: AutoSizeText(
              'วันที่',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AutoSizeText(
                outputDate,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                minFontSize: 10.0,
                maxFontSize: 16.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget locationName_() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            LineAwesomeIcons.gas_pump,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const SizedBox(
            width: 100.0,
            child: AutoSizeText(
              'สถานที่เติม',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AutoSizeText(
                dataRefuel.cLOCATION!,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                minFontSize: 10.0,
                maxFontSize: 16.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget refuel_() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            LineAwesomeIcons.oil_can,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const SizedBox(
            width: 100.0,
            child: AutoSizeText(
              'เชื้อเพลิง',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AutoSizeText(
                dataRefuel.cFUELNM!,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                minFontSize: 10.0,
                maxFontSize: 16.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mile_() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            LineAwesomeIcons.alternate_tachometer,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const SizedBox(
            width: 100.0,
            child: AutoSizeText(
              'เลขไมล์',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AutoSizeText(
                '${dataRefuel.iMILEAGE!}-${double.parse(dataRefuel.iMILEAGE!) - double.parse(dataRefuel.iKM!)} (${formatNum.format(double.parse(dataRefuel.iKM!))} กม.)',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                minFontSize: 10.0,
                maxFontSize: 16.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dotline_() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 3.0,
      ),
      child: const DottedLine(
        dashColor: Colors.grey,
      ),
    );
  }

  Widget total_() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 110.0,
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const AutoSizeText(
                    'จำนวนลิตร',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 16.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    '${formatNum.format(double.parse(dataRefuel.iLITER!))} ลิตร',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 16.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          //-------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const AutoSizeText(
                    'ราคาต่อลิตร',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 16.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    '${formatNum.format(double.parse(dataRefuel.iPRICE!))}  บาท',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 16.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          //---------------------
          const Divider(
            color: Colors.black38,
            indent: 20.0,
            endIndent: 20.0,
          ),
          //---------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const AutoSizeText(
                    'ราคารวม',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 18.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    '${formatNum.format(double.parse(dataRefuel.iTOTAL!))} บาท',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 10.0,
                    maxFontSize: 18.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getRefuel(GetRefuelReq req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getRefuel(req);
      if (result.cGUID != null) {
        setState(() {
          images = [];
          dataRefuel = result;
          if (result.aRFIMAGE!.isNotEmpty) {
            for (var i = 0; i < result.aRFIMAGE!.length; i++) {
              var path =
                  'http://${result.aRFIMAGE![i].cPHOTOSERV}/${result.aRFIMAGE![i].cPHOTOPATH}';
              images.add(path);
            }
          } else {
            images = [];
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
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
