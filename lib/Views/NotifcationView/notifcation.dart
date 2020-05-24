import 'package:flutter/material.dart';
import 'package:ginsta/Views/NotifcationView/Utils/Methods.dart';
class Notifcation extends StatefulWidget {
  @override
  _NotifcationState createState() => _NotifcationState();
}

class _NotifcationState extends State<Notifcation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 2,

          // ignore: missing_return
          itemBuilder: (context,index){
        if(index==0)
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex:1,child: Icon(Icons.person_add,size: 45,)),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          Text('Follow Requestes',style: TextStyle(fontSize: 18),),
                          Text('Approve or ignore requestes',style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    )
                  ],
                ) ,
              ),
            );
          }else if (index == 1)
            {
             return Column(
               children: Methods().notiy(),
             );
            }
      }),
    );
  }
}
