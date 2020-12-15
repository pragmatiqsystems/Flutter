import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  String url= 'http://3.22.194.34/';

  List data;

  // ignore: missing_return
  Future<String> makeRequest() async{
    var response = await http.get(Uri.encodeFull(url));


    this.setState(() {
      Map<String,dynamic> extractdata = jsonDecode(response.body);
      data = extractdata["recordset"];
    });
  }


  @override
  // ignore: must_call_super
  void initState(){
    this.makeRequest();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(
          title: new Text('list'),
        ),
        body:new ListView.builder(
            itemCount: data==null? 0:data.length,
            itemBuilder: (BuildContext context,int index){
              return new Container(
                child: new Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      new Card(
                        child: new Container(
                          child: Row(children: [
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 1.0),),
                                Container(
                                  width: 25,
                                  height: 20,
                                  padding: EdgeInsets.only(left: 10.0),
                                 child: Icon(Icons.person,color: Colors.grey[400],),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 20.0),),
                            Row(
                              children: [
                                Text(data[index]['Name']),
                                Text(data[index]["Roll No"].toString()),
                              ],
                            )
                          ],),
                          padding: EdgeInsets.all(20.0),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        )

    );
  }
}
