import 'package:flutter/material.dart';
class Methods
{
  List<Widget> notiy()
  {
    List<Widget> notiyy = [];
    for(int i =0 ;i<20;i++){
    Widget columenn =  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipOval(
              child: Container(
                  color: Colors.black,
                  width:50,
                  height: 50,
                  child: Image.asset('images/amr.jpg')),
            ),
            Text(' amr liked your photo'),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Image.asset('images/huda.jpg'),
            )
          ],
        ),
      ),
    );
     notiyy.add(columenn);
     }
    return notiyy;

  }
}
