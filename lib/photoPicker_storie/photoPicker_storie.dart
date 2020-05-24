import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
class photopickerStorie extends StatefulWidget {
  @override
  _photopickerStorieState createState() => _photopickerStorieState();
}

class _photopickerStorieState extends State<photopickerStorie> {
  File _image;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(alignment: Alignment.center,width: double.infinity,height:350,child: _image==null?Text('no image yet'):Image.file(_image),)),
              Expanded(
                flex: 1,
                  child: Row(
                  children: <Widget>[
                    Expanded(
                  flex: 1,
                    child: GestureDetector(

                    onTap: (){
                      getImage();
                    },
                    child: Container(alignment: Alignment.center,width: double.infinity,height: 50,child: Text('pick photo',style: TextStyle(color: Colors.white),),decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)) ,color: Colors.blue),),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                 flex: 1,
                    child: GestureDetector(
                      
                    onTap: () async {
                      if(_image != null){
                      var status = await helper.RegisterLogin().addstorie(_image);
                      if(status == 200)
                      {
                        print('post done');
                      }
                      }
                    },
                    child: Container(alignment: Alignment.center,width: double.infinity,height: 50,child: Text('post',style: TextStyle(color: Colors.white),),decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)) ,color: Colors.blue),),
                  ),
                )
                  ],
                ),
              )
              
            ],
          ),
        ),
        
      ),
    );
  }
}