import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/list_all.dart/lst_basket.dart';
import 'package:intl/intl.dart';

class CustomerStoreList extends StatefulWidget {
  //const CustomerStoreList({ Key? key }) : super(key: key);

  @override
  _CustomerStoreListState createState() => _CustomerStoreListState();
}

class _CustomerStoreListState extends State<CustomerStoreList> {
  var storeDetail = [
    {
      'list': Container(
        //color: HexColor("#F2F3F4"),
        child: Container(
          child: Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              Container(
                width: 60.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/brandon.png',
                    ),
                    scale: 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    right: 5.0,
                    bottom: 5.0,
                    left: 10.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'ชื่อร้านค้า',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'ที่อยู่',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'หมายเลขโทรศัพท์',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            color: Colors.black54,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: const Icon(
                      LineAwesomeIcons.user_check,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'ประวัติ',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'เยี่ยมครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '12 ต.ค. 2563 13.10 น.',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.blue,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'สั่งครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '10 ต.ค. 2563 16.10 น.',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.blue,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'เลขบิลครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 60.0,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Q-3102',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.blue,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'ยอดสั่งซื้อ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 60.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('20000'))}',
                      style: const TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.blue,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: const Icon(
                      LineAwesomeIcons.donate,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'เครดิต',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'ยอดค้าง',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.red,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('12000'))}',
                      style: const TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.red,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.red,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'วงเงินเครดิต',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.grey,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('10000'))}',
                      style: const TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 5.0),
                    child: const Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'วงเงินคงเหลือ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('8100'))}',
                      style: const TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    },
    {
      'list': Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.topLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: const Icon(
                      LineAwesomeIcons.shopping_basket,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'ตระกร้า',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                child: ListBasket(),
              ),
            ),
          ],
        ),
      ),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: storeDetail[index]['list'],
            ),
          );
        },
        autoplay: false,
        itemCount: storeDetail.length,
        //pagination: new SwiperPagination(),
        control: new SwiperControl(
          color: Colors.black,
          size: 20.0,
        ),
        layout: SwiperLayout.DEFAULT,
        //viewportFraction: 0.8,
        //scale: 0.9,
      ),
    );
  }
}
