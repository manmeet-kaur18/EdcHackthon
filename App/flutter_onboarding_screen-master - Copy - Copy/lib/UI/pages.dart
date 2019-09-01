import 'package:flutter/material.dart';
import 'package:onboarding_slider_screen/mulitiplepages/injections.dart';
import 'package:onboarding_slider_screen/mulitiplepages/geolocation.dart';
import 'package:onboarding_slider_screen/mulitiplepages/doctorsearch.dart';
import 'package:onboarding_slider_screen/mulitiplepages/govtschedule.dart';
import 'package:onboarding_slider_screen/mulitiplepages/aefi.dart';

final pages = [
  new PageViewModel(
      const Color(0xFF548CFF),
      'assets/hospital1.png',
      'Get Hospitals',
      'Get detailes of the stock and availablity of vaccines in nearby hospitals',
      'assets/hospital.png',
      MyAppStart(),
      ),
  new PageViewModel(
      const Color(0xFFE4534D),
      'assets/allergy-shots.png',
      'National Immunization Sch.',
      'Immunization laid by the government',
      'assets/doctoricon.png',
      Appschedule(),
      ),
  new PageViewModel(
    const Color(0xFFFF682D),
    'assets/test.png',
    'Records',
    'Check about the vaccines records',
    'assets/medicineicon.png',
    Appinjection(),
  ),
  new PageViewModel(
    const Color(0xFFE4534D),
    'assets/doctor.png',  
    'Search Doctors',
    'Search doctors in hospitals and book your appointments',
    'assets/doctoricon.png',
    Appdoctor(),
  ),
   new PageViewModel(
    const Color(0xFF548CFF),
    'assets/complain.png',
    'AEFI',
    'Adverse Effects following immunization process',
    'assets/medicineicon.png',
    Appaefi(),
  ),

];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child:
            new Opacity(
              opacity: percentVisible,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          new Transform(
            transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
                padding: new EdgeInsets.only(bottom: 25.0),
                child:
                new Image.asset(
                    viewModel.heroAssetPath,
                    width: 200.0,
                    height: 200.0),
            ),
          ),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
            child: RaisedButton(
              child:new Padding(
                padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Text(
                  viewModel.title,
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'FlamanteRoma',
                    fontSize: 20.0,
                  ),
                ),
            ),
            elevation: 20.0,
                        splashColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(
                              color: Colors.white, width: 3.0),
                        ),
                        color: Colors.white,
            onPressed: (){
               Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => viewModel.path,
                )
                );
                },
            ),
          ),
          new Padding(padding:EdgeInsets.only(top: 50.0) ,),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
                padding: new EdgeInsets.only(bottom: 75.0),
                child: new Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRomaItalic',
                    fontSize: 18.0,
                  ),
                ),
            ),
          ),
        ]),
            ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final dynamic path;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
    this.path,
  );
}


class LoginScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}