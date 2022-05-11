import 'package:flutter/material.dart';
import 'weatherDisplay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HourlyForcast extends StatefulWidget {
  const HourlyForcast({Key? key}) : super(key: key);

  @override
  State<HourlyForcast> createState() => _HourlyForcastState();
}

class _HourlyForcastState extends State<HourlyForcast> {
  var result;
  var hourlyList;

  Future getWeather() async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=35.55982496222625&lon=45.45057035643338&exclude=daily,minutely,current,alerts&units=metric&appid=78be4c7a1618f379ee045da679f47825');

    http.Response response = await http.get(url);
    result = jsonDecode(response.body);

    setState(() {
      hourlyList = result['hourly'];
    });
  }

  getHourData(index) {
    return hourlyList[index];
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 125.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: hourlyList.length,
            itemBuilder: (BuildContext context, int index) => Card(
              color: Color.fromARGB(131, 33, 149, 243),
              child: Center(
                child: Container(
                  width: 125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                      hourlyList[index]['dt'] * 1000)
                                  .hour
                                  .toString() +
                              (DateTime.fromMillisecondsSinceEpoch(
                                              hourlyList[index]['dt'] * 1000)
                                          .hour >
                                      12
                                  ? ":00 PM"
                                  : ":00 AM"),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'bafr',
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      getImage(
                          DateTime.fromMillisecondsSinceEpoch(
                                  hourlyList[index]['dt'] * 1000)
                              .hour
                              .toString(),
                          hourlyList[index]['weather'][0]['description']
                              .toString(),
                          50),
                      Text(
                          hourlyList[index]['temp'].toString().substring(
                                  0,
                                  hourlyList[index]['temp']
                                      .toString()
                                      .indexOf('.')) +
                              "\u00b0",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'bafr',
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
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
