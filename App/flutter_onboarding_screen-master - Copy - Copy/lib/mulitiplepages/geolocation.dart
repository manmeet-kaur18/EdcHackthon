import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';
import 'package:async_loader/async_loader.dart';

class MyAppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
      // routes: {
      //   '/second': (context) => Ambulance(),
      // },
    );
  }
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  TextEditingController usernameController = new TextEditingController();
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: new Center(
      child: new SingleChildScrollView(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            height: 200.0,
            width: 100.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/doctor1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Container(
            height: 50.0,
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: 'Enter the vaccine name',
            ),
          ),
          Container(
            height: 30.0,
          ),
          SizedBox(
              height: 40,
              width: double.infinity,
              child: new RaisedButton(
                color: Colors.pink[500],
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              googlemapscreated(usernameController.text)));
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              )),
        ],
      )),
    )));
  }
}

class googlemapscreated extends StatefulWidget {
  final injectionname;
  googlemapscreated(this.injectionname);
  @override
  _googlemapscreatedState createState() =>
      _googlemapscreatedState(injectionname);
}

class _googlemapscreatedState extends State<googlemapscreated> {
  List<Marker> allMarkers = [];
  final injectionname;
  _googlemapscreatedState(this.injectionname);

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  // void initState() {
  // super.initState();
  // _asyncMethod();

  // }
  _getmessage() async {
    await ApiService.gethospitals().then((result) {
      final details = result;
      var index;
      for (index = 0; index < details.length; index++) {
        if (details[index]["injectionname"] == injectionname) {
          var i;
          allMarkers.add(Marker(
            markerId: MarkerId(details[index]['hospitalname']),
            draggable: false,
            // onTap: () {
            //   _buildContainer(details[index]['stock'],details[index]['hospitalname'],context);
            // },
            infoWindow: InfoWindow(
                title: details[index]['hospitalname'],
                onTap: () => {
                     
                    }),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
            position: LatLng(double.parse(details[index]['latitude']),
                double.parse(details[index]['longitude'])),
          ));
          print(allMarkers);
        }
      }
      return allMarkers;
    });
  }

  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await _getmessage(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) =>
          new Text('Sorry, there was an error loading your page'),
      renderSuccess: ({data}) => new MyHomePage(allMarkers),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(timetoreach, latitudehosp, longitudehosp),
      home: new Center(child: _asyncLoader),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Marker> allMarkers = [];
  MyHomePage(this.allMarkers);
  // @override
  _MyHomePageState createState() => _MyHomePageState(allMarkers);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Marker> allMarkers = [];

  _MyHomePageState(this.allMarkers);
  void initState() {
    super.initState();
    print(allMarkers);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Stack(
        children: <Widget>[
          _googlemaps(context),
        ],
      ),
    );
  }

  Widget _googlemaps(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(30.3343646, 76.3709103), zoom: 10.0),
        markers: Set.from(allMarkers),
      ),
    );
  }
}

//  Widget _buildContainer(String stock,String hospitalname,BuildContext context) {
//     return Align(
//         alignment: Alignment.bottomLeft,
//         child: Container(
//             margin: EdgeInsets.symmetric(vertical: 20.0),
//             height: 250.0,
//             child: ListView(
//               // scrollDirection:Axis.horizontal,
//               children: <Widget>[
//                 SizedBox(width: 150.0),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: _boxes(
//                       "https://cdn.dribbble.com/users/1481285/screenshots/6084001/___.gif",hospitalname,
//                       stock,context),
//                 )
//               ],
//             )));
//   }

// Widget _boxes(String _gif, String hospitalname,String stock,BuildContext context){
//   return GestureDetector(
//     child: Container(
//       child: Material(
//           color: Colors.white,
//           elevation: 14.0,
//           borderRadius: BorderRadius.circular(24.0),
//           shadowColor: Color(0x802196F3),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 height: 180,
//                 width: 200,
//                 child: ClipRRect(
//                   borderRadius: new BorderRadius.circular(24.0),
//                   child: Image(
//                     fit: BoxFit.fill,
//                     image: NetworkImage(_gif),
//                   ),
//                 ),
//               ),
//               Container(
//                   child: Padding(
//                 padding: const EdgeInsets.only(right: 30.0),
//                 child: mydetailedContainer(hospitalname,context)
//               )),
//             ],
//           )),
//     ),
//   );
// }

// Widget mydetailedContainer(String hospitalname,BuildContext context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: <Widget>[
//       Padding(
//           padding: const EdgeInsets.only(left: 1.0),
//           child: Container(
//             child: Text('Ambulance',
//                 style: TextStyle(
//                     color: Color(0xff6200ee),
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold)),
//           )),
//       Padding(
//           padding: const EdgeInsets.only(left: 1.0),
//           child: Container(
//             child: Text('arrives in:',
//                 style: TextStyle(
//                     color: Color(0xff6200ee),
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold)),
//           )),
//       Padding(
//           padding: const EdgeInsets.only(left: 1.0),
//           child: Container(
//             child: Text(hospitalname,
//                 style: TextStyle(
//                     color: Color(0xff6200ee),
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold)),
//           )),
//        SizedBox(
//                       height: 40,
//                       width: double.infinity,
//                       child: new RaisedButton(
//                         color: Colors.pink[500],
//                         child: Text(
//                           'Place Appointment',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: ()  {
//                            Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>   Listdoctor(hospitalname),
//                                   ));
//                         },
//                         shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(30.0)),
//                       )),
//     ],
//   );

