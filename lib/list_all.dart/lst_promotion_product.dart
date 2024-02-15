import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ListPromotion extends StatefulWidget {
  //const ListPromotion({ Key? key }) : super(key: key);

  @override
  _ListPromotionState createState() => _ListPromotionState();
}

class _ListPromotionState extends State<ListPromotion> {
  var promotion = [
    {
      'image': "assets/images/Product3.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
    {
      'image': "assets/images/Product2.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
    {
      'image': "assets/images/Product1.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
    {
      'image': "assets/images/Product3.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
    {
      'image': "assets/images/Product2.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
    {
      'image': "assets/images/Product1.png",
      'name': "ขนมปังxxxxxxxxxxxxxxxxxxxxxx",
      'date': "ถึงวันที่ 10/9/64",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      itemCount: promotion.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  promotion[index]['image']!,
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              /*Container(
                child: Text(
                  recommend[index]['name'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Prompt',
                    fontSize: 12.0,
                  ),
                ),
              ),*/
              Container(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: SizedBox(
                  width: 100.0,
                  child: Text(
                    promotion[index]['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        LineAwesomeIcons.calendar_1,
                        size: 15.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        promotion[index]['date']!,
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 10.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
