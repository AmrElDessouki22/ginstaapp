import 'package:flutter/material.dart';
import 'package:ginsta/Views/Homepage//Utils/Methods.dart' as methods;
class HomeView extends StatefulWidget {
  List icon;
  List name;
  BuildContext context;
  HomeView({this.icon,this.name,this.context});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
            itemCount: 2,
            // ignore: missing_return
            itemBuilder: (context,index)
            {
              if(index == 0)
              {
                return methods.methods(context: context,iconststories:widget.icon,nameststories:widget.name).stories(context);

              }else if (index ==1){
                return FutureBuilder(
                  future:methods.methods(context: context,iconststories:widget.icon,nameststories:widget.name).postes() ,
                  builder: (context, AsyncSnapshot snp)
                {
                  switch(snp.connectionState)
                  {
                    
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
                      return Column(
                     children:  snp.data,
                      );
                     
                  }
                   

                });
                
               
              }
            }),
      ),
    );
  }
  

}
