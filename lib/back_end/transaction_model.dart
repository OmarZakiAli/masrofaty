import 'package:intl/intl.dart';

class Transaction{


String item;
double price;
DateTime time;
Transaction({this.item,this.price,this.time});

 
 Transaction.fromMap(Map<String,Object> json){

item =json["item"];
price=json["price"];
time=DateTime.parse(json["time"]);

}

Map<String,Object> toMap(){
  return{
    "item":item,
    "price":price,
    "time":time.toString()
  };
}



int get day{
  return time.day;
}

String get month {
List<String> monthes=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"];

return monthes[time.month-1];
}


}