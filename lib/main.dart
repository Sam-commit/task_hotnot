import 'package:flutter/material.dart';
import 'networking.dart';
import 'current_weather.dart';
import 'daily_forcast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> mp = {};

  Future getData() async {
    mp = await Functions().getlocation();
    //print(mp);
  }

  List<int>check = [1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/6,
                ),
                ListTile(
                  title: Text(
                    mp["name"],
                    style: TextStyle(fontSize: 28),
                  ),
                  subtitle: Text(
                    mp["region"],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mp["forcast"].length+1,
                      itemBuilder: (context, index) => (index ==0 ) ? CurrentWeather(data: mp["current"]) : DailyForcast(data: mp["forcast"][index-1],day: index,)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Time zone : ${mp["zone"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Swipe to see this week's forcast",
                    style: TextStyle(fontSize: 16,color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/5,
                ),
              ],
            );

          }

          print(snapshot.connectionState);
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getData(),

      )
    );
  }
}







