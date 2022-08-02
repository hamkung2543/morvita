import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginsystem/screen/add_insect.dart';

import '../main.dart';
import 'package:http/http.dart' as Http;

class ShowInsect extends StatefulWidget {
  const ShowInsect({Key? key}) : super(key: key);

  @override
  State<ShowInsect> createState() => _ShowInsectState();
}

class _ShowInsectState extends State<ShowInsect> {
  late List insectdata = [];
  @override
  void initState() {
    getinsectlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShowInsect"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddInsect()))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemCount: insectdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insectdata[index]['il_thainame'].toString()),
                Text(insectdata[index]['il_localName'].toString() +
                    "  -  " +
                    insectdata[index]['il_type'].toString())
              ],
            ),
          );
        },
      ),
    );
  }

  Future getinsectlist() async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse('https://morvita.cocopatch.com/getInsectlist_lb.php');
    Map data;
    var response = await Http.get(url);
    print(response.body);
    insectdata = json.decode(response.body);
    print(insectdata);
    setState(() {});
  }
}
