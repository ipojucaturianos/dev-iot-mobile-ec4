import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Monitor extends StatefulWidget {
  Monitor({Key? key}) : super(key: key);
  final String title = 'Monitor';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Monitor> {
  final token = '';
  final getChannel = (token) => http.get(Uri.parse('https://api.thingspeak.com/channels/$token/feeds.json?results=1'));
  var lastUpdate = ' - ';
  var moisture = ' - '; // field1
  var flowRate = ' - '; // field2
  var temperature = ' - '; // field3
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Column(
                  children: <Widget>[
                    Text('Temperatura'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_time),
                        Text('$temperatureº C')
                      ],
                    )
                  ],
                )
            ),
            Card(
                child: Column(
                  children: <Widget>[
                    Text('Status'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_time),
                        Text('Regando')
                      ],
                    )
                  ],
                )
            ),
            Card(
                child: Column(
                  children: <Widget>[
                    Text('Umidade do solo'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_time),
                        Text('$moisture%')
                      ],
                    )
                  ],
                )
            ),
            Image.network("https://media.istockphoto.com/vectors/organic-culinary-garden-on-a-kitchen-windowsill-potted-greenery-in-vector-id1033883346?k=20&m=1033883346&s=612x612&w=0&h=lWEtSi9P10iUwuO7hXd1TUmOfjDGWDN4C0VWtstXFbM=", height: 200,),
            const Divider(
              height: 10,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Card(
                child: Column(
                  children: <Widget>[
                    Text('Água dispersada'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_time),
                        Text('$flowRate L')
                      ],
                    )
                  ],
                )
            ),
            Card(
                child: Column(
                  children: <Widget>[
                    Text('Intervalo entre regas (Média)'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_time),
                        Text('45 min')
                      ],
                    )
                  ],
                )
            ),
            Text('Última atualização em: $lastUpdate.'),
            ElevatedButton(
                onPressed: () => {
                  getChannel(token).then((response) => {
                    if (response.statusCode == 200) {
                      setState(() {
                        var data = jsonDecode(response.body)['feeds'][0];
                        moisture = data['field1'] != null ? '${data['field1']}' : ' - ';
                        flowRate = data['field2'] != null ? '${data['field2']}' : ' - ';
                        temperature = data['field3'] != null ? '${data['field3']}' : ' - ';
                        lastUpdate = '${
                            data['created_at'].substring(8, 10)
                        }/${
                            data['created_at'].substring(5, 7)
                        }/${
                            data['created_at'].substring(0, 4)
                        } às ${
                            int.parse(data['created_at'].substring(11, 13)) - 3
                        }h${
                            data['created_at'].substring(14, 16)
                        }min${
                            data['created_at'].substring(17, 19)
                        }';
                      })
                    }
                  })
                },
                child: Text('Recarregar')
            ),
          ]
        )
      ))
    );
  }
}
