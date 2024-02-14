import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubstringPrice extends StatefulWidget {
  final price,
      sizeb,
      sizeaf,
      colorb,
      coloraf,
      fontb,
      fontaf,
      weightb,
      weightaf,
      currencysymbols,
      cssize,
      cscolor,
      csfont,
      csweight,
      fontstyleb,
      fontstyleaf,
      csfontstyle;
  SubstringPrice(
    this.price,
    this.sizeb,
    this.sizeaf,
    this.colorb,
    this.coloraf,
    this.fontb,
    this.fontaf,
    this.weightb,
    this.weightaf,
    this.currencysymbols,
    this.cssize,
    this.cscolor,
    this.csfont,
    this.csweight,
    this.fontstyleb,
    this.fontstyleaf,
    this.csfontstyle,
  );

  @override
  _SubstringPriceState createState() => _SubstringPriceState();
}

class _SubstringPriceState extends State<SubstringPrice> {
  final formatNum = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    var subTotal = widget.price.split('.');
    var colorb = widget.colorb;
    var coloraf = widget.coloraf;
    var sizeb = widget.sizeb;
    var sizeaf = widget.sizeaf;
    var fontb = widget.fontb;
    var fontaf = widget.fontaf;
    var weightb = widget.weightb;
    var weightaf = widget.weightaf;
    var cssymbols = widget.currencysymbols;
    var cssize = widget.cssize;
    var cscolor = widget.cscolor;
    var csfont = widget.csfont;
    var csweight = widget.csweight;
    var fontstyleb = widget.fontstyleb;
    var fontstyleaf = widget.fontstyleaf;
    var csfontstyle = widget.csfontstyle;
    var beforedot = '';
    var afterdot = '0';
    beforedot = subTotal[0].toString();
    if (subTotal.length > 1) {
      afterdot = subTotal[1].toString();
    }

    /* List<SubstringPrice> getAddressList() {
      Map myMap = {
        subTotal: subTotal,
      };
    }*/

    var _complete = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              beforedot == '' ? 0 : '${formatNum.format(int.parse(beforedot))}',
              style: TextStyle(
                fontSize: sizeb == '' ? 16.0 : sizeb,
                color: colorb == '' ? Colors.black : colorb,
                fontFamily: fontb == '' ? 'Prompt' : fontb,
                fontWeight: weightb == '' ? FontWeight.normal : weightb,
                fontStyle: fontstyleb == '' ? FontStyle.normal : fontstyleb,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: sizeaf == '' ? 14.0 : sizeaf,
                color: coloraf == '' ? Colors.black : coloraf,
                fontFamily: fontaf == '' ? 'Prompt' : fontaf,
                fontWeight: weightaf == '' ? FontWeight.normal : weightaf,
                fontStyle: fontstyleaf == '' ? FontStyle.normal : fontstyleaf,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              afterdot == '' ? 0 : afterdot,
              style: TextStyle(
                fontSize: sizeaf == '' ? 14.0 : sizeaf,
                color: coloraf == '' ? Colors.black : coloraf,
                fontFamily: fontaf == '' ? 'Prompt' : fontaf,
                fontWeight: weightaf == '' ? FontWeight.normal : weightaf,
                fontStyle: fontstyleaf == '' ? FontStyle.normal : fontstyleaf,
              ),
            ),
          ),
          Container(
            child: Text(' '),
          ),
          cssymbols != ''
              ? Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    cssymbols,
                    style: TextStyle(
                      fontSize: cssize == '' ? 14.0 : cssize,
                      color: cscolor == '' ? Colors.black : cscolor,
                      fontFamily: csfont == '' ? 'Prompt' : csfont,
                      fontWeight: csweight == '' ? FontWeight.normal : csweight,
                      fontStyle:
                          csfontstyle == '' ? FontStyle.normal : csfontstyle,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
    return _complete;
  }
}
