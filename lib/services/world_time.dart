import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location for UI
  String time; //time in that location
  String flag; // url to an asset flag icon
  String url; //location url for api end point
  bool isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    //simulate network request for a username
    /*Future.delayed(Duration(seconds: 3), () {
      print('ashish');
    });

    //simulate a network request to get bio
    Future.delayed(Duration(seconds: 3), () {
      print('Coder');
    });

    print('statemnet');*/
    //Asia/Kolkata
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);


      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      String min = data['utc_offset'].substring(4, 6);
      /*print(offset);
      print(min);*/
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(min)));
      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('cought error: $e');
      time = 'could not get data';
    }
  }
}