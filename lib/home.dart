import 'package:flutter/material.dart';
import 'package:masrofaty/back_end/transaction_provider.dart';
import 'package:masrofaty/widgets/home_utils.dart';
import 'package:masrofaty/widgets/list_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/chart_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "مصروفي",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.yellow,
      ),
      home: ChangeNotifierProvider<TransactionProvider>(
        builder: (_) => TransactionProvider(),
        child: new HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> monthes = [
      "يناير",
      "فبراير",
      "مارس",
      "ابريل",
      "مايو",
      "يونيو",
      "يوليو",
      "اغسطس",
      "سبتمبر",
      "اكتوبر",
      "نوفمبر",
      "ديسمير"
    ];
    final pro = Provider.of<TransactionProvider>(context);
     
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مصروفاتي",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              tooltip: "اضافه عمليه شراء",
              color: Colors.yellow,
              iconSize: 30,
              icon: Icon(Icons.add),
              onPressed: () {
                //transactions.addTransaction(item: "french fries",time: DateTime.now(),price: 30);
                addItem(context);
                print("add button pressed");
              },
            ),
          ),
          PopupMenuButton(
            tooltip: "تغيير الشهر",
            padding: EdgeInsets.only(right: 6),
            icon: Icon(Icons.menu),
            onSelected: (mo) {
              Provider.of<TransactionProvider>(context)
                  .changeMonth(monthes.indexOf(mo) + 1);
            //  Navigator.of(context).pop();
            },
            itemBuilder: (context) {
              return monthes.map((mo) {
                return PopupMenuItem(
                  value: mo,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Center(
                            child: Text(
                          mo,
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ))),
                   
                  
                );
              }).toList();
            },
          ),
        ],
      ),
      body: 
          FutureBuilder(
            future: pro.initList(),
            builder: (context,snap){
              if(snap.connectionState==ConnectionState.done){
              return  Column(
        children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                monthes[pro.currentMonth - 1],
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25),
              ),
            ),
            Chart(),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                pro.getMonthSum().toString(),
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TransactionList(),
                flex: 2,
              ),
        ],
      );}else{
        return Center(
          child: CircularProgressIndicator(

          ),
        );
      }
            },
                      
          ),
    );
  }
}
