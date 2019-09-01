import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiService  {
  static Future<List<dynamic>>  _get(String url)async{
    try{final response = await http.get(url);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    else{
      return null;
    }}
    catch(ex){
      return null;
    }
  }
 
  static Future<List<dynamic>> gethospitals()async{
    return await _get('http://192.168.43.97:8080/gethospitals');
  }

  static Future<List<dynamic>> childrendetailes()async{
    return await _get('http://192.168.43.97:8080/children');
  }

  static Future<List<dynamic>> getinjectionlist()async{
    return await _get('http://192.168.43.97:8080/getinjectionlist');
  }
  
  static Future<List<dynamic>> getaefi()async{
    return await _get('http://192.168.43.97:8080/getaefi');
  }


  static Future<List<dynamic>> getpersonallist()async{
    return await _get('http://192.168.43.97:80v80/doctorsearch');
  }
  
  static Future<List<dynamic>> getdoctorlist()async{
    return await _get('http://192.168.43.97:8080/doctorsearch');
  }
  static Future<List<dynamic>> getnotificationlist()async{
    return await _get('http://192.168.43.97:8080/getupdates');
  }
  static Future<List<dynamic>> getrecentnotification()async{
    return await _get('http://192.168.43.97:8080/getrecents');
  }
  
  static Future<bool> placeappointment(Map<String,dynamic> appointment) async{
    try{
    final response=await http.post('http://192.168.43.97:8080/placeappointment',body: appointment);
    return response.statusCode ==201;
    }
    catch(e){
      return false;
    }
  }
   static Future<bool> sendclientid(Map<String,dynamic> clientiddetail) async{
    try{
    final response=await http.post('http://192.168.43.97:8080/sendclientid',body: clientiddetail);
    return response.statusCode ==201;
    }
    catch(e){
      return false;
    }
  }

    static Future<bool> registerchild(Map<String,dynamic> child) async{
    try{
    final response=await http.post('http://192.168.43.97:8080/registerchild',body:child);
    return response.statusCode == 201;
    }
    catch(e){
      return false;
    }
  }
}
