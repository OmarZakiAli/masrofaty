import 'package:flutter/material.dart';
import 'package:masrofaty/back_end/transaction_provider.dart';
import 'package:provider/provider.dart';

//get date to show


getDate(BuildContext context) async {

   return await showDatePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year,1,  1 ),
    lastDate: DateTime.now(),
    initialDate: DateTime.now().subtract(Duration(hours: 1)),
    initialDatePickerMode: DatePickerMode.day,
  ).then((picked){

   if(picked==null){
        return DateTime.now();
       }else{
         return picked;
       }
       
  });

}

















// add new transaction


               
void addItem(BuildContext context) {
  DateTime time=DateTime.now();
  final trans=Provider.of<TransactionProvider>(context);
   TextEditingController itemC=TextEditingController();
      TextEditingController priceC=TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Directionality(
            child: Text(
              "اضف عنصر جديد",
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColorDark),
            ),
            textDirection: TextDirection.rtl,
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    controller: itemC,
                    decoration: InputDecoration(
                      labelText: "اسم السلعه",
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: priceC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "السعر",
                      labelStyle: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: InkWell(
                      child: Text(
                        "اختيار التاريخ",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                      onTap: () async{
                        time =  await getDate(context);
                      },
                    ),
                  ),
                             
                        SizedBox(height: 20,),

                        Center(
                          child: InkWell(
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              
                              ),
                              child: Center(
                                child: Text("اضافه",style: TextStyle(color: Colors.white,fontSize: 24),),

                              ),
                            ),
                            onTap: (){
                              trans.addTransaction(time: time,item: itemC.text,price: double.parse(priceC.text));
                              Navigator.of(context).pop();

                            },
                          ),
                        )

                          

                ],
              ),
            ),
          ),
        );
      });
} 

  







 void changeMonth(BuildContext context) {

     
  

}
                
 

