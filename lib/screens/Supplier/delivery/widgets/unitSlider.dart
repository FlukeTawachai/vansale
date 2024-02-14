import 'package:flutter/material.dart';

class UnitSlider extends StatelessWidget {
  final int item;
  final int unit;
  final String unitName;
  const UnitSlider({
    Key key,
    this.item,
    this.unit,
    this.unitName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( left: 25.0, right: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                '$item รายการ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                '$unit $unitName',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