// }

// class Listdoctor extends StatelessWidget {
//   String hospitalname;

//   Listdoctor(this.hospitalname);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: new Stack(
//         children: <Widget>[
//           Container(
//             decoration: new BoxDecoration(
//               gradient: new LinearGradient(
//                   colors: [Colors.pink, Colors.pinkAccent],
//                   begin: const FractionalOffset(0.1, 0.0),
//                   end: const FractionalOffset(0.0, 1.5),
//                   stops: [0.0, 1.0],
//                   tileMode: TileMode.clamp),
//             ),
//             child: FutureBuilder(
//               future: ApiService.getdoctorlist(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   final medicines = snapshot.data;

//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       if (medicines[index]["hospitalname"]
//                           .contains(hospitalname)) {
//                         return Card(
//                           color: Colors.transparent,
//                           child: new ListTile(
//                             title: Text(
//                               medicines[index]["doctorname"],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             trailing: Text(
//                               medicines[index]["hospitalname"],
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             subtitle: Text(
//                               medicines[index]["doctordescription"],
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Doctorappointment(
//                                         medicines[index]['idno'],
//                                         medicines[index]['doctorname']),
//                                   ));
//                             },
//                           ),
//                         );
//                       } else
//                         return Container(
//                           height: 0.0,
//                           child: ListTile(
//                               title: new Container(
//                             height: 0.0,
//                           )),
//                         );
//                     },
//                     itemCount: medicines.length,
//                   );
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Doctorappointment extends StatefulWidget {
//   final String idno;
//   final String doctorname;
//   Doctorappointment(this.idno, this.doctorname);
//   @override
//   _DoctorAppointmentState createState() =>
//       _DoctorAppointmentState(idno, doctorname);
// }

// class _DoctorAppointmentState extends State<Doctorappointment> {
//   String idno;
//   String doctorname;

//   _DoctorAppointmentState(this.idno, this.doctorname);
//   TextEditingController _childname = new TextEditingController();
//   TextEditingController _patienttimeslot = new TextEditingController();
//   TextEditingController _patientcontactnumber = new TextEditingController();
//   TextEditingController _patientemail = new TextEditingController();
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Place an Appointment'),
//         backgroundColor: Colors.pink[500],
//       ),
//       body: new Center(
//           child: new SingleChildScrollView(
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter name of your child',
//               ),
//               controller: _childname,
//             ),
//             TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter timeslot of doctor',
//                 ),
//                 controller: _patienttimeslot),
//             TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter contact no. of parent',
//                 ),
//                 controller: _patientcontactnumber),
//             TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter email id. of the parent',
//                 ),
//                 controller: _patientemail),
//             new Padding(
//               padding: EdgeInsets.only(top: 50.0),
//             ),
//             new SizedBox(
//               width: 300.0,
//               height: 40.0,
//               child: RaisedButton(
//                 color: Colors.pink[500],
//                 child: Text(
//                   'Submit',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 elevation: 20.0,
//                 splashColor: Colors.pinkAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40.0),
//                   side: BorderSide(color: Colors.pink[800], width: 3.0),
//                 ),
//                 onPressed: () {
//                   if (_childname.text.isEmpty || _patientemail.text.isEmpty) {
//                     showDialog(
//                         builder: (context) => AlertDialog(
//                               title: Text('Failure !'),
//                               content: Text(
//                                   'Please enter patient name and the email of the patient'),
//                               actions: <Widget>[
//                                 FlatButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('OK'),
//                                 )
//                               ],
//                             ),
//                         context: context);
//                     return;
//                   }
//                   final appointment = {
//                     'doctorname': doctorname,
//                     'idno': idno,
//                     'childname': _childname.text,
//                     'timeslot': _patienttimeslot.text,
//                     'contactno': _patientcontactnumber.text,
//                     'patientemail': _patientemail.text,
//                   };
//                   ApiService.placeappointment(appointment).then((success) {
//                     String title, text;
//                     if (success) {
//                       title = "Success";
//                       text =
//                           "Your appointment has been successfully placed for further details check your email";
//                     } else {
//                       title = "Error";
//                       text = "Please try again !";
//                     }
//                     showDialog(
//                         builder: (context) => AlertDialog(
//                               title: Text(title),
//                               content: Text(text),
//                               actions: <Widget>[
//                                 FlatButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text('OK'))
//                               ],
//                             ),
//                         context: context);
//                   });
//                 },
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
