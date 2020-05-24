import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginsta/SinglePost/SinglePost.dart';
import 'package:ginsta/Views/Constatnts/constants.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
import 'package:ginsta/photopicprofilepic/ChangeProfilePhoto.dart';

class Myprofile extends StatefulWidget {
  @override
  _MyprofileState createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
   int posts = 3, followers = 2, following = 1, info = 0;
  int grid_single = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: helper.RegisterLogin().myprofile_info(),
            builder: (context,snp)
            {
              switch(snp.connectionState)
              {
                case ConnectionState.none:
                  return Container(alignment: Alignment.center,child: Text('loading'),);
                case ConnectionState.waiting:
                  return Container(alignment: Alignment.center,child: Text('loading'),);
                case ConnectionState.active:
                  return Container(alignment: Alignment.center,child: Text('loading'),);
                case ConnectionState.done:
                  return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  ((snp.data[posts].length/3)+4).toInt(),
          // ignore: missing_return
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(helper.RegisterLogin().url_local+'/photo/'+snp.data[info]['_id']) ,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(snp.data[posts].length.toString(),style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            Text('posts')
                          ],
                        )),
                      ),
                    Expanded(
                      flex: 1,
                      child: Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(snp.data[followers].toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                          Text('Followers')
                        ],
                      )),
                    ),
                      Expanded(
                        flex: 1,
                        child: Center(child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(snp.data[following].toString(),style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            Text('Following')
                          ],
                        )),
                      )


                    ],
                  ),
                ),
              );
            }else if(index == 1)
              {
                return  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(snp.data[info]['name'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                );
              }else if (index==2)
                {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.black,),
                      height: 30,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (contxt)=>ChangeProfilePhoto()));
                        },
                        child: Center(child: Text('Edit Profile')),
                      ),
                    ),
                  );
                }else if(index == 3)
                  {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: ()
                              {
                                setState(() {
                                  grid_single = 0;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.grid_on),
                                  SizedBox(height: 12,),
                                  SizedBox(height:4,child: Container(color: grid_single == 0 ?Colors.white:Theme.of(context).scaffoldBackgroundColor,),)
                                ],

                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: ()
                              {
                                setState(() {
                                  grid_single = 1;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.check_box_outline_blank),
                                  SizedBox(height: 12,),
                                  SizedBox(height:4,child: Container(color:grid_single==0? Theme.of(context).scaffoldBackgroundColor:Colors.white,),)
                                ],

                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }else
                    {
                      return Container(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                          child: getposts(index,snp.data),
                        ),
                      );
                    }
          });
              }
            },
              
      ),
    );
  }

  Widget getposts(index,data)
  {
    int _hideindex= index-4 == 0?0:(index-4) *2;
    print('1 : '+((index-4)+_hideindex).toString());
    print('1 : '+((index-4)+_hideindex+1).toString());
    print('1 : '+((index-4)+_hideindex+2).toString());


    Widget cont = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 4,horizontal: 3),
            child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(data[info]['_id'], data[posts][(index - 4) + _hideindex]['_id']) ));
              } ,
              child: Image.network(helper.RegisterLogin().url_local+'/photo/'+data[posts][(index-4)+_hideindex]['_id']+'/'+data[info]['_id'])),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 4,horizontal: 3),
            child: GestureDetector(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(data[info]['_id'], data[posts][(index-4)+(_hideindex+1)]['_id']) ));

              },
              child: Image.network(helper.RegisterLogin().url_local+'/photo/'+data[posts][(index-4)+(_hideindex+1)]['_id']+'/'+data[info]['_id'])),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 4,horizontal: 3),
            child: GestureDetector(
               onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(data[info]['_id'], data[posts][(index-4)+(_hideindex+2)]['_id']) ));

              },
              child: Image.network(helper.RegisterLogin().url_local+'/photo/'+data[posts][(index-4)+(_hideindex+2)]['_id']+'/'+data[info]['_id'])),
          ),
        ),
      ],
    );


    return cont;
  }
}
