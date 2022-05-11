import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({Key? key}) : super(key: key);

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  var result;
  var currentTemp;
  var currentDesc;
  var currentTime;
  var currentHour;
  var iconImage;

  Future getWeather() async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=35.55982496222625&lon=45.45057035643338&units=metric&appid=78be4c7a1618f379ee045da679f47825');

    http.Response response = await http.get(url);
    result = jsonDecode(response.body);

    setState(() {
      this.currentTemp = result['current']['temp'].toString();
      this.currentDesc =
          result['current']['weather'][0]['description'].toString();
      this.currentTime =
          DateTime.fromMillisecondsSinceEpoch(result['current']['dt'] * 1000)
              .toString();
      this.currentHour =
          DateTime.fromMillisecondsSinceEpoch(result['current']['dt'] * 1000)
              .hour
              .toString();

      this.iconImage = getImage(currentHour);
    });
  }

  getImage(currentHour) {
    if (int.parse(currentHour) > 19 || int.parse(currentHour) < 5) {
      if (currentDesc == 'few clouds' ||
          currentDesc == 'scattered clouds' ||
          currentDesc == 'broken clouds' ||
          currentDesc == 'overcast clouds') {
        return Image(
          image: AssetImage('images/cloudy_night.png'),
          width: 200,
        );
      } else if (currentDesc == 'rain' || currentDesc == "light rain") {
        return const Image(
          image: AssetImage('images/rain.png'),
          width: 200,
        );
      } else if (currentDesc == 'thunder storm') {
        return const Image(
          image: AssetImage('images/thunder.png'),
          width: 200,
        );
      } else {
        return const Image(
          image: AssetImage('images/clear_night.png'),
          width: 200,
        );
      }
    } else {
      if (currentDesc == 'few clouds' ||
          currentDesc == 'scattered clouds' ||
          currentDesc == 'broken clouds' ||
          currentDesc == 'overcast clouds') {
        return const Image(
          image: AssetImage('images/cloudy_sun.png'),
          width: 200,
        );
      } else if (currentDesc == 'rain' || currentDesc == "light rain") {
        return const Image(
          image: AssetImage('images/rain.png'),
          width: 200,
        );
      } else if (currentDesc == 'thunder storm') {
        return const Image(
          image: AssetImage('images/thunder.png'),
          width: 200,
        );
      } else {
        return const Image(
          image: AssetImage('images/sun.png'),
          width: 200,
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Image(
                image: AssetImage('images/bafr.png'),
                width: 100,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Sulaymaniah',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'bafr',
                color: Color.fromARGB(255, 218, 218, 218),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(currentTime.substring(0, currentTime.indexOf('.')),
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'bafr',
                color: Color.fromARGB(255, 218, 218, 218),
              )),
        ),
        Padding(padding: EdgeInsets.all(8.0), child: getImage(currentHour)),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    currentTemp.substring(0, currentTemp.indexOf('.')) +
                        "\u00b0",
                    style: TextStyle(
                      fontSize: 70,
                      fontFamily: 'bafr',
                      color: Color.fromARGB(255, 255, 254, 254),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(currentDesc,
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'bafr',
                      color: Color.fromRGBO(255, 254, 254, 1),
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
