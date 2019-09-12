import 'package:flutter/material.dart';
import 'package:masrofaty/back_end/transaction_model.dart';
import 'package:masrofaty/back_end/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
 

  @override
  Widget build(BuildContext context) {
 
   final transactions =Provider.of<TransactionProvider>(context);

  
      return 

         ListView.builder(
          itemCount:transactions.getTransactionsAtMonth().length,
          itemBuilder: (ctx, index) {
            return buildTransactionListTile(ctx, transactions.getTransactionsAtMonth()[index]);
          },
        )
      
    ;
  }
}



Widget buildTransactionListTile(BuildContext ctx, Transaction tranaction) {
     final transactions =Provider.of<TransactionProvider>(ctx);

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    color: Theme.of(ctx).primaryColorLight,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(ctx).accentColor,
          child: Center(child: Text("\$${tranaction.price.toString()}",textAlign: TextAlign.center,)),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.red,
          child: IconButton(
            iconSize: 23,
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
 
              transactions.deleteTransaction(tranaction.time);
              print("delete item");
            },
          ),
        ),

        title: Text("${tranaction.item}",style: Theme.of(ctx).primaryTextTheme.title,),
        subtitle: Text("${tranaction.day.toString()},${tranaction.month}",style: Theme.of(ctx).primaryTextTheme.subtitle,) ,
    ),
  ));
}
