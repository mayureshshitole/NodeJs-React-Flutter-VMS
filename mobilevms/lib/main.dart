import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool visible = false;

  final nameController = TextEditingController();
  final adrsController = TextEditingController();
  final meetController = TextEditingController();
  final phoneController = TextEditingController();

  Future addvisitor() async {
    setState(() {
      visible = true;
    });
    String name = nameController.text,
        adrs = adrsController.text,
        meet = meetController.text,
        phone = phoneController.text;

    var dio = new Dio();

    var url = "http://192.168.43.82:8878/addvisitor";

    var data = {'name': name, 'adrs': adrs, 'whom': meet, 'phone': phone};

    var responce = await dio.post(url, data: json.encode(data));
    
    if (responce.statusCode == 200) {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Addeed Successfully"),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error Adding Visitor"),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("VMS APP")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Hello VMS"),
                  SizedBox(height: 15),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Name',
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: adrsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter Address',
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: meetController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Whom?',
                      hintText: 'Enter Person name to meet',
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: 'Enter Phone number',
                    ),
                  ),
                  SizedBox(height: 25),
                  MaterialButton(
                    onPressed: addvisitor,
                    color: Colors.indigoAccent,
                    textColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(),
                    child: Text('Add Visitor'),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
