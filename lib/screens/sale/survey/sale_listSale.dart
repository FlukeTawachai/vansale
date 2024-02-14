import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/screens/Supplier/delivery/models/store.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/deliveryCard.dart';
import 'package:vansale/screens/sale/survey/storeCard.dart';

class SaleListSale extends StatefulWidget {
  final  List<GetSaleStoreOrderResp>?  data;
  const SaleListSale({ Key? key ,this.data}) : super(key: key);
  
  @override
  _SaleListSaleState createState() => _SaleListSaleState();
}

class _SaleListSaleState extends State<SaleListSale> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: widget.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return SaleSurveyCard(GlobalParam.typeMenuCode!, widget.data![index]);
      },
    );
  }
}
