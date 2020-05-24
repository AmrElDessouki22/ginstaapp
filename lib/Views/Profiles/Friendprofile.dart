import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginsta/SinglePost/SinglePost.dart';
import 'package:ginsta/Views/Constatnts/constants.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;

class Friendprofile extends StatefulWidget {
  String user;
  Friendprofile(user) {
    this.user = user;
  }
  @override
  _FriendprofileState createState() => _FriendprofileState();
}

class _FriendprofileState extends State<Friendprofile> {
  int posts = 3, followers = 2, following = 1, info = 0;
  int grid_single = 0;
  bool myprofile = false;
  Color edit_follow = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: helper.RegisterLogin().friendprofile(widget.user),
          builder: (context, snp) {
            switch (snp.connectionState) {
              case ConnectionState.none:
                return Container(
                  alignment: Alignment.center,
                  child: Text('loading'),
                );
              case ConnectionState.waiting:
                return Container(
                  alignment: Alignment.center,
                  child: Text('loading'),
                );
              case ConnectionState.active:
                return Container(
                  alignment: Alignment.center,
                  child: Text('loading'),
                );
              case ConnectionState.done:
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ((snp.data[3].length / 3) + 4).toInt(),
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
                                        backgroundImage: NetworkImage(
                                            'https://ginsta.herokuapp.com/photo/' +
                                                widget.user)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        snp.data[posts].length.toString(),
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('posts')
                                    ],
                                  )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        snp.data[followers].toString(),
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Followers')
                                    ],
                                  )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        snp.data[following].toString(),
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Following')
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (index == 1) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            snp.data[info]['name'].toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else if (index == 2) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: edit_follow,
                            ),
                            height: 30,
                            width: double.infinity,
                            child: GestureDetector(
                              child: Center(
                                  child: FutureBuilder(
                                future: helper.RegisterLogin().my_info(),
                                builder: (context, snp) {
                                  switch (snp.connectionState) {
                                    case ConnectionState.none:
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('loading'),
                                      );
                                    case ConnectionState.waiting:
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('loading'),
                                      );
                                    case ConnectionState.active:
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('loading'),
                                      );
                                    case ConnectionState.done:
                                      return FutureBuilder(
                                        future: helper.RegisterLogin().is_my_follow_this(widget.user),
                                        builder: (context,snp_){
                                        switch(snp_.connectionState)
                                        {
                                          
                                          case ConnectionState.none:
                                            return Container(alignment: Alignment.center,child: Text('loading'),);
                                          case ConnectionState.waiting:
                                            return Container(alignment: Alignment.center,child: Text('loading'),);
                                          case ConnectionState.active:
                                            return Container(alignment: Alignment.center,child: Text('loading'),);
                                          case ConnectionState.done:
                                       if (snp.data['_id'] == widget.user) {
                                        myprofile = true;
                                        print(myprofile);
                                        return GestureDetector(onTap: (){print('me');}, child: Text('Edit'));
                                      } else if (snp_.data == true)
                                      {
                                        return GestureDetector(onTap: () async
                                        {
                                          int response = await helper.RegisterLogin().unfollow(widget.user);
                                          print('response'+response.toString());
                                          if(response==200)
                                          {
                                            setState(() {
                                            
                                            });

                                          }
                                          }
                                          , child: Text('UnFollow'));

                                      }else  {
                                        print(myprofile);

                                        return GestureDetector(onTap: () async{
                                          int response = await helper.RegisterLogin().follow(widget.user);
                                          print('response'+response.toString());
                                          if(response==200)
                                          {
                                            setState(() {
                                            
                                            });

                                          }
                                        }, child: Text('Follow'));
                                      };
                                        }
                                      });
                                  }
                                },
                              )),
                            ),
                          ),
                        );
                      } else if (index == 3) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      grid_single = 0;
                                    });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.grid_on),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        height: 4,
                                        child: Container(
                                          color: grid_single == 0
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      grid_single = 1;
                                    });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.check_box_outline_blank),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        height: 4,
                                        child: Container(
                                          color: grid_single == 0
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            child: getposts(index, snp.data[posts]),
                          ),
                        );
                      }
                    });
            }
          },
        ),
      ),
    );
  }

  Widget getposts(index, data) {
    int _hideindex = index - 4 == 0 ? 0 : (index - 4) * 2;
    print('1 : ' + ((index - 4) + _hideindex).toString());
    print('1 : ' + ((index - 4) + _hideindex + 1).toString());
    print('1 : ' + ((index - 4) + _hideindex + 2).toString());

    Widget cont = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(widget.user, data[(index - 4) + _hideindex]['_id']) ));
                },
                child: Image.network('https://ginsta.herokuapp.com/photo/' +
                    data[(index - 4) + _hideindex]['_id'] +
                    '/' +
                    widget.user)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
            child: GestureDetector(
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(widget.user, data[(index - 4) + (_hideindex + 1)]['_id']) ));
                },
                  child: Image.network('https://ginsta.herokuapp.com/photo/' +
                  data[(index - 4) + (_hideindex + 1)]['_id'] +
                  '/' +
                  widget.user),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
            child: GestureDetector(
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePost(widget.user, data[(index - 4) + (_hideindex + 2)]['_id']) ));
                },
                  child: Image.network('https://ginsta.herokuapp.com/photo/' +
                  data[(index - 4) + (_hideindex + 2)]['_id'] +
                  '/' +
                  widget.user),
            ),
          ),
        ),
      ],
    );

    return cont;
  }
}
