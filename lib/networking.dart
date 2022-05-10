
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Functions {

  Future<Map<String,dynamic>> getlocation()async{

    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    http.Response response = await http.get(Uri.parse("http://api.positionstack.com/v1/reverse?access_key=9a3750817f0999be7a9165d1d802d4a6&query=${position.latitude},${position.longitude}"));

    http.Response response2 = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=minutely,hourly,alerts&appid=f0a8e27c7ab18da9ac7d4461d994ae57"));
    //print(jsonDecode(response.body)["data"][0]["name"]);

    var data = jsonDecode(response2.body);

    // print(DateTime.fromMillisecondsSinceEpoch(jsonDecode(response2.body)["current"]["dt"] * 1000));
    // print(DateTime.fromMillisecondsSinceEpoch(jsonDecode(response2.body)["daily"][0]["dt"] * 1000));
    //
    // print(DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(jsonDecode(response2.body)["current"]["dt"] * 1000)));

    Map<String,dynamic>mp={};

    mp["name"] = jsonDecode(response.body)["data"][0]["name"];
    mp["region"] = jsonDecode(response.body)["data"][0]["region"];
    mp["zone"] = data["timezone"];
    mp["current"] = data["current"];
    mp["forcast"] = data["daily"];

    return mp;

  }//data[0].name

}
//["results"][0]["address_components"][0]["long_name"]
//current.dt
// daily[0].dt