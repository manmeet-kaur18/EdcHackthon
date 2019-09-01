import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onboarding_slider_screen/Animation_Gesture/page_dragger.dart';
import 'package:onboarding_slider_screen/Animation_Gesture/page_reveal.dart';
import 'package:onboarding_slider_screen/UI/pager_indicator.dart';
import 'package:onboarding_slider_screen/UI/pages.dart';
import 'package:onboarding_slider_screen/services/apiservice.dart';

void main() => runApp(new LogoReveal());

String clientid;

class LogoReveal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:new Scaffold(
        body:new Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           new Container(
                    height: 150.0,
                    width: 100.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image:
                            new AssetImage('assets/injection.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                   Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: new RaisedButton(
                        color: Colors.blue[500],
                        child: Text(
                          'Im-pro',
                          style: TextStyle(color: Colors.white),
                          
                        ),
                        onPressed:(){
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Main()));
                        },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        )),


        ],),
      )
    ));
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Login(),
    );
  }
}
class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isloading = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController usernameControllerpassword =
      new TextEditingController();
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
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
                    height: 150.0,
                    width: 100.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image:
                            new AssetImage('assets/doctor1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Enter the children name',
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  TextField(
                    controller: usernameControllerpassword,
                    decoration: InputDecoration(
                      hintText: 'Enter the password',
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: new RaisedButton(
                        color: Colors.pink[500],
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isloading = true;
                          });
                          final medicines = await ApiService.childrendetailes();
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
                          } 
                          else {
                            final userwithUsernameExists = medicines.any((u) =>
                                (u['childname'] == usernameController.text) &&
                                (u['password'] ==   usernameControllerpassword.text));
                            
                            if (userwithUsernameExists) {
                              final childname=usernameController.text;
                              final childsid = await ApiService.childrendetailes();
                              if(childsid != null){

                              var i;
                               for(i=0;i<childsid.length;i++){
                                  if(childname==childsid[i]["childname"])
                                  {
                                    clientid = childsid[i]["childid"]; 
                                  }
                                }
                              }
                              final clientiddetail = {
                    'clientid':clientid,
                  };
                  ApiService.sendclientid(clientiddetail).then((success) {
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BeginPage1()));
                            } 
                            // else {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => MyRegister()));
                            // }
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: new RaisedButton(
                        color: Colors.pink[500],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                          
                        ),
                        onPressed:(){
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyRegister()));
                        },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        )),

                ],
              )),
            )));
  }
}

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController _childname = new TextEditingController();
  TextEditingController _birthdate = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _emailid = new TextEditingController();
  TextEditingController _phoneno = new TextEditingController();
  TextEditingController _parentname = new TextEditingController();
void initState(){
  super.initState();
  
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  hintText: 'enter birthdate',
                ),
                controller: _birthdate),
           
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter parent name',
                ),
                controller: _parentname),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter contact no. of parent',
                ),
                controller: _phoneno),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter email id. of the parent',
                ),
                controller: _emailid),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Enter age of child',
                ),
                controller: _age),
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
                  if (_childname.text.isEmpty || _emailid.text.isEmpty) {
                    showDialog(
                        builder: (context) => AlertDialog(
                              title: Text('Failure !'),
                              content: Text(
                                  'Please enter child name and the email of the parent'),
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
                  final child = {
                    'childname': _childname.text,
                    'age': _age.text,
                    'parentname': _parentname.text,
                    'birthdate': _birthdate.text,
                    'emailid': _emailid.text,
                    'contactno': _phoneno.text
                  };
                  ApiService.registerchild(child).then((success) {
                    String title, text;
                    if (success) {
                      title = "Success";
                      text =
                          "Your appointment has been successfully placed for further details check your email";

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BeginPage(_parentname.text)));
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
class BeginPage1 extends StatefulWidget {
  @override
  _BeginPageState createState() => _BeginPageState();
}

class _BeginPageState extends State<BeginPage1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("Hey",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 30.0))),
            Padding(padding: EdgeInsets.only(top:10.0),),
            Container(
            child: Text("Wecome back!!",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 25.0))),
Padding(padding: EdgeInsets.only(top:20.0),),
          Container(child: Text('Our Assistant is there for helping you')),
          Padding(padding: EdgeInsets.only(top:30.0),),
          SizedBox(
              width: 200.0,
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
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));

                  })),
                  
      //             FutureBuilder(
      //             future: ApiService.getrecentnotification(),
      //             builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //             final medicines = snapshot.data;

      //             return ListView.builder(
      //             itemBuilder: (context, index) {
      //                 return Card(
      //                 color: Colors.transparent,
      //                 child:ListTile(
      //                 title: Text(
      //                 medicines[index]["injectionname"],
      //                 style: TextStyle(
      //                     color: Colors.white, fontWeight: FontWeight.bold),
      //               ),
      //               subtitle: Text(medicines[index]["day"],style:TextStyle(color:Colors.white)),
      //               onTap: () {
      //                 // Navigator.push(
      //                 //     context,
      //                 //     MaterialPageRoute(
      //                 //       builder: (context) => Posts(posts[index]['id']),
      //                 //     ));
      //               },
      //             ),
      //             shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(25.0),
      //                     ),
      //             );
                
      //         },
      //         itemCount: medicines.length,
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
        ],
      ),
    ))
    );
  }
  }






class BeginPage extends StatelessWidget {
  String parentname;
  BeginPage(this.parentname);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body:Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("Hey " + parentname,style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 30.0)),
          ),
          Container(child: Text('Our Assistant is their for helping you')),
          SizedBox(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));

                  }))
        ],
      ),
    )));
  }
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Material Page Reveal',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  int nextPageIndex = 0;
  double slidePercent = 0.0;

  _MyHomePageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          new Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}




