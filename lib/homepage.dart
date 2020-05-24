import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ginsta/HomeInsta.dart';
import 'package:ginsta/Signup.dart';
import 'package:http/http.dart' as http;
import 'UtilsHelper/register_login.dart' as helper;
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF1a1d22),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 19),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context,index)
              {
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(tag: 'logo', child: Image.asset('images/logo.png',height: 100,),),
                  SizedBox(height: 60,),
                  Text(
                    'sign in and use more features',
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
                              onChanged: (text)
                              {
                                print(text);
                                password = text;
                              },
                              obscureText: true,
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
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () async{
                      print(password);
                       http.Response response = await helper.RegisterLogin().signin(password, email);
                            if(response.statusCode == 200)
                            {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomeInsta()));

                            }else{
                              BotToast.showSimpleNotification(title:response.body.substring(23));
                            }
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xFFd02b67),),
                      padding: EdgeInsets.symmetric(horizontal: 140,vertical: 10),
                      child: Text('sign in'),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Dont have account ?',
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,),
                        ),
                        RawMaterialButton(
                          onPressed: () 
                          {
                           
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Signup()));

                          },
                          child:Text('Sign up',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)
                          ,
                        )
                      ],
                    ),
                  )
                ],
              );
              },
                
            ),
          ),
        ),
      ),
    );
  }
}
