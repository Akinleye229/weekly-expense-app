import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import './widget/new_transaction.dart';
import './classses/transaction.dart';
import './widget/transaction_list.dart';
import './widget/chart.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
   MaterialApp(
     title:'personal expenses',
     theme: ThemeData(
       primarySwatch:Colors.purple,
       accentColor: Colors.purple,
       textTheme: ThemeData.light().textTheme.copyWith(
         title:TextStyle(fontFamily:
         'OpenSans',
         fontWeight: FontWeight.bold,
         fontSize: 18, )
       ),
       fontFamily: 'Quicksand',
       appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
           title:TextStyle(
             fontFamily: 'OpenSans',
             fontSize: 20,
             fontWeight: FontWeight.bold,
           )
         )

       )
     ),
    home:MyApp()
     
    ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final List <Transaction> _transaction =[
   //Transaction(id:'1', title: 'data', amount: 100, date: DateTime.now()),
   //Transaction(id:'2', title:'food',amount: 6000, date:DateTime.now() )


  ];

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days:7)),
      );



    }).toList();

  }
  bool switchchart=false;

   void _addnewTransaction(String title, double amount, DateTime chosenDate){

     final newtx=Transaction(title:title,
     amount:amount,
     id:DateTime.now().toString(),
     date:chosenDate);

     setState(() {
       _transaction.add(newtx);

     });
   }

 void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
     return GestureDetector( child: NewTransaction(_addnewTransaction),
      onTap: (){},
     behavior: HitTestBehavior.opaque,
    );
    });
  }

  void _deleteTransaction( String id){
    setState(() {
     _transaction.removeWhere((tx) {
       return tx.id==id;
     });
      
    });

  }
  @override
  Widget build(BuildContext context) {
    final islandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar=AppBar(
      title:Text('Expenses App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: ()=> _startAddNewTransaction(context))
        ],

    );
    final listWidget=  Container(
                height: (MediaQuery.of(context).size.height- appBar.preferredSize.height- MediaQuery.of(context).padding.top)*0.7,
               child: TransactionList(_transaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body:Column(
             
        //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (islandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('show Chart'),
                Switch(value: true,onChanged: (val){

                  switchchart=val;
                },
            

                )
              ],
            ),
            if (!islandscape)
            Container(
              height: (MediaQuery.of(context).size.height- appBar.preferredSize.height- MediaQuery.of(context).padding.top)*0.3 ,
              child: Chart(_recentTransaction)),
               if (!islandscape)
                listWidget,


            


            switchchart ?
            Container(
              height: (MediaQuery.of(context).size.height- appBar.preferredSize.height- MediaQuery.of(context).padding.top)*0.7 ,
              child: Chart(_recentTransaction))
              :
            listWidget,
           
           
           
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(onPressed: ()=> _startAddNewTransaction(context),
        child:Icon(Icons.add)),
    );
    




  }
}
      