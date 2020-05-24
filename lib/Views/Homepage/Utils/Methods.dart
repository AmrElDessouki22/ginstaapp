import 'package:flutter/material.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
import 'package:ginsta/Views/Comment/Comment.dart';
import 'package:ginsta/Views/Homepage/Storie.dart';
import 'package:ginsta/Views/Profiles/Friendprofile.dart';

class methods {
  List tex2tt = [
    'asdad',
    'asdad',
    'asdad',
    'asdad',
    'asdad',
    'asdad',
    'asdad',
    'atttttttsdad',
    'asdad'
  ];
  BuildContext context;
  List iconststories;
  List nameststories;
  methods({this.context, this.iconststories, this.nameststories});

  Widget stories(context) {
    return Container(
      height: 130,
      width: double.infinity,
      child: Container(
        child: FutureBuilder(
            future: helper.RegisterLogin().get_stories(),
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
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snp.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Storie(
                                            snp.data[index]['user'],
                                            snp.data[index]['stories']
                                                ['_id'])));
                              },
                              child: ClipOval(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                        'https://ginsta.herokuapp.com/photo/' +
                                            snp.data[index]['user']),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 60,
                                alignment: Alignment.center,
                                child: FutureBuilder(
                                  future: helper.RegisterLogin()
                                      .GetUserInfo(snp.data[index]['user']),
                                  builder: (context, snp_) {
                                    switch (snp.connectionState) {
                                      case ConnectionState.none:
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Text('..'),
                                        );
                                      case ConnectionState.waiting:
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Text('..'),
                                        );
                                      case ConnectionState.active:
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Text('..'),
                                        );
                                      case ConnectionState.done:
                                        return Text(snp_.data['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis);
                                    }
                                  },
                                ))
                          ],
                        );
                      });
              }
            }),
      ),
    );
  }

  Future<List<Widget>> postes() async {
    List<Widget> texts = [];
    var result_home_request = await helper.RegisterLogin().Home();
    for (int i = 0; i < result_home_request.length; i++) {
      texts.add(cardginsta(i, result_home_request));
    }
    return texts;
  }

  Widget cardginsta(int i, List home) {
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
                            height: 40,
                            child: Image.network(
                                'https://ginsta.herokuapp.com/photo/' +
                                    home[i]['user'])),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FutureBuilder(
                            future: helper.RegisterLogin()
                                .GetUserInfo(home[i]['user']),
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
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Friendprofile(
                                                        snp.data['_id'])));
                                      },
                                      child: Text(
                                        snp.data['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ));
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
                child: Image.network('https://ginsta.herokuapp.com/photo/' +
                    home[i]['posts_']['_id'] +
                    '/' +
                    home[i]['user'])),
            Container(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                    future: helper.RegisterLogin().GetUserInfo(home[i]['user']),
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
                          return Padding(
                            padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 7),
                            child: Text(
                              snp.data['name'] +
                                  '  ' +
                                  home[i]['posts_']['caption'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                          break;
                      }
                    })),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Likedd(home, i),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Comment(
                                        user: home[i]['user'],
                                        post: home[i]['posts_']['_id'],
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.comment,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: 35,
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                child:
                    Text(home[i]['posts_']['like'].length.toString() + ' Like'))
          ],
        ),
      ),
    );
  }
}

class Likedd extends StatefulWidget {
  List home;
  int i;
  bool liekd;
  Likedd(List home, int i) {
    this.home = home;
    this.i = i;
    liekd = home[i]['liked'];
  }
  @override
  _LikeddState createState() => _LikeddState();
}

class _LikeddState extends State<Likedd> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.liekd == false) {
          int status = await helper.RegisterLogin().Like(
              widget.home[widget.i]['user'],
              widget.home[widget.i]['posts_']['_id']);
          if (status == 200) {
            setState(() {
              widget.liekd = true;
            });
          }
        } else {
          int status = await helper.RegisterLogin().unLike(
              widget.home[widget.i]['user'],
              widget.home[widget.i]['posts_']['_id']);
          if (status == 200) {
            setState(() {
              widget.liekd = false;
            });
          }
        }
      },
      child: Icon(
        widget.liekd == false ? Icons.favorite_border : Icons.favorite,
        size: 25,
      ),
    );
  }
}
