import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UtilsHelper/register_login.dart' as helper;
import 'package:bot_toast/bot_toast.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    String name ,phone,password,email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF1a1d22),
      ),
      backgroundColor:  Color(0xFF1a1d22),
      body: ListView.builder(
            itemCount: 1,
              itemBuilder: (context,index)
              {
                if(index == 0)
                {
                  return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(tag: 'logo', child: Image.asset('images/logo.png',height: 70,),),
                  SizedBox(height: 60,),
                  Text(
                    'sign up and use more features',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      children: <Widget>[
                        
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Container(
                          
                            height: 45,
                            child: TextField(
                              onChanged: (text)
                              {
                                email = text;
                                
                              },
                              decoration: InputDecoration(
                              
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                                fillColor: Color(0xFF404448),
                                hintText: 'Email',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Container(
                            height: 45,
                            child: TextField(
                              obscureText: true,
                              onChanged: (text)
                              {
                                password = text;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                                fillColor: Color(0xFF404448),
                                hintText: 'password',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Container(

                            height: 45,
                            child: TextField(
                              onChanged: (text)
                              {
                                name = text.toLowerCase();
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                                fillColor: Color(0xFF404448),
                              
                                hintText: 'Name',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Container(

                            height: 45,
                            child: TextField(
                              onChanged: (text)
                              {
                                phone = text;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                                fillColor: Color(0xFF404448),
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                Column(
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: ()async {
                      if(name == null || name == ' '|| name =='')
                    {
                    BotToast.showSimpleNotification(title:'name cant be empty');

                    }else{
                      print(email);
                    http.Response response = await helper.RegisterLogin().signup(email,name,password,phone);
                    
                    if(response.statusCode == 200)
                    {
                    Navigator.of(context).pop();
                    }else if (response.statusCode !=200){
                     
                       BotToast.showSimpleNotification(title:response.body.substring(23));
                    
                    }
                    }
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xFFd02b67),),
                      padding: EdgeInsets.symmetric(horizontal: 140,vertical: 10),
                      child: Text('sign up'),
                    ),
                  ),
                ],
              )
                ],
              ),
            ); 
                }
              },
                  
          ),
         
        

    );
  }
}
