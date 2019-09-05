import 'package:flutter/material.dart';
import 'package:masrofaty/back_end/transaction_model.dart';
import 'package:masrofaty/back_end/transaction_provider.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
        
     int numDays = 31;

    final transactions=Provider.of<TransactionProvider>(context);
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Container(
        width: width,
        height: hight / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffeeeeee),
        ),
        child: transactions.getTransactionsAtMonth().length!=0?
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: numDays,
          itemBuilder: (ctx, index) {
            return buildChartItem(ctx, transactions.getSumOfDay(day: index+1),index);
          },
        ):Center(
          child: Text("لا يوجد مشتريات لهذا الشهر",style:TextStyle(color: Colors.blue,fontSize: 22),),
        ) ,
      ),
    );
  }
}

Widget buildChartItem(BuildContext ctx, double sum,int index) {
      final transactions=Provider.of<TransactionProvider>(ctx);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("${sum.toString()}"),
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(ctx).size.height / 4 * .6,
              width: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.blue),
            ),
            Container(
              height: MediaQuery.of(ctx).size.height / 4 * .6 *(1-sum/transactions.getMonthSum()),
              width: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
            ),
          ],
        ),
        Text("${(index+1).toString()}"),
      ],
    ),
  );
}
