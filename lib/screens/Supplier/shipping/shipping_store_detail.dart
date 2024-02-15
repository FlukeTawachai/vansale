
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:vansale/screens/Supplier/shipping/shippingBasketStore.dart';
import 'package:vansale/screens/Supplier/shipping/shippingCreditStore.dart';
import 'package:vansale/screens/Supplier/shipping/shippingDetailStore.dart';
import 'package:vansale/screens/Supplier/shipping/shippingHistoryStore.dart';

class SupShippingStoreDetail extends StatefulWidget {
  @override
  _SupShippingStoreDetailState createState() => _SupShippingStoreDetailState();
}

class _SupShippingStoreDetailState extends State<SupShippingStoreDetail> {
  var storeDetail = [
    {
      'list': StoreDetail()
    },
    {
      'list': StoreHistory()
    },
    {
      'list': StoreCredit()
    },
    {
      'list': StoreBasket()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          child: Container(
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
    );
  }
}
