
import 'package:flutter/material.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';
class Appaefi extends StatelessWidget {

  Widget build(context) {
    return MaterialApp(
        title: 'Flutter demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Listaefi());
  }
}

class Listaefi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.pink, Colors.pinkAccent],
                  begin: const FractionalOffset(0.1, 0.0),
                  end: const FractionalOffset(0.0, 1.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: FutureBuilder(
              future: ApiService.getaefi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final medicines = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (context,index) {
                      return ExpansionTile(
                        title:Text(medicines[index]["injectionname"],style:TextStyle(color:Colors.white,fontSize: 21.0,fontWeight:FontWeight.bold)),
                        children: <Widget>[
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                             Container(
                            child:Text("Reaction Probablity: "+medicines[index]['reactprob']+" %",style:TextStyle(color:Colors.white,fontSize: 16.0))
                          ),
                          Padding(
                            padding:EdgeInsets.only(bottom: 10.0)
                          ),
                          Container(
                            child:Text("Fever Probablity: "+medicines[index]['feverprob']+" %",style:TextStyle(color:Colors.white,fontSize: 16.0))
                          ),
                          Padding(
                            padding:EdgeInsets.only(bottom: 10.0)
                          ),
                          Container(
                            child:Text("Irritability : "+medicines[index]['iritability']+" %",style:TextStyle(color:Colors.white,fontSize: 16.0))
                          ),
                          Padding(
                            padding:EdgeInsets.only(bottom: 10.0)
                          ),
                          Container(
                            child:Text("Reaction : "+medicines[index]['reaction'],style:TextStyle(color:Colors.white,fontSize: 16.0))
                          )
                         
                          ],),)
                         
                        ],
                      );
                    },
                    itemCount: medicines.length,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}