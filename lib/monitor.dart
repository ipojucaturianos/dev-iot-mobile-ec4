import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Monitor extends StatefulWidget {
  Monitor({Key? key}) : super(key: key);
  final String title = 'Monitor';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Monitor> {
  var loaded = false;
  final token = '';
  final getChannel = (token) => http.get(Uri.parse('https://api.thingspeak.com/channels/$token/feeds.json?results=2'));
  var lastUpdate = ' - ';
  var moisture = ' - '; // field1
  var flowRate = ' - '; // field2
  var temperature = ' - '; // field3
  var lastDate = new DateTime.now();
  var afterDate = new DateTime.now();
  var interval = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/planta.jpg', height: 120),
            const Divider(
              height: 10,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Card(
                child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        Text('Temperatura'),
                        Row(
                          children: <Widget>[
                            Icon(Icons.wb_sunny_sharp),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('$temperatureº C')
                            ),
                          ],
                        )
                      ],
                    )
                )
            ),
            Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: <Widget>[
                      Text('Umidade do solo'),
                      Row(
                        children: <Widget>[
                          Icon(Icons.wb_cloudy),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('$moisture%')
                          ),
                        ],
                      )
                    ],
                  )
                )
            ),
            Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: <Widget>[
                      Text('Água dispersada'),
                      Row(
                        children: <Widget>[
                          Icon(Icons.water),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('$flowRate L')
                          ),
                        ],
                      )
                    ],
                  )
                )
            ),
            Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: <Widget>[
                      Text('Intervalo entre regas'),
                      Row(
                        children: <Widget>[
                          Icon(Icons.more_time),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('$interval min')
                          ),
                        ],
                      )
                    ],
                  )
                )
            ),
            ElevatedButton(
                onPressed: () => {
                  setState(() {
                    loaded = true;
                  }),
                  getChannel(token).then((response) => {
                    if (response.statusCode == 200) {
                      setState(() {
                        var data = jsonDecode(response.body)['feeds'][1];
                        var data2 = jsonDecode(response.body)['feeds'][0];
                        moisture = data['field1'] != null ? '${data['field1']}' : ' - ';
                        flowRate = data['field2'] != null ? '${data['field2']}' : ' - ';
                        temperature = data['field3'] != null ? '${data['field3']}' : ' - ';
                        afterDate = new DateTime.utc(
                          int.parse(data2['created_at'].substring(0, 4)),
                          int.parse(data2['created_at'].substring(5, 7)),
                          int.parse(data2['created_at'].substring(8, 10)),
                          int.parse(data2['created_at'].substring(11, 13)),
                          int.parse(data2['created_at'].substring(14, 16)),
                          int.parse(data2['created_at'].substring(17, 19)),
                        );
                        lastDate = new DateTime.utc(
                          int.parse(data['created_at'].substring(0, 4)),
                          int.parse(data['created_at'].substring(5, 7)),
                          int.parse(data['created_at'].substring(8, 10)),
                          int.parse(data['created_at'].substring(11, 13)),
                          int.parse(data['created_at'].substring(14, 16)),
                          int.parse(data['created_at'].substring(17, 19)),
                        );
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
                        interval = lastDate.difference(afterDate).inMinutes;
                      })
                    }
                  })
                },
                child: Text('${loaded ? 'Recarregar' : 'Carregar'}')
            ),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Última atualização em: $lastUpdate.')
            ),
          ]
        )
      ));
  }
}
