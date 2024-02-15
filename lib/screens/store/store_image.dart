import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class StoreImgList extends StatefulWidget {
  //const StoreImgList({ Key? key }) : super(key: key);

  @override
  _StoreImgListState createState() => _StoreImgListState();
}

class _StoreImgListState extends State<StoreImgList> {
  var storeImg = [
    StoreImgListModel("assets/images/pt.png"),
    StoreImgListModel("assets/images/ptt.png"),
    StoreImgListModel("assets/images/shell.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            storeImg[index].image!,
            fit: BoxFit.cover,
          ),
        );
      },
      autoplay: false,
      itemCount: storeImg.length,
      pagination: new SwiperPagination(),
      //control: new SwiperControl(),
      layout: SwiperLayout.DEFAULT,
      viewportFraction: 0.8,
      scale: 0.9,
    );
  }
}

class StoreImgListModel{
  String? image;
  StoreImgListModel(this.image);
}
