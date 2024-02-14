import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RefuelListDetail extends StatefulWidget {
  const RefuelListDetail({Key key}) : super(key: key);

  @override
  State<RefuelListDetail> createState() =>
      _RefuelListDetailState();
}

class _RefuelListDetailState extends State<RefuelListDetail> {
  final List<String> images = [
    "assets/images/shell.png",
    "assets/images/shell.png",
    "assets/images/shell.png",
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F2F3F4"),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ข้อมูลการเติมน้ำมัน',
        ),
      ),
      body: Container(
        child: Column(
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
      ),
      bottomNavigationBar: total_(),
    );
  }

  Widget carouselSlider_() {
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
          onPageChanged: (index, reason) => setState(() => activeIndex = index),
        ),
        itemBuilder: (context, index, realIndex) {
          final image = images[index];
          return buildImage(image, index);
        },
      ),
    );
  }

  Widget indicator_() {
    return Container(
        padding: const EdgeInsets.all(0),
        height: 25.0,
        child: buildIndicator());
  }

  Widget buildImage(String image, int index) => Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
            height: 250,
            width: 250,
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: ScrollingDotsEffect(
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
          Container(
            child: Icon(
              LineAwesomeIcons.map_marker,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: AutoSizeText(
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
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            child: Icon(
              LineAwesomeIcons.calendar,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
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
                '27 เมษายน 2563',
                style: TextStyle(
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
          Container(
            child: Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
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
                'บีพี หาดใหญ่',
                style: TextStyle(
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
          Container(
            child: Icon(
              LineAwesomeIcons.oil_can,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
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
                'ดีเซล',
                style: TextStyle(
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
          Container(
            child: Icon(
              LineAwesomeIcons.alternate_tachometer,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
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
                '258,385' + '-' + '258,633' + ' ' + '(400 กม.)',
                style: TextStyle(
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
      child: DottedLine(
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
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
                      '40.0 ลิตร',
                      style: TextStyle(
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
          ),
          //-------------
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
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
                      '20.0 ลิตร',
                      style: TextStyle(
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
          ),
          //---------------------
          Divider(
            color: Colors.black38,
            indent: 20.0,
            endIndent: 20.0,
          ),
          //---------------------
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
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
                      '800.00 บาท',
                      style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
