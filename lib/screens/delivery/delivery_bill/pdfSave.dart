import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/Widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vansale/api/class/globalparam.dart';

Future<void> genenratePdf() async {
  final pdf = pw.Document();
  final fontTHNA = await rootBundle.load("assets/fonts/TH_Niramit_AS.ttf");
  final TH_NA = pw.Font.ttf(fontTHNA);
  final fontTHNAB =
      await rootBundle.load("assets/fonts/TH_Niramit_AS_Bold.ttf");
  final TH_NA_B = pw.Font.ttf(fontTHNAB);
  final formatNum = new NumberFormat("#,###.##", "en_US");

  pdf.addPage(pw.MultiPage(
      margin: pw.EdgeInsets.all(56),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        pw.Widget header() {
          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Text('นายกัณฐ์ เทรดดิ้ง(ศรีสุดา)',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: TH_NA)),
            pw.Text('ใบเสร็จรับเงิน/ใบส่งสินค้า',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: TH_NA))
          ])));
        }

        pw.Widget locationStore() {
          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Row(children: [
              pw.Text(GlobalParam.deliverySelectStore.cCUSTNM ?? '',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
            pw.Row(children: [
              pw.Text(GlobalParam.deliverySelectStore.cADDRESS ?? '',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
            pw.Row(children: [
              pw.Text(GlobalParam.deliverySelectStore.cSUBDIST ?? '',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
            pw.Row(children: [
              pw.Text(GlobalParam.deliverySelectStore.cDISTRICT ?? '',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
            pw.Row(children: [
              pw.Text(
                  '${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
          ])));
        }

        pw.Widget lineBreak() {
          return pw.Container(
              child: pw.Center(
            child: pw.Text(
                '__________________________________________________________________________',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: TH_NA)),
          ));
        }

        pw.Widget footer(var data) {
          List unitName = [];
          double totalItem = 0;
          var listItem = [];
          for (int i = 0; i < data.length; i++) {
            unitName.add(data[i]['cUOMNM']);
          }

          var unitList = unitName.toSet().toList();

          for (int i = 0; i < unitList.length; i++) {
            int num = 0;
            double numItem = 0;

            for (int j = 0; j < data.length; j++) {
              if (unitList[i] == data[j]['cUOMNM']) {
                double total = double.parse(data[j]['iTOTAL']);
                double prince = double.parse(data[j]['iPRICE']);
                num++;
                numItem += total / prince;
              }
            }
            totalItem += numItem;
            var text = {
              "unitName": unitList[i],
              "qty": num,
              "sumItem": numItem.toStringAsFixed(0)
            };
            listItem.add(text);
          }

          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Row(children: [
              pw.Text('รวมทั้งหมด',
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text(
                  formatNum.format(
                      double.parse(GlobalParam.deliveryStoreSum.iTOTAL ?? '0')),
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA))
            ]),
            pw.Row(children: [
              pw.Text(
                'รวม ${GlobalParam.deliveryStoreSum.iitems} รายการ',
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold, font: TH_NA),
                textAlign: pw.TextAlign.left,
              ),
              pw.Spacer(),
              pw.Text(
                'จำนวน  ${totalItem.toStringAsFixed(0)} ชิ้น',
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold, font: TH_NA),
                textAlign: pw.TextAlign.right,
              )
            ]),
            pw.Row(children: [
              pw.Text('ได้ตรวจรับสิ่งของและชำระเงินถูกต้องเรียบร้อยแล้ว',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
            ]),
            pw.Row(children: [
              pw.Text(
                'ผู้ส่งของ/รับเงิน',
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold, font: TH_NA),
                textAlign: pw.TextAlign.left,
              ),
              pw.Spacer(),
            ]),
            pw.SizedBox(height: 16),
            pw.Text(
                'ลงชื่อ____________________________________________________________',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold, font: TH_NA)),
          ])));
        }

        pw.Widget productHeader() {
          return pw.Container(
              child: pw.Center(
            child: pw.Row(children: [
              pw.Text('รายละเอียด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text('ยอดเงิน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ]),
          ));
        }

        pw.Widget? productList() {
          for (int index = 0;
              index < GlobalParam.deliveryBasketReq.length;
              index++) {
            String unitNM = '';
            double qty = 0, prince = 0;
            // ignore: unrelated_type_equality_checks
            if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
              qty = double.parse(
                  GlobalParam.deliveryPodtList[index].iSSIZEQTY ?? '0');
              prince = double.parse(
                  GlobalParam.deliveryPodtList[index].iSUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
              qty = double.parse(
                  GlobalParam.deliveryPodtList[index].iMSIZEQTY ?? '0');
              prince = double.parse(
                  GlobalParam.deliveryPodtList[index].iMUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
              qty = double.parse(
                  GlobalParam.deliveryPodtList[index].iLSIZEQTY ?? '0');
              prince = double.parse(
                  GlobalParam.deliveryPodtList[index].iLUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM ?? '';
            }
            return pw.Center(
                child: pw.Container(
                    child: pw.Column(children: [
              pw.Row(children: [
                pw.Text(GlobalParam.deliveryPodtList[index].cPRODNM ?? '',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
                pw.Spacer(),
              ]),
              pw.Row(children: [
                pw.Container(
                  width: 196,
                  child: pw.Text(unitNM,
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          font: TH_NA)),
                ),
                pw.Container(
                    width: 116,
                    child: pw.Text(qty.toStringAsFixed(0),
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            font: TH_NA))),
                pw.Container(
                    width: 172,
                    child: pw.Text(prince.toStringAsFixed(2),
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            font: TH_NA))),
              ]),
            ])));
          }
        }

        pw.Widget incompHeader() {
          return pw.Container(
              child: pw.Center(
            child: pw.Row(children: [
              pw.Text('สินค้าขาด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text('ยอดเงิน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ]),
          ));
        }

        pw.Widget? incompList() {
          for (int index = 0;
              index < GlobalParam.deliveryBasketReq.length;
              index++) {
            String unitNM = '';
            int qty = GlobalParam.deliveryPodtList[index].iINCOMPRO ?? 0;
            double prince = 0;
            // ignore: unrelated_type_equality_checks
            if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iSUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iMUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iLUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM ?? '';
            }
            return pw.Center(
                child: GlobalParam.deliveryPodtList[index].iINCOMPRO != 0
                    ? pw.Container(
                        child: pw.Column(children: [
                        pw.Row(children: [
                          pw.Text(
                              GlobalParam.deliveryPodtList[index].cPRODNM ?? '',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                  font: TH_NA)),
                          pw.Spacer(),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 196,
                            child: pw.Text(unitNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                          ),
                          pw.Container(
                              width: 116,
                              child: pw.Text(qty.toStringAsFixed(0),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                          pw.Container(
                              width: 172,
                              child: pw.Text(prince.toStringAsFixed(2),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                        ]),
                      ]))
                    : pw.Container());
          }
        }

        pw.Widget cancelHeader() {
          return pw.Container(
              child: pw.Center(
            child: pw.Row(children: [
              pw.Text('ไม่รับ/คืน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text('ยอดเงิน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ]),
          ));
        }

        pw.Widget? cancelList() {
          for (int index = 0;
              index < GlobalParam.deliveryBasketReq.length;
              index++) {
            String unitNM = '';
            int qty = GlobalParam.deliveryPodtList[index].iCANCLEPRO ?? 0;
            double prince = 0;
            // ignore: unrelated_type_equality_checks
            if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iSUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iMUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iLUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM ?? '';
            }
            return pw.Center(
                child: GlobalParam.deliveryPodtList[index].iCANCLEPRO != 0
                    ? pw.Container(
                        child: pw.Column(children: [
                        pw.Row(children: [
                          pw.Text(
                              GlobalParam.deliveryPodtList[index].cPRODNM ?? '',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                  font: TH_NA)),
                          pw.Spacer(),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 196,
                            child: pw.Text(unitNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                          ),
                          pw.Container(
                              width: 116,
                              child: pw.Text(qty.toStringAsFixed(0),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                          pw.Container(
                              width: 172,
                              child: pw.Text(prince.toStringAsFixed(2),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                        ]),
                      ]))
                    : pw.Container());
          }
        }

        pw.Widget lossHeader() {
          return pw.Container(
              child: pw.Center(
            child: pw.Row(children: [
              pw.Text('สินค้าขาด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text('ยอดเงิน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ]),
          ));
        }

        pw.Widget lossList() {
          for (int index = 0;
              index < GlobalParam.deliveryPodtList.length;
              index++) {
            String unitNM = '';
            int qty = GlobalParam.deliveryPodtList[index].iLOSSPRO ?? 0;
            double prince = 0;
            // ignore: unrelated_type_equality_checks
            if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iSUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iMUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM ?? '';
              // ignore: unrelated_type_equality_checks
            } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
              prince = qty *
                  double.parse(
                      GlobalParam.deliveryPodtList[index].iLUNITPRICE ?? '0');
              unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM ?? '';
            }
            return pw.Center(
                child: GlobalParam.deliveryPodtList[index].iLOSSPRO != 0
                    ? pw.Container(
                        child: pw.Column(children: [
                        pw.Row(children: [
                          pw.Text(
                              GlobalParam.deliveryPodtList[index].cPRODNM ?? '',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                  font: TH_NA)),
                          pw.Spacer(),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 196,
                            child: pw.Text(unitNM,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                          ),
                          pw.Container(
                              width: 116,
                              child: pw.Text(qty.toStringAsFixed(0),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                          pw.Container(
                              width: 172,
                              child: pw.Text(prince.toStringAsFixed(2),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                        ]),
                      ]))
                    : pw.Container());
          }
        }

        pw.Widget basketHeader() {
          return pw.Container(
              child: pw.Center(
            child: pw.Row(children: [
              pw.Text('คืนตะกร้า',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
              pw.Spacer(),
              pw.Text('ยอดเงิน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: TH_NA)),
            ]),
          ));
        }

        pw.Widget basketList() {
          for (int index = 0;
              index < GlobalParam.deliveryBasketReq.length;
              index++) {
            String basName = '';
            double basTotal = 0;
            for (int i = 0; i < GlobalParam.deliveryBasketList.length; i++) {
              if (GlobalParam.deliveryBasketList[i].cBASKCD ==
                  GlobalParam.deliveryBasketReq[index].cBASKCD) {
                basName = GlobalParam.deliveryBasketList[i].cBASKNM ?? '';
                basTotal = (GlobalParam.deliveryBasketReq[index].iQTY *
                    double.parse(
                        GlobalParam.deliveryBasketList[i].iPRICE ?? '0'))!;
              }
            }
            return pw.Center(
                child: GlobalParam.deliveryBasketReq[index].iQTY != 0
                    ? pw.Container(
                        child: pw.Column(children: [
                        pw.Row(children: [
                          pw.Container(
                            width: 196,
                            child: pw.Text(basName,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    font: TH_NA)),
                          ),
                          pw.Container(
                              width: 116,
                              child: pw.Text(
                                  GlobalParam.deliveryBasketReq[index].iQTY!
                                      .toStringAsFixed(0),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                          pw.Container(
                              width: 172,
                              child: pw.Text(basTotal.toStringAsFixed(2),
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      font: TH_NA))),
                        ]),
                      ]))
                    : pw.Container());
          }
        }

        return <pw.Widget>[
          header(),
          lineBreak(),
          locationStore(),
          lineBreak(),
          productHeader(),
          productList(),
          lineBreak(),
          incompHeader(),
          incompList(),
          lineBreak(),
          cancelHeader(),
          cancelList(),
          lineBreak(),
          lossHeader(),
          lossList(),
          lineBreak(),
          basketHeader(),
          basketList(),
          lineBreak(),
          footer(GlobalParam.deliveryUnitList)
        ];
      }));

  final file = File('example.pdf');
  List<int> bytes = await pdf.save();
  String poDate = DateFormat('yyyyMMddHHmm').format(DateTime.now());
  // await file.writeAsBytes(await pdf.save());
  saveAndLaunchFile(
      bytes, '${GlobalParam.deliveryPodtList[0].cPOCD}_${poDate}.pdf');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  // final path = (await getExternalStorageDirectory()).path;
  final path = '/storage/emulated/0/Documents';
  final file = File('$path/$fileName');
  // final bit = await bytes;
  print('***************$path');
  await file
      .writeAsBytes(bytes, flush: true)
      .then((value) => {OpenFile.open('$path/$fileName')});
}
