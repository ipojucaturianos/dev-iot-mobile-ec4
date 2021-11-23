import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  Description({Key? key}) : super(key: key);
  final developers = '''
    Este APP faz parte de um protótipo de tratemnto de plantas autônomo, o Plantime.
    Uma pequena estufa onde todo o cuidado das plantas é feito de forma automática, podendo ser tudo controlado e monitorado através de um celular.
    Além de poder configurar o nível de umidade e de temperatura desejada, o aplicativo também informa quais são as atuais condições da estufa, como o nível de umidade do solo, temperatura da estufa e quanto de água foi utilizado na irrigação.
    Atualmente este projeto é apenas um protótipo desenvolvido no curso de Engenharia da Computação, por enquanto sem a intenção de ser comercializado.
  ''';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10), child: Image.asset('images/plantime.png', height: 150,)),
            Padding(padding: EdgeInsets.all(10), child: Text(developers, style: TextStyle(fontSize: 14),)),
          ]
      ),
    );
  }
}
