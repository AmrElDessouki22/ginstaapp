import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginsta/Views/Homepage/HomeView.dart';
import 'package:ginsta/Views/Constatnts/constants.dart';
import 'package:ginsta/Views/NotifcationView/notifcation.dart';
import 'package:ginsta/Views/TybeSearch/TybeSearch.dart';
import 'package:ginsta/UtilsHelper/register_login.dart'as helper;
import 'package:ginsta/homepage.dart';
import 'package:ginsta/photoPicker/photopicker.dart';
import 'package:ginsta/photoPicker_storie/photoPicker_storie.dart';


import 'Views/Profiles/Myprofile.dart';

class HomeInsta extends StatefulWidget {
  @override
  _HomeInstaState createState() => _HomeInstaState();
}

class _HomeInstaState extends State<HomeInsta> {
  int _index = 0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> photopickerStorie()));
        }, child: Icon(Icons.camera_alt,color : Colors.white)),
        title: Text('ginsta'),
        actions: <Widget>[
          GestureDetector(
            onTap: () async{
              int response = await helper.RegisterLogin().logout();
              if(response == 200)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
              }
            },
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text('Log out')),
            ),
          )
        ],
      ),
      body:   _Getviews(),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _index,

          unselectedItemColor: Colors.white,
          onTap: (index){
            setState(() {
              _index = index;
            });
          },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: ClipOval(
                child: Container(
                    height: 20,
                    width: 20,
                    color: Colors.white,
                    child: FutureBuilder(
                      future:helper.RegisterLogin().my_info() ,
                      builder: (context,snp){
                      switch(snp.connectionState)
                      {
                        
                        case ConnectionState.none:
                         return Container(alignment: Alignment.center,child: Text('loading'),);
                        case ConnectionState.waiting:
                          return Container(alignment: Alignment.center,child: Text('loading'),);
                        case ConnectionState.active:
                          return Container(alignment: Alignment.center,child: Text('loading'),);
                        case ConnectionState.done:
                          return Image.network('https://ginsta.herokuapp.com/photo/'+snp.data['_id']); 
                      }
                    }))),
            title: Text(''),
          ),
        ],
    ),


    );
  }

  Widget _Getviews()
  {
    if(_index == 0)
      {
       return HomeView(icon: iconststories, name: nameststories, context: context,);
      }else if (_index ==1)
      {
        return TypeSearch();
      }
      else if (_index == 2)
      {
        return photopicker(_index);
      }
      else if (_index ==3)
      {
        return Notifcation();
      }else if (_index ==4)
        {
          return Myprofile();
        }
  }


}

