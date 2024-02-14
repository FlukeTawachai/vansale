import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/unitSlider.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storeDetail = [
      {'list': UnitSlider(item: 32, unit: 32, unitName: 'ชิ้น 5 บาท')},
      {'list': UnitSlider(item: 16, unit: 64, unitName: 'กล่อง 12 บาท')},
      {'list': UnitSlider(item: 8, unit: 16, unitName: 'แพ็ค 20 บาท')}
    ];
    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Container(
              child: Center(child: storeDetail[index]['list']),
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
