import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:http/http.dart' as http;

class Config extends StatefulWidget {
  Config({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Config> {
  final getChannel = http.get(Uri.parse('https://api.thingspeak.com/channels/1562782/feeds.json?api_key=VTRITCIT2IUZWGJD&results=2'));
  var channel = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => {
                  getChannel.then((response) => {
                    if (response.statusCode == 200) {
                      setState(() {
                        channel = '${jsonDecode(response.body)['feeds'].last}';
                      })
                    }
                  })
                },
                child: Text('Config')),
            Text(channel),
          ],
        ),
      ),
    );
  }
}
