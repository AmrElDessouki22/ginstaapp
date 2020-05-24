import 'package:flutter/material.dart';
import 'package:ginsta/UtilsHelper/register_login.dart' as helper;
import 'package:ginsta/Views/Profiles/Friendprofile.dart';
class TypeSearch extends StatefulWidget {
  @override
  _TypeSearchState createState() => _TypeSearchState();
}

class _TypeSearchState extends State<TypeSearch> {
  String search_key;
  bool all = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold
        (
        appBar: AppBar(
          title: TextField(
            onChanged: (key){
              setState(() {
                search_key = key;
                all = false;
                if(key=='')
                {
                  all=true;
                }
              });
            },
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
              filled: true,
              border: InputBorder.none,
              hintText: 'Search',
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Top',
              ),
              Tab(
                text: 'Accounts',
              ),
              Tab(
                text: 'Tags',
              ),
              Tab(
                text: 'Places',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          search(),
          search(),
          search(),
          search()
        ]),


      ),
    );
  }
  Widget search()
  {
    return Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: all == true?helper.RegisterLogin().search('all'):helper.RegisterLogin().search(search_key),
              builder: (context,snp)
            {
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
                  return ListView.builder(
                    itemCount: snp.data.length,
                    itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      child: GestureDetector(
                        onTap: ()
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Friendprofile(snp.data[index]['_id'])));                        
                             },
                          child: Row(
                          children: <Widget>[
                            ClipOval
                            (child: Container(color:Colors.white,width: 50,height: 50,child: Image.network('https://ginsta.herokuapp.com/photo/'+snp.data[index]['_id']),)),
                            SizedBox(width: 10,)
                            ,Text(snp.data[index]['name'],style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                    );
                  });
              }
            },),
          );
  }
}
