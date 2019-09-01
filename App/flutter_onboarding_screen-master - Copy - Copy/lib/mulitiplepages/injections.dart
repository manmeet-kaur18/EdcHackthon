import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';
import 'package:onboarding_slider_screen/main.dart';

class Appinjection extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
        title: 'Flutter demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Updateinjections());
  }
}


class Updateinjections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: new Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                  begin: const FractionalOffset(0.1, 0.0),
                  end: const FractionalOffset(0.0, 1.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: FutureBuilder(
        future: ApiService.getnotificationlist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final medicines = snapshot.data;

            return ListView.builder(
              itemBuilder: (context, index) {
                if (medicines[index]["childid"].contains(clientid)) {
                  return Card(
                    color: Colors.transparent,
                    child:ListTile(
                    title: Text(
                      medicines[index]["injectionname"],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(medicines[index]["day"],style:TextStyle(color:Colors.white)),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Posts(posts[index]['id']),
                      //     ));
                    },
                  ),
                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                  );
                } else
                  return Container(
                      height: 0.0,
                      child: ListTile(
                          title: new Container(
                        height: 0.0,
                      )));
              },
              itemCount: medicines.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
        ]
      )
    );
    
  }
}