import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getHisProduct.dart';
import 'package:vansale/api/class/response/routeMobile/getSPOrderDTResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_purchase_order_edit.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetBad_Product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetGood_Product.dart';
import 'package:vansale/screens/stocks/stockOrderDetail.dart';

import '../../../api/class/response/routeMobile/proTypeResp.dart';

class CustomerFilterPage extends StatefulWidget {
  final String pageNumber;
  const CustomerFilterPage({Key? key, required this.pageNumber})
      : super(key: key);

  @override
  State<CustomerFilterPage> createState() => _CustomerFilterPageState();
}

class _CustomerFilterPageState extends State<CustomerFilterPage> {
  var subType = [];
  List filter = [];
  late double widthScreen;
  var typeCodeNum = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < GlobalParam.deliveryProType.length; i++) {
      // type[i]['onClick'] = false;
      GlobalParam.deliveryProType[i].onClick = false;
      for (int j = 0;
          j < (GlobalParam.deliveryProType[i].category ?? []).length;
          j++) {
        GlobalParam.deliveryProType[i].category![j].onSelect = false;
        for (int k = 0;
            k <
                (GlobalParam.deliveryProType[i].category![j].subCategory ?? [])
                    .length;
            k++) {
          GlobalParam.deliveryProType[i].category![j].subCategory![k].click =
              false;
          for (int l = 0;
              l <
                  (GlobalParam.deliveryProType[i].category![j].subCategory![k]
                              .brand ??
                          [])
                      .length;
              l++) {
            GlobalParam.deliveryProType[i].category![j].subCategory![k]
                .brand![l].click = false;
          }
        }
      }
    }
    // print(GlobalParam.deliveryPodtList.length);
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('กรองสินค้า'),
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
                          subType =
                              GlobalParam.deliveryProType[index].category!;
                          GlobalParam.deliveryProType[index].onClick = true;
                          typeCodeNum =
                              GlobalParam.deliveryProType[index].typeCD!;
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
                            style: const TextStyle(
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
                                      style: const TextStyle(
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
                                                                                const Spacer(),
                                                                                SizedBox(
                                                                                    width: widthScreen * 0.2,
                                                                                    child: Checkbox(
                                                                                      checkColor: Colors.white,
                                                                                      activeColor: Colors.green,
                                                                                      value: subType[index].subCategory[j].brand[i].click,
                                                                                      onChanged: (value) {
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
                List<Category> fomatSubType = subType.map((item) {
                  return Category(
                    catNM: item['catNM'],
                    catCD: item['catCD'],
                    onSelect: item['onSelect'],
                    hight: item['hight'],
                    subCategory: item['subCategory'],
                  );
                }).toList();
                GlobalParam.deliveryProType[i].category = fomatSubType;
              }
            }

            var type = GlobalParam.deliveryProType;

            var catCodeList = [];
            var subCatCodeList = [];
            var brandCodeList = [];

            for (int i = 0; i < type.length; i++) {
              var cate = type[i].category;
              if (type[i].onClick == true) {
                typeCodeNum = type[i].typeCD!;
              }

              for (int j = 0; j < (cate ?? []).length; j++) {
                var subCate = cate![j].subCategory;
                if (cate[j].onSelect == true) {
                  catCodeList.add(cate[j].catCD);
                }
                for (int k = 0; k < (subCate ?? []).length; k++) {
                  var bra = subCate![k].brand;
                  if (subCate[k].click == true) {
                    subCatCodeList.add(subCate[k].subCatCD);
                  }

                  for (int l = 0; l < (bra ?? []).length; l++) {
                    if (bra![l].click == true) {
                      brandCodeList.add(bra[l].brandCD);
                    }
                  }
                }
              }
            }

            if (widget.pageNumber != '003') {
              List<QueryPodtResp> typeF = [];
              List<QueryPodtResp> catF = [];
              List<QueryPodtResp> subCatF = [];
              List<QueryPodtResp> braF = [];
              if (typeCodeNum != '') {
                GlobalParam.deliveryPodtShow = [];

                for (int i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
                  if (GlobalParam.deliveryPodtList[i].cTYPE == typeCodeNum) {
                    GlobalParam.deliveryPodtShow
                        .add(GlobalParam.deliveryPodtList[i]);

                    typeF.add(GlobalParam.deliveryPodtList[i]);
                  }
                }
                if (catCodeList.length > 0) {
                  GlobalParam.deliveryPodtShow = [];

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
                      i < GlobalParam.deliveryPodtList.length;
                      i++) {
                    for (int j = 0; j < catF.length; j++) {
                      if (GlobalParam.deliveryPodtList[i].cPRODCD ==
                              catF[j].cPRODCD &&
                          GlobalParam.deliveryPodtShow.length <
                              GlobalParam.deliveryPodtList.length) {
                        // print(catF[j].cPRODNM );
                        GlobalParam.deliveryPodtShow
                            .add(GlobalParam.deliveryPodtList[i]);
                      }
                    }
                  }
                  if (subCatCodeList.length > 0) {
                    GlobalParam.deliveryPodtShow = [];

                    for (int i = 0; i < catF.length; i++) {
                      for (int j = 0; j < subCatCodeList.length; j++) {
                        if (catF[i].cSUBCATECD == subCatCodeList[j]) {
                          subCatF.add(catF[i]);
                        }
                      }
                    }

                    for (int i = 0;
                        i < GlobalParam.deliveryPodtList.length;
                        i++) {
                      for (int j = 0; j < subCatF.length; j++) {
                        if (subCatF[j].cPRODCD ==
                                GlobalParam.deliveryPodtList[i].cPRODCD &&
                            GlobalParam.deliveryPodtShow.length <
                                GlobalParam.deliveryPodtList.length) {
                          GlobalParam.deliveryPodtShow
                              .add(GlobalParam.deliveryPodtList[i]);
                        }
                      }
                    }
                    if (brandCodeList.length > 0) {
                      GlobalParam.deliveryPodtShow = [];

                      for (int i = 0; i < subCatF.length; i++) {
                        for (int j = 0; j < brandCodeList.length; j++) {
                          if (subCatF[i].cBRNDCD == brandCodeList[j]) {
                            braF.add(subCatF[i]);
                          }
                        }
                      }

                      for (int i = 0;
                          i < GlobalParam.deliveryPodtList.length;
                          i++) {
                        for (int j = 0; j < braF.length; j++) {
                          if (braF[j].cPRODCD ==
                                  GlobalParam.deliveryPodtList[i].cPRODCD &&
                              GlobalParam.deliveryPodtShow.length <
                                  GlobalParam.deliveryPodtList.length) {
                            GlobalParam.deliveryPodtShow
                                .add(GlobalParam.deliveryPodtList[i]);
                          }
                        }
                      }
                    } else {
                      GlobalParam.deliveryPodtShow = [];

                      for (int i = 0;
                          i < GlobalParam.deliveryPodtList.length;
                          i++) {
                        for (int j = 0; j < subCatF.length; j++) {
                          if (subCatF[j].cPRODCD ==
                                  GlobalParam.deliveryPodtList[i].cPRODCD &&
                              GlobalParam.deliveryPodtShow.length <
                                  GlobalParam.deliveryPodtList.length) {
                            GlobalParam.deliveryPodtShow
                                .add(GlobalParam.deliveryPodtList[i]);
                          }
                        }
                      }
                    }
                  } else {
                    GlobalParam.deliveryPodtShow = [];

                    for (int i = 0;
                        i < GlobalParam.deliveryPodtList.length;
                        i++) {
                      for (int j = 0; j < catF.length; j++) {
                        if (GlobalParam.deliveryPodtList[i].cPRODCD ==
                                catF[j].cPRODCD &&
                            GlobalParam.deliveryPodtShow.length <
                                GlobalParam.deliveryPodtList.length) {
                          GlobalParam.deliveryPodtShow
                              .add(GlobalParam.deliveryPodtList[i]);
                        }
                      }
                    }
                  }
                }
              } else {
                GlobalParam.deliveryPodtShow = GlobalParam.deliveryPodtList;
              }
            } else {
              List<GetSPOrderDTResp> typeF = [];
              List<GetSPOrderDTResp> catF = [];
              List<GetSPOrderDTResp> subCatF = [];
              List<GetSPOrderDTResp> braF = [];
              List<GetSPOrderDTResp> products = [];
              if (typeCodeNum != '') {
                GlobalParam.deliveryPodtShow = [];
                for (int i = 0;
                    i < GlobalParam.supplierOrProductList.length;
                    i++) {
                  if (GlobalParam.supplierOrProductList[i].cPOCD ==
                      GlobalParam.supplierSelectOrder!.cPOCD) {
                    products.add(GlobalParam.supplierOrProductList[i]);
                  }
                }

                for (int i = 0; i < products.length; i++) {
                  if (products[i].cTYPE == typeCodeNum) {
                    typeF.add(products[i]);
                  }
                }
                if (catCodeList.isNotEmpty) {
                  GlobalParam.supplierOrProductShowList = [];

                  for (int i = 0; i < typeF.length; i++) {
                    for (int j = 0; j < catCodeList.length; j++) {
                      if (typeF[i].cCATECD == catCodeList[j]) {
                        catF.add(typeF[i]);
                        GlobalParam.supplierOrProductShowList.add(typeF[i]);
                      }
                    }
                  }

                  if (subCatCodeList.isNotEmpty) {
                    GlobalParam.supplierOrProductShowList = [];

                    for (int i = 0; i < catF.length; i++) {
                      for (int j = 0; j < subCatCodeList.length; j++) {
                        if (catF[i].cSUBCATECD == subCatCodeList[j]) {
                          subCatF.add(catF[i]);
                          GlobalParam.supplierOrProductShowList.add(catF[i]);
                        }
                      }
                    }
                    if (brandCodeList.isNotEmpty) {
                      GlobalParam.supplierOrProductShowList = [];

                      for (int i = 0; i < subCatF.length; i++) {
                        for (int j = 0; j < brandCodeList.length; j++) {
                          if (subCatF[i].cBRNDCD == brandCodeList[j]) {
                            braF.add(subCatF[i]);
                            GlobalParam.supplierOrProductShowList
                                .add(subCatF[i]);
                          }
                        }
                      }
                    } else {
                      GlobalParam.supplierOrProductShowList = [];

                      for (int i = 0; i < products.length; i++) {
                        for (int j = 0; j < subCatF.length; j++) {
                          if (subCatF[j].cPRODCD == products[i].cPRODCD &&
                              GlobalParam.supplierOrProductShowList.length <
                                  products.length) {
                            GlobalParam.supplierOrProductShowList
                                .add(products[i]);
                          }
                        }
                      }
                    }
                  } else {
                    GlobalParam.supplierOrProductShowList = [];

                    for (int i = 0; i < products.length; i++) {
                      for (int j = 0; j < catF.length; j++) {
                        if (products[i].cPRODCD == catF[j].cPRODCD &&
                            GlobalParam.supplierOrProductShowList.length <
                                products.length) {
                          GlobalParam.supplierOrProductShowList
                              .add(products[i]);
                        }
                      }
                    }
                  }
                }
              } else {
                for (int i = 0;
                    i < GlobalParam.supplierOrProductList.length;
                    i++) {
                  if (GlobalParam.supplierOrProductList[i].cPOCD ==
                      GlobalParam.supplierSelectOrder!.cPOCD) {
                    products.add(GlobalParam.supplierOrProductList[i]);
                  }
                }
                GlobalParam.supplierOrProductShowList = products;
              }
            }

            // print(typeCodeNum);
            // print(catCodeList);
            // print(subCatCodeList);
            // print(brandCodeList);
            // for (int j = 0; j < GlobalParam.deliveryPodtList.length; j++) {
            //   print(GlobalParam.deliveryPodtList[j].cPRODNM);
            // }
            // print(
            //     '${GlobalParam.deliveryPodtShow.length} :: ${GlobalParam.deliveryPodtList.length}');
            GlobalParam.deliveryRegetPODT = false;
            if (widget.pageNumber == '001') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CustomerPurchaseOrderEdit(
                      GlobalParam.typeMenuCode ?? '', false),
                ),
              );
            }
          },
          child: Container(
              // width: 96,
              child: const Center(
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
