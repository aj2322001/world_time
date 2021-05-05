import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location,time,flag,url; //LocationNameForUI,timeInLocation,flagOfLocation,URLofLocation
  String isDayTime;
  // Asia/Kolkata

  WorldTime({this.location,this.url,this.flag});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      int offsetHrs = int.parse(offset.substring(1,3));
      int offsetmin = int.parse(offset.substring(4,6));
      // print('$dateTime , $offset');
      // print('$offsetHrs:$offsetmin');
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: offsetHrs,minutes: offsetmin));
      isDayTime = now.hour > 6 && now.hour < 20 ? 'true' : 'false';
      time = DateFormat.jm().format(now);
    } on Exception catch (e) {
      print(e);
      time = 'something went wrong';
    }
  }
}