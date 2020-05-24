import 'package:flutter/material.dart';

class Storie extends StatefulWidget {
  String user, storie;
  Storie(String user, String storie) {
    this.user = user;
    this.storie = storie;
  }
  @override
  _StorieState createState() => _StorieState();
}

class _StorieState extends State<Storie> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      height: double.infinity, 
      width: double.infinity,
      child: Image.network('https://ginsta.herokuapp.com/storie/'+widget.user+'/'+widget.storie),
      )
    );
  }
}
