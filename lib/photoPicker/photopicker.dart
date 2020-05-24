import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
class photopicker extends StatefulWidget {
  int index;
  photopicker(index)
  {
    this.index = index;
  }
  @override
  _photopickerState createState() => _photopickerState();
}

class _photopickerState extends State<photopicker> {
  File _image;
  String caption;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(alignment: Alignment.center,width: double.infinity,height:350,child: _image==null?Text('no image yet'):Image.file(_image),)),
            Expanded(flex: 1,child: TextField(
              onChanged: (caption_)
              {
                caption = caption_;
              },
              cursorColor: Colors.black,
              decoration:InputDecoration(
                
                fillColor: Colors.blue.shade400,
                filled: true,
                hintText: 'Caption',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none)
              ) ,),),
            Expanded(
              flex: 2,
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
                    var status = await helper.RegisterLogin().addpost(_image, caption);
                    if(status == 200)
                    {
                      print('post done');
                      setState(() {
                        _image = null;
                        caption = '';
                        BotToast.showSimpleNotification(title:'post done');

                        
                      });
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
      
    );
  }
}