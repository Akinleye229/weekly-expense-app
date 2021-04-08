import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class NewTransaction extends StatefulWidget {
   final Function newtx;

   NewTransaction(this.newtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
   final titleContoller=TextEditingController();

   final amountContoller=TextEditingController();
   DateTime selectedDate;

   void _sumbitdata() {
     if(amountContoller.text.isEmpty){
       return;
     }
     final enteredAmount=double.parse(amountContoller.text);
     final enteredTitle=titleContoller.text;
     
     if(enteredTitle.isEmpty ||enteredAmount <=0|| selectedDate==null){
       return;
     }


      widget.newtx
      (enteredTitle,
      enteredAmount,
      selectedDate,);
      Navigator.of(context).pop();
   }
  void _presentDatePicker(){
    showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2020), 
    lastDate: DateTime.now(),).then((pickedDate){
      if (pickedDate==null){
      return;
      }
      setState(() {
        selectedDate=pickedDate;
        
      });
      


    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          child: Card(child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom+10,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:<Widget>[
                  TextField( decoration: InputDecoration(labelText:'Tile of Transaction'),
                  controller:titleContoller,
                  onSubmitted: (_)=>_sumbitdata(),
                   ),
                  TextField(decoration: InputDecoration(labelText:'Amount of transaction',),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_)=>_sumbitdata(),
                  controller: amountContoller,),

                   Container(
                     height: 70,
                     child: Row(
                       children:<Widget>[
                         Expanded(child: Text(selectedDate==null ?'no chosen date':DateFormat.yMd().format(selectedDate),)),
                         FlatButton(
                           child: Text('choose date'),
                           textColor: Colors.purple,
                           onPressed:_presentDatePicker,
                         )
                       ]
                     ),
                   ),
                  RaisedButton(
                    color: Colors.purple,
                    
                    onPressed: _sumbitdata,
                   child: Text('Add new transaction'),
                   textColor: Colors.white,),
                  
                  

                ]
              ),
            ),),
    );
         
  }
}