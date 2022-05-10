import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentWeather extends StatelessWidget {
  CurrentWeather({required this.data});
  Map<dynamic,dynamic>data;



//asd w qw  qw
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Weather : ",style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.6)),),
              SizedBox(height: 5,),
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          (DateTime.fromMillisecondsSinceEpoch(data["sunset"] * 1000).isAfter(DateTime.now())) ? Icon(
                            Icons.wb_sunny,
                            color: Colors.yellow,
                            size: 80,
                          ) : FaIcon(FontAwesomeIcons.solidMoon, color: Colors.yellow,
                            size: 80,),
                          SizedBox(width: 10,),
                          Text(
                            "${data["temp"].round() - 273}°",
                            style: TextStyle(fontSize: 60),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(data["weather"][0]["description"],style: TextStyle(fontSize: 24),)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8,left: 8,bottom: 8),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.droplet,size: 18,color: Colors.blue,),
                            SizedBox(width: 5,),
                            Text("Humidity : ${data["humidity"]}%",style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8,left: 8,bottom: 8),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.wind,size: 18,color: Colors.grey,),
                            SizedBox(width: 5,),
                            Text("Wind : ${data["wind_speed"]} mph",style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8,left: 8,bottom: 8),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.temperatureHalf,size: 18,color: Colors.red),
                            SizedBox(width: 5,),
                            Text("feels like : ${data["feels_like"].round()-273}°",style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}