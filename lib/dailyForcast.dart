import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DailyForcast extends StatefulWidget {
  const DailyForcast({Key? key}) : super(key: key);

  @override
  State<DailyForcast> createState() => _DailyForcastState();
}

class _DailyForcastState extends State<DailyForcast> {
  var result;
  var dailyList;
  var day;
  var weekDays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  Future getWeather() async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=35.55982496222625&lon=45.45057035643338&exclude=hourly,minutely,current,alerts&units=metric&appid=78be4c7a1618f379ee045da679f47825');

    http.Response response = await http.get(url);
    result = jsonDecode(response.body);

    setState(() {
      dailyList = result['daily'];
      day = DateTime.now().weekday;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  getImage(hour, disc, width) {
    if (int.parse(hour) > 19 || int.parse(hour) < 5) {
      if (disc == 'few clouds' ||
          disc == 'scattered clouds' ||
          disc == 'broken clouds' ||
          disc == 'overcast clouds') {
        return Image(
          image: AssetImage('images/cloudy_night.png'),
          width: width,
        );
      } else if (disc == 'rain' || disc == "light rain") {
        return Image(
          image: AssetImage('images/rain.png'),
          width: width,
        );
      } else if (disc == 'thunder storm') {
        return Image(
          image: AssetImage('images/thunder.png'),
          width: width,
        );
      } else {
        return Image(
          image: AssetImage('images/clear_night.png'),
          width: width,
        );
      }
    } else {
      if (disc == 'few clouds' ||
          disc == 'scattered clouds' ||
          disc == 'broken clouds') {
        return Image(
          image: AssetImage('images/cloudy_sun.png'),
          width: width,
        );
      } else if (disc == 'rain' || disc == "light rain") {
        return Image(
          image: AssetImage('images/rain.png'),
          width: width,
        );
      } else if (disc == 'thunder storm') {
        return Image(
          image: AssetImage('images/thunder.png'),
          width: width,
        );
      } else {
        return Image(
          image: AssetImage('images/sun.png'),
          width: width,
        );
      }
    }
  }

  getDayTemp(hour, index) {
    if (int.parse(hour) > 19 || int.parse(hour) < 5) {
      return Text(
          dailyList[index + day]['temp']['night'].toString().substring(
                  0,
                  dailyList[index + day]['temp']['night']
                      .toString()
                      .indexOf('.')) +
              "\u00b0",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'bafr',
            color: Color.fromARGB(255, 0, 0, 0),
          ));
    } else {
      return Text(
          dailyList[index + day]['temp']['day'].toString().substring(
                  0,
                  dailyList[index + day]['temp']['day']
                      .toString()
                      .indexOf('.')) +
              "\u00b0",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'bafr',
            color: Color.fromARGB(255, 0, 0, 0),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) => Card(
                  color: Color.fromARGB(131, 33, 149, 243),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          getImage(
                              DateTime.fromMillisecondsSinceEpoch(
                                      dailyList[index]['dt'] * 1000)
                                  .hour
                                  .toString(),
                              dailyList[index]['weather'][0]['description']
                                  .toString(),
                              50),
                          Text(weekDays[index].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'bafr',
                                color: Color.fromARGB(255, 0, 0, 0),
                              )),
                          getDayTemp(
                              DateTime.fromMillisecondsSinceEpoch(
                                      dailyList[index]['dt'] * 1000)
                                  .hour
                                  .toString(),
                              index),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
