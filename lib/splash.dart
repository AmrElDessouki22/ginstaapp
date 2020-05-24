import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ginsta/HomeInsta.dart';
import 'UtilsHelper/register_login.dart' as helepr;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}
Future<bool> _checklogin() async
{
  // check user is auth or not if go to home if not go to sign in 
  int status = await helepr.RegisterLogin().checkuser();
  print(status);
  if(status == 200)
  {
    return true;
  }else
  {
  return false;

  }
}
Future<String> prefren() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
}
class _splashState extends State<splash> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  


  @override
  void initState() {
    super.initState();
     

    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1),upperBound: 100.0);
    _controller.forward();
    _controller.addListener((){
          setState(() {
            
          });
    });
    _checklogin().then((state){
         print(state);
      if(state)
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> HomeInsta()));

      }else
      {
        print(state);
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> Homepage()));

      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1d22),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(tag: 'logo', child: Container(child: Image.asset('images/logo.png'),height: _controller.value,width: _controller.value,),),
              SizedBox(height: 20,),
              Text(
                'ginsta',
                style: GoogleFonts.pacifico(
                    textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
