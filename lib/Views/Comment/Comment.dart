import 'package:flutter/material.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;

class Comment extends StatefulWidget {
  String user, post;
  Comment({user, post}) {
    this.post = post;
    this.user = user;
  }
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  String _comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments'),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: FutureBuilder(
                  future: helper.RegisterLogin()
                      .get_comment(widget.user, widget.post),
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.none:
                        return Container(
                          alignment: Alignment.center,
                          child: Text('loding'),
                        );
                      case ConnectionState.waiting:
                        return Container(
                          alignment: Alignment.center,
                          child: Text('loding'),
                        );
                      case ConnectionState.active:
                        return Container(
                          alignment: Alignment.center,
                          child: Text('loding'),
                        );
                      case ConnectionState.done:
                        return ListView.builder(
                            itemCount: snap.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                    child: Row(
                                      children: <Widget>[
                                        ClipOval(
                                          child: Container(
                                              color: Colors.black,
                                              width: 40,
                                              height: 40,
                                              child: Image.network(
                                                  'https://ginsta.herokuapp.com/photo/' +
                                                      snap.data[index]['user'])),
                                        ),
                                        SizedBox(width: 10,),
                                        FutureBuilder(
                                            future: helper.RegisterLogin()
                                                .GetUserInfo(
                                                    snap.data[index]['user']),
                                            builder: (context, snp_user) {
                                              switch (snap.connectionState) {
                                                case ConnectionState.none:
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    child: Text('loding'),
                                                  );
                                                case ConnectionState.waiting:
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    child: Text('loding'),
                                                  );
                                                case ConnectionState.active:
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    child: Text('loding'),
                                                  );
                                                case ConnectionState.done:
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        snp_user.data['name'],
                                                        style:
                                                            TextStyle(fontSize: 20),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text(snap.data[index]['comment']),
                                                      SizedBox(width: 10,),
                                                    ],
                                                  );
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              );
                            });
                    }
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 20,
                width: double.infinity,
                child: FutureBuilder(
                    future: helper.RegisterLogin().my_info(),
                    builder: (context, snp) {
                      switch (snp.connectionState) {
                        case ConnectionState.none:
                          return Container(
                            alignment: Alignment.center,
                            child: Text('loding'),
                          );
                        case ConnectionState.waiting:
                          return Container(
                            alignment: Alignment.center,
                            child: Text('loding'),
                          );
                        case ConnectionState.active:
                          return Container(
                            alignment: Alignment.center,
                            child: Text('loding'),
                          );
                        case ConnectionState.done:
                          return Row(
                            children: <Widget>[
                              SizedBox(width: 8,),
                              Expanded(
                                flex: 1,
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.black,
                                    height: 60,
                                    width: 40,
                                    child: Image.network(
                                        'http://192.168.1.8:3000/photo/' +
                                            snp.data['_id']),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  onChanged: (comment){
                                    _comment = comment;
                                  },
                                decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                  ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async
                                  {
                                    int status = await helper.RegisterLogin().add_comment(widget.user, widget.post, _comment);
                                    if(status == 200)
                                    {
                                      setState(() {
                                        
                                      });
                                    }else{
                                      
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('send',style: TextStyle(color: Colors.blue),),
                                  ),
                                ),
                              )
                            ],
                          );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
