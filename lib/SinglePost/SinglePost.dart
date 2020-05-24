import 'package:flutter/material.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
import 'package:ginsta/Views/Comment/Comment.dart';
import 'package:ginsta/Views/Homepage/Utils/Methods.dart';

class SinglePost extends StatefulWidget {
  String user,post;
  SinglePost(user,post)
  {
    this.user=user;
    this.post=post;
  }
  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool liked_key ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ussser : '+widget.user);
    print(widget.post);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: FutureBuilder(
          future: helper.RegisterLogin().get_single_post(widget.post,widget.user),
          builder: (context,home)
        {
          switch(home.connectionState)
          {
            
            case ConnectionState.none:
                return Container(alignment: Alignment.center,child: Text('loading'),);
            case ConnectionState.waiting:
                return Container(alignment: Alignment.center,child: Text('loading'),);
            case ConnectionState.active:
                return Container(alignment: Alignment.center,child: Text('loading'),);
            case ConnectionState.done:
            liked_key = home.data['object']['liked'];
                return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  width: 220,
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                            color: Colors.white,
                            width: 40,
                            height:40,
                            child: Image.network('https://ginsta.herokuapp.com/'+widget.user)),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5),
                        child: FutureBuilder(
                          future:  helper.RegisterLogin().GetUserInfo(widget.user) ,
                          builder: (context , snp){
                          switch (snp.connectionState) {
                            
                            case ConnectionState.none:
                              return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.waiting:
                              return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.active:
                              return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.done:
                              return Text(snp.data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,);
                              break;
                          }
                        }),
                      )
                    ],
                  ),
                ),
                Icon(Icons.more_vert)
              ],
            ),
            Container(
              width: 320,
              height: 400,
              child: Image.network('https://ginsta.herokuapp.com/photo/'+widget.post+'/'+widget.user)),
            Container(
                alignment: Alignment.topLeft ,
                child:FutureBuilder(
                          future: helper.RegisterLogin().GetUserInfo(widget.user) ,
                          builder: (context , snp){
                          switch (snp.connectionState) {
                            
                            case ConnectionState.none:
                              return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.waiting:
                             return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.active:
                             return Container(
                                alignment: Alignment.center,
                                child: Text('loding'),);
                            case ConnectionState.done:
                              return Text(snp.data['name']+'  '+home.data['object']['caption'],maxLines: 1,overflow: TextOverflow.ellipsis,);
                              break;
                          }
                        })),
                
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Likedd(home.data,widget.user,widget.post),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Comment(user: widget.user,post: widget.post,)));
                        },
                          child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(Icons.comment,size: 25,),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.bookmark_border,size: 35,)


                ],
              ),
            ),
            Container(
                alignment: Alignment.topLeft ,
                child: Text(home.data['object']['like'].length.toString()+' Like'))
          ],
        ),
      ),
    );
          }

        }),
              ),
      ),
      
    );
  }
}
class Likedd extends StatefulWidget {
 Map home;
 String user,post;
 bool liekd;
  Likedd(Map home,user,post){
    this.home=home;
    this.user=user;
    this.post=post;
    liekd = home['liked'];
  }
  @override
  _LikeddState createState() => _LikeddState();
}

class _LikeddState extends State<Likedd> {
  @override
  Widget build(BuildContext context) { 
    return  GestureDetector( 
              onTap: () async {
                if(widget.liekd == false)
                {
                  int status = await helper.RegisterLogin().Like(widget.user, widget.post);
                if(status == 200)
                {
                  setState(() {
                    widget.liekd = true;
                  });
                }  
                }else
                {
                  int status = await helper.RegisterLogin().unLike(widget.user, widget.post);
                if(status == 200)
                {
                  setState(() {
                    widget.liekd = false;
                  });
                } 
                } 
               },
              child: Icon(widget.liekd==false?Icons.favorite_border:Icons.favorite,size: 25,),
  );

  }
}