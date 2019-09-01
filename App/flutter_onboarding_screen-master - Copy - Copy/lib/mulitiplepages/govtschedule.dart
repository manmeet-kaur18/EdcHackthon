import 'package:flutter/material.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';

class Appschedule extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
        title: 'Flutter demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Listimmunization());
  }
}

class Listimmunization extends StatelessWidget {
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
        future: ApiService.getinjectionlist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final medicines = snapshot.data;

            return ListView.builder(
              itemBuilder: (context, index) {
              
                  return Card(
                    color: Colors.transparent,
                    child:ListTile(
                    title: Text(
                      "Injection name: "+medicines[index]["injectionname"],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(medicines[index]["des"],style:TextStyle(color:Colors.white)),
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

class PictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(
      new AssetImage('android/assets/images/medicine.png'),
      size: 80.2,
    );
  }
}
