import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  final developers = '''
    Ellen Carvalho - 1903635
    Filipe Verrone - 1903580
    Gustavo Carvalho - 1903565
    João Severino - 1903601
    Leonardo Vargas - 1903584
    Vinicius Tirelli - 1903611
  ''';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10), child: Image.asset('images/plantime.png', height: 150,)),
            Padding(padding: EdgeInsets.all(10), child: Text('Equipe Plantime', style: TextStyle(fontSize: 25),)),
            Padding(padding: EdgeInsets.all(10), child: Text(developers, style: TextStyle(fontSize: 16),)),
          ]
      ),
    );
  }
}
