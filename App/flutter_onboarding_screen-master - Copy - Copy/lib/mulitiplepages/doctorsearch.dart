import 'package:flutter/material.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';

class Appdoctor extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
        title: 'Flutter demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Login());
  }
}

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isloading = false;
  TextEditingController usernameController = new TextEditingController();

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search doctors'),
          backgroundColor: Colors.pink[500],
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: new Center(
              child: new SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    height: 200.0,
                    width: 100.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image:
                            new AssetImage('assets/doctor1.png'),
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
                      hintText: 'Search by hospitals',
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
                        onPressed: () async {
                          setState(() {
                            _isloading = true;
                          });
                          final medicines = await ApiService.getdoctorlist();
                          setState(() {
                            _isloading = false;
                          });
                          if (medicines == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Check your internet connection'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                            return;
                          } else {
                            final userwithUsernameExists = medicines.any((u) =>
                                u['hospitalname'] ==
                                usernameController.text);
                            if (userwithUsernameExists) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Listdoctor(
                                          usernameController.text)));
                            } else {}
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      )),
                ],
              )),
            )));
  }
}

class Listdoctor extends StatelessWidget {
  String speciality;

  Listdoctor(this.speciality);

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
              future: ApiService.getdoctorlist(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final medicines = snapshot.data;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if (medicines[index]["hospitalname"]
                          .contains(speciality)) {
                        return Card(
                          color: Colors.transparent,
                          child: new ListTile(
                            title: Text(
                              medicines[index]["doctorname"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              medicines[index]["doctorspeciality"],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              medicines[index]["doctordescription"],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Doctorappointment(
                                        medicines[index]['idno'],
                                        medicines[index]['doctorname']),
                                  ));
                            },
                          ),
                          
                        );
                      } else
                        return Container(
                          height: 0.0,
                          child: ListTile(
                              title: new Container(
                            height: 0.0,
                          )),
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
class Doctorappointment extends StatefulWidget {
  final String idno;
  final String doctorname;
  Doctorappointment(this.idno, this.doctorname);
  @override
  _DoctorAppointmentState createState() =>
      _DoctorAppointmentState(idno, doctorname);
}

class _DoctorAppointmentState extends State<Doctorappointment> {
  String idno;
  String doctorname;

  _DoctorAppointmentState(this.idno, this.doctorname);
  TextEditingController _childname = new TextEditingController();
  TextEditingController _patienttimeslot = new TextEditingController();
  TextEditingController _patientcontactnumber = new TextEditingController();
  TextEditingController _patientemail = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place an Appointment'),
        backgroundColor: Colors.pink[500],
      ),
      body: new Center(
          child: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter name of your child',
              ),
              controller: _childname,
            ),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter timeslot of doctor',
                ),
                controller: _patienttimeslot),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter contact no. of parent',
                ),
                controller: _patientcontactnumber),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter email id. of the parent',
                ),
                controller: _patientemail),
            new Padding(
              padding: EdgeInsets.only(top: 50.0),
            ),
            new SizedBox(
              width: 300.0,
              height: 40.0,
              child: RaisedButton(
                color: Colors.pink[500],
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 20.0,
                splashColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(color: Colors.pink[800], width: 3.0),
                ),
                onPressed: () {
                  if (_childname.text.isEmpty || _patientemail.text.isEmpty) {
                    showDialog(
                        builder: (context) => AlertDialog(
                              title: Text('Failure !'),
                              content: Text(
                                  'Please enter patient name and the email of the patient'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                )
                              ],
                            ),
                        context: context);
                    return;
                  }
                  final appointment = {
                    'doctorname': doctorname,
                    'idno': idno,
                    'childname': _childname.text,
                    'timeslot': _patienttimeslot.text,
                    'contactno': _patientcontactnumber.text,
                    'patientemail': _patientemail.text,
                  };
                  ApiService.placeappointment(appointment).then((success) {
                    String title, text;
                    if (success) {
                      title = "Success";
                      text =
                          "Your appointment has been successfully placed for further details check your email";
                    } else {
                      title = "Error";
                      text = "Please try again !";
                    }
                    showDialog(
                        builder: (context) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'))
                              ],
                            ),
                        context: context);
                  });
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
