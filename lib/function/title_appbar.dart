import 'package:flutter/material.dart';

class TitleName extends StatelessWidget {
  final String titleName;
  TitleName(this.titleName);

  @override
  Widget build(BuildContext context) {
    return Text(
      _titleName(titleName),
      style: TextStyle(
        fontFamily: 'Prompt',
        color: Colors.black54,
        fontSize: 16.0,
      ),
    );
  }

  _titleName(String titleName) {
    String titlePage = '';
    switch (titleName) {
      case '0':
        titlePage = 'หน้าหลัก';
        return titlePage;
        break;
      case '1':
        titlePage = '';
        return titlePage;
        break;
      case '2':
        titlePage = 'ส่งสินค้า (10/50)';
        return titlePage;
        break;
      case '3':
        titlePage = 'เพิ่มร้านค้า';
        return titlePage;
        break;
      case '4':
        titlePage = 'แผนที่';
        return titlePage;
        break;
      case '5':
        titlePage = 'เติมน้ำมัน';
        return titlePage;
        break;
      case '6':
        titlePage = 'บันทึกการเติมน้ำมัน';
        return titlePage;
        break;
      case '7':
        titlePage = 'ข้อมูลการเติมน้ำมัน';
        return titlePage;
        break;
      case '8':
        titlePage = 'เลือกจังหวัด';
        return titlePage;
        break;
      case '9':
        titlePage = 'เลือกแขวง/ตำบล';
        return titlePage;
        break;
      case '10':
        titlePage = 'เลือกเขต/อำเภอ';
        return titlePage;
        break;
      case '11':
        titlePage = 'ขายสินค้า';
        return titlePage;
        break;
      case '12':
        titlePage = 'รายการส่งสินค้า';
        return titlePage;
        break;
      case '13':
        titlePage = 'คืนตระกร้า';
        return titlePage;
        break;
      case '14':
        titlePage = 'คืนสินค้า';
        return titlePage;
        break;
    }
  }
}
