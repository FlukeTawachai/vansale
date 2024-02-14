import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowMap extends StatefulWidget {
  //final int menu_id;
  //ShowMap(this.menu_id);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 80.0,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Prompt',
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "ค้นหาตำแหน่ง",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: HexColor('#6c7e9b'),
                              ),
                              onPressed: () {},
                              iconSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 50.0,
                    margin: const EdgeInsets.only(
                        top: 5.0, right: 5.0, bottom: 5.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        width: 50.0,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(150),
                          border: new Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(LineAwesomeIcons.crosshairs),
                            iconSize: 20.0,
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Map'),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 80.0,
        color: Colors.white,
        child: Container(
          child: InkWell(
            onTap: () {
              /*widget.menu_id == 5
                  ? Navigator.of(context).pop()
                  : Navigator.of(context).pop();*/
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 35.0,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: 1 / 2,
                      child: Icon(
                        LineAwesomeIcons.location_arrow,
                        color: Colors.green,
                        size: 25.0,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'บันทึกตำแหน่ง',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
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
    );
  }
}
