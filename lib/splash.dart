import 'package:bafr_app/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/splash.jpg'),
                        fit: BoxFit.cover)),
                // ignore: prefer_const_literals_to_create_immutables
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Image(
                          image: AssetImage('images/bafr.png'),
                          width: 800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    const Text('made by:',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'bafr',
                          color: Color.fromARGB(255, 218, 218, 218),
                        )),
                    const Text('Hevar',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'bafr',
                          color: Color.fromARGB(255, 218, 218, 218),
                        ))
                  ],
                ))));
  }
}
