import 'package:dev_iot/calculate.dart';
import 'package:flutter/material.dart';
import 'package:dev_iot/sensor.dart';
import 'package:dev_iot/about_us.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Plantime'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static Widget app = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('images/plantime.png', height: 150),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('Bem-vindo!', style: TextStyle(fontSize: 20),)
        ),
      ],
    ),
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      setState(() {
        app = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/plantime.png', height: 150),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Bem-vindo!', style: TextStyle(fontSize: 20),)
              ),
            ],
          ),
        );
      });
    } else {
        if (index == 1) {
          setState(() {
            app = Monitor();
          });
      } else {
          if (index == 2) {
            setState(() {
              app = Calculate();
            });
          } else {
            setState(() {
              app = AboutUs();
            });
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightGreen,
      ),
      body: app,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units),
            label: 'Indicadores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Descição',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre Nós',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
