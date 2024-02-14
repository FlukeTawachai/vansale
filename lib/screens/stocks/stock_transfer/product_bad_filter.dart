import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_bad.dart';
import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_good.dart';

class StockTransferBadFilter extends StatefulWidget {
  final String pageNumber;
  const StockTransferBadFilter({Key key, this.pageNumber}) : super(key: key);

  @override
  State<StockTransferBadFilter> createState() => _StockTransferBadFilterState();
}

class _StockTransferBadFilterState extends State<StockTransferBadFilter> {
  var subType = [];
  List filter = [];
  double widthScreen;
  var typeCodeNum = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < GlobalParam.deliveryProType.length; i++) {
      // type[i]['onClick'] = false;
      GlobalParam.deliveryProType[i].onClick = false;
      for (int j = 0; j < GlobalParam.deliveryProType[i].category.length; j++) {
        GlobalParam.deliveryProType[i].category[j].onSelect = false;
        for (int k = 0;
            k < GlobalParam.deliveryProType[i].category[j].subCategory.length;
            k++) {
          GlobalParam.deliveryProType[i].category[j].subCategory[k].click =
              false;
          for (int l = 0;
              l <
                  GlobalParam.deliveryProType[i].category[j].subCategory[k]
                      .brand.length;
              l++) {
            GlobalParam.deliveryProType[i].category[j].subCategory[k].brand[l]
                .click = false;
          }
        }
      }
    }
    // print(GlobalParam.customerBadProList.length);
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('กรองสินค้า'),
      ),
      backgroundColor: HexColor('#E3EDF0'),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 96,
              child: ListView.builder(
                  itemCount: GlobalParam.deliveryProType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        for (int i = 0;
                            i < GlobalParam.deliveryProType.length;
                            i++) {
                          GlobalParam.deliveryProType[i].onClick = false;
                        }

                        setState(() {
                          subType = GlobalParam.deliveryProType[index].category;
                          GlobalParam.deliveryProType[index].onClick = true;
                          typeCodeNum =
                              GlobalParam.deliveryProType[index].typeCD;
                          // print(proType[index]['category']);
                        });
                      },
                      child: Container(
                        width: widthScreen * 0.2,
                        height: 96,
                        color:
                            GlobalParam.deliveryProType[index].onClick == true
                                ? HexColor('#ffffff')
                                : HexColor('#E3EDF0'),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${GlobalParam.deliveryProType[index].typeName}',
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )),
                      ),
                    );
                  })),
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: subType.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: 48,

                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      subType[index].hight = 48 *
                                          subType[index].subCategory.length;
                                      if (subType[index].onSelect == true) {
                                        subType[index].onSelect = false;
                                      } else {
                                        subType[index].onSelect = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      width: 2,
                                      color: subType[index].onSelect == true
                                          ? Colors.green
                                          : Colors.grey,
                                    ))),
                                    height: 48,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${subType[index].catNM}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Prompt',
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                subType[index].onSelect == true
                                    ? Container(
                                        height: double.parse(
                                            '${subType[index].hight}'),
                                        child: ListView.builder(
                                            itemCount: subType[index]
                                                .subCategory
                                                .length,
                                            itemBuilder:
                                                (BuildContext context, int j) {
                                              return Container(
                                                // width: 48,

                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            int oldHeight =
                                                                subType[index]
                                                                    .hight;
                                                            int brandLength =
                                                                subType[index]
                                                                    .subCategory[
                                                                        j]
                                                                    .brand
                                                                    .length;
                                                            int itemLength =
                                                                subType[index]
                                                                    .subCategory
                                                                    .length;

                                                            if (subType[index]
                                                                    .subCategory[
                                                                        j]
                                                                    .click ==
                                                                true) {
                                                              subType[index]
                                                                  .subCategory[
                                                                      j]
                                                                  .click = false;
                                                            } else {
                                                              subType[index]
                                                                  .subCategory[
                                                                      j]
                                                                  .click = true;
                                                            }

                                                            if (subType[index]
                                                                    .subCategory[
                                                                        j]
                                                                    .click ==
                                                                true) {
                                                              subType[index]
                                                                      .hight =
                                                                  oldHeight +
                                                                      (brandLength *
                                                                          48);
                                                            } else {
                                                              subType[index]
                                                                      .hight =
                                                                  oldHeight -
                                                                      (brandLength *
                                                                          48);
                                                            }

                                                            // for (int i = 0;
                                                            //     i <
                                                            //         subType[index]
                                                            //             .subCategory[
                                                            //                 j]
                                                            //             .brand
                                                            //             .length;
                                                            //     i++) {
                                                            //   subType[index]
                                                            //       .subCategory[
                                                            //           j]
                                                            //       .brand[i]
                                                            //       .click = true;
                                                            // }
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                            color: subType[index]
                                                                        .subCategory[
                                                                            j]
                                                                        .click ==
                                                                    true
                                                                ? Colors.green
                                                                : HexColor(
                                                                    '#E3EDF0'),
                                                          ))),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          height: 48,
                                                          child: Text(
                                                            '  ${subType[index].subCategory[j].subCatNM}',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Prompt',
                                                                color: subType[index]
                                                                            .subCategory[
                                                                                j]
                                                                            .click ==
                                                                        true
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        )),
                                                    subType[index]
                                                                .subCategory[j]
                                                                .click ==
                                                            true
                                                        ? Container(
                                                            height: subType[
                                                                        index]
                                                                    .subCategory[
                                                                        j]
                                                                    .brand
                                                                    .length *
                                                                48.0,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: subType[
                                                                            index]
                                                                        .subCategory[
                                                                            j]
                                                                        .brand
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int i) {
                                                                      return subType[index].subCategory[j].brand.length !=
                                                                              0
                                                                          ? Row(
                                                                              children: [
                                                                                Container(
                                                                                  width: widthScreen * 0.5,
                                                                                  child: Text(
                                                                                    '    แบรนด์ - ${subType[index].subCategory[j].brand[i].brandNM}',
                                                                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt', color: subType[index].onSelect == true ? Colors.green : Colors.grey, overflow: TextOverflow.ellipsis),
                                                                                  ),
                                                                                ),
                                                                                Spacer(),
                                                                                Container(
                                                                                    width: widthScreen * 0.2,
                                                                                    child: Checkbox(
                                                                                      checkColor: Colors.white,
                                                                                      activeColor: Colors.green,
                                                                                      value: subType[index].subCategory[j].brand[i].click,
                                                                                      onChanged: (bool value) {
                                                                                        setState(() {
                                                                                          subType[index].subCategory[j].brand[i].click = value;
                                                                                        });
                                                                                      },
                                                                                    )),
                                                                              ],
                                                                            )
                                                                          : Container();
                                                                    }),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              );
                                            }))
                                    : Container()
                              ],
                            ),
                          ),
                        );
                      }))),
        ],
      ),
      bottomNavigationBar: Container(
        height: 64,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            // Navigator.of(context).pop();

            for (int i = 0; i < GlobalParam.deliveryProType.length; i++) {
              if (GlobalParam.deliveryProType[i].onClick == true) {
                GlobalParam.deliveryProType[i].category = subType;
              }
            }

            var type = GlobalParam.deliveryProType;

            var catCodeList = [];
            var subCatCodeList = [];
            var brandCodeList = [];

            for (int i = 0; i < type.length; i++) {
              var cate = type[i].category;
              if (type[i].onClick == true) {
                typeCodeNum = type[i].typeCD;
              }

              for (int j = 0; j < cate.length; j++) {
                var subCate = cate[j].subCategory;
                if (cate[j].onSelect == true) {
                  catCodeList.add(cate[j].catCD);
                }
                for (int k = 0; k < subCate.length; k++) {
                  var bra = subCate[k].brand;
                  if (subCate[k].click == true) {
                    subCatCodeList.add(subCate[k].subCatCD);
                  }

                  for (int l = 0; l < bra.length; l++) {
                    if (bra[l].click == true) {
                      brandCodeList.add(bra[l].brandCD);
                    }
                  }
                }
              }
            }

            List<GetProductBranchResp> typeF = [];
            List<GetProductBranchResp> catF = [];
            List<GetProductBranchResp> subCatF = [];
            List<GetProductBranchResp> braF = [];
            if (typeCodeNum != '') {
              GlobalParam.customerShowBadProList = [];

              for (int i = 0; i < GlobalParam.customerBadProList.length; i++) {
                if (GlobalParam.customerBadProList[i].cTYPE == typeCodeNum) {
                  GlobalParam.customerShowBadProList
                      .add(GlobalParam.customerBadProList[i]);

                  typeF.add(GlobalParam.customerBadProList[i]);
                }
              }
              if (catCodeList.length > 0) {
                GlobalParam.customerShowBadProList = [];

                for (int i = 0; i < typeF.length; i++) {
                  for (int j = 0; j < catCodeList.length; j++) {
                    if (typeF[i].cCATECD == catCodeList[j]) {
                      catF.add(typeF[i]);
                    }
                  }
                }
                // for (int j = 0; j < catF.length; j++) {
                //   print(catF[j].cPRODNM);
                // }

                for (int i = 0;
                    i < GlobalParam.customerBadProList.length;
                    i++) {
                  for (int j = 0; j < catF.length; j++) {
                    if (GlobalParam.customerBadProList[i].cPRODCD ==
                            catF[j].cPRODCD &&
                        GlobalParam.customerShowBadProList.length <
                            GlobalParam.customerBadProList.length) {
                      // print(catF[j].cPRODNM );
                      GlobalParam.customerShowBadProList
                          .add(GlobalParam.customerBadProList[i]);
                    }
                  }
                }
                if (subCatCodeList.length > 0) {
                  GlobalParam.customerShowBadProList = [];

                  for (int i = 0; i < catF.length; i++) {
                    for (int j = 0; j < subCatCodeList.length; j++) {
                      if (catF[i].cSUBCATECD == subCatCodeList[j]) {
                        subCatF.add(catF[i]);
                      }
                    }
                  }

                  for (int i = 0;
                      i < GlobalParam.customerBadProList.length;
                      i++) {
                    for (int j = 0; j < subCatF.length; j++) {
                      if (subCatF[j].cPRODCD ==
                              GlobalParam.customerBadProList[i].cPRODCD &&
                          GlobalParam.customerShowBadProList.length <
                              GlobalParam.customerBadProList.length) {
                        GlobalParam.customerShowBadProList
                            .add(GlobalParam.customerBadProList[i]);
                      }
                    }
                  }
                  if (brandCodeList.length > 0) {
                    GlobalParam.customerShowBadProList = [];

                    for (int i = 0; i < subCatF.length; i++) {
                      for (int j = 0; j < brandCodeList.length; j++) {
                        if (subCatF[i].cBRNDCD == brandCodeList[j]) {
                          braF.add(subCatF[i]);
                        }
                      }
                    }

                    for (int i = 0;
                        i < GlobalParam.customerBadProList.length;
                        i++) {
                      for (int j = 0; j < braF.length; j++) {
                        if (braF[j].cPRODCD ==
                                GlobalParam.customerBadProList[i].cPRODCD &&
                            GlobalParam.customerShowBadProList.length <
                                GlobalParam.customerBadProList.length) {
                          GlobalParam.customerShowBadProList
                              .add(GlobalParam.customerBadProList[i]);
                        }
                      }
                    }
                  } else {
                    GlobalParam.customerShowBadProList = [];

                    for (int i = 0;
                        i < GlobalParam.customerBadProList.length;
                        i++) {
                      for (int j = 0; j < subCatF.length; j++) {
                        if (subCatF[j].cPRODCD ==
                                GlobalParam.customerBadProList[i].cPRODCD &&
                            GlobalParam.customerShowBadProList.length <
                                GlobalParam.customerBadProList.length) {
                          GlobalParam.customerShowBadProList
                              .add(GlobalParam.customerBadProList[i]);
                        }
                      }
                    }
                  }
                } else {
                  GlobalParam.customerShowBadProList = [];

                  for (int i = 0;
                      i < GlobalParam.customerBadProList.length;
                      i++) {
                    for (int j = 0; j < catF.length; j++) {
                      if (GlobalParam.customerBadProList[i].cPRODCD ==
                              catF[j].cPRODCD &&
                          GlobalParam.customerShowBadProList.length <
                              GlobalParam.customerBadProList.length) {
                        GlobalParam.customerShowBadProList
                            .add(GlobalParam.customerBadProList[i]);
                      }
                    }
                  }
                }
              }
            } else {
              GlobalParam.customerShowBadProList =
                  GlobalParam.customerBadProList;
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StockTransferReturnBadPro(false)));
          },
          child: Container(
              // width: 96,
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  LineAwesomeIcons.filter,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('กรองสินค้า',
                    style: TextStyle(
                        fontFamily: 'Pormpt',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
