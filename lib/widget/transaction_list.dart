import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sixapp/classses/transaction.dart';

class TransactionList extends StatelessWidget {
  final List <Transaction> transaction;
  final Function deletetx;

  TransactionList(this.transaction, this.deletetx);
  
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
    ?Column(
      children:<Widget>[
        Text('No transaction has been made please input data',
        style: Theme.of(context).textTheme.title,),
        SizedBox(height:10,),
        Container(
          height: 200,
          child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
      ]
    )
    
    
    :Container( 
      height:300,
      child: ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx, index){
          return Card(
            margin: EdgeInsets.symmetric(
              vertical:8,
              horizontal:5,
            ),
            elevation: 5,
            
                      child: ListTile(
              leading:CircleAvatar(
                radius:30,
                child:Padding(
                  padding: EdgeInsets.all(6),
                     child: FittedBox
                  (child: Text('\$${transaction [index].amount}')),
                ),
              ),
              title: Text(transaction[index].title,
              style:Theme.of(context).textTheme.title,
              ),
              subtitle: Text(DateFormat.yMd().format(transaction[index].date,)),
              trailing: IconButton(icon: Icon(Icons.delete),
               onPressed: ()=>deletetx(transaction[index].id), 
               color:Colors.red),
              

            ),
          )
          ;
        },
    
         )
    );
      
    
  }
}