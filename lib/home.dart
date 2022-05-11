import 'package:bafr_app/dailyForcast.dart';
import 'package:bafr_app/hourlyForcast.dart';
import 'package:bafr_app/weatherDisplay.dart';
import 'package:flutter/material.dart';
import 'weatherDisplay.dart';
import 'hourlyForcast.dart';
import 'dailyForcast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/splash-cover.jpg'),
                    fit: BoxFit.cover)),
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(
              children: const [
                WeatherDisplay(),
                SizedBox(
                  height: 50,
                ),
                HourlyForcast(),
                SizedBox(
                  height: 20,
                ),
                DailyForcast()
              ],
            )));
  }
}
