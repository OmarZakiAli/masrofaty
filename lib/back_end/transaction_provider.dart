import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'transaction_model.dart';

class TransactionProvider with ChangeNotifier{

static final  db=DBProvider.db;

  List<Transaction> _list=  [];
   int _month= DateTime.now().month;
 final List<String> _monthes=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"];


 get currentMonth{
   return _month;
 }


    Future<bool> initList()async{
  
     if(_list.length==0){
       _list=await db.getAllTransactions();
       return false;   
     }else{
       return false;
     }

 }


 changeMonth(int month){
    _month=month;
    notifyListeners();
 }

 int get month{   return month;
 }

 addTransaction({DateTime time,String item, double price}) async{
     _list.add(Transaction(item: item,price: price,time: time));
     db.insertTransaction(Transaction(item: item,price: price,time: time));
      notifyListeners();

 }

 List<Transaction> getTransactionsAtMonth(){
   return _list.where((t)=>_monthes[_month-1]==t.month).toList();
 }

 deleteTransaction(DateTime time){

   _list.removeWhere((t)=>time==t.time);
   db.deleteTransaction(time.toString());
    notifyListeners();
 }
 
 deleteAll(){
   _list.clear();
   notifyListeners();

 }

 getSumOfDay({int day}){
  
   double sum=0;
   for(Transaction t in _list){
     if(day==t.time.day&&_monthes[_month-1]==t.month){
       sum=sum+t.price;
     }}

     return sum;
   
   }

getMonthSum(){
   double sum=0;
   for(Transaction t in _list){
     if(_monthes[_month-1]==t.month){
       sum=sum+t.price;
     }
       }

     return sum;
   }



  int get count{
    
    return _list.length;
 }


}