import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'seejournalist.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddJournalistsPage(title: 'Flutter Demo Enter Journalist'),
    );
  }
}

class AddJournalistsPage extends StatefulWidget {
  AddJournalistsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddJournalistsPageState createState() => _AddJournalistsPageState();
}

class _AddJournalistsPageState extends State<AddJournalistsPage> {

  final List userIcons = [
    "http://freesvg.org/img/abstract-user-flat-3.png",
    "http://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdadxzPMLa3Fwu77BKWGxuCJTABpGWVp5FHvrBa_kKvnsZPkar",
    "http://cdn2.iconfinder.com/data/icons/user-icon-2-1/100/user_5-15-512.png"
  ];
  
  final _random = new Random();
  final myController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.reference();
  var nameEditingController = TextEditingController();
  var journalistList = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  _MyNextPageState() {
    ref.child("journalists/").onChildChanged.listen((event) {
      print("Some data has been changed.");
      _updateJournalistList();
    });

    ref.child("journalists/").onChildAdded.listen((event) {
      print("Some data has been added.");
      _updateJournalistList();
    });

    ref.child("journalists/").onChildRemoved.listen((event) {
      print("Some data has been removed.");
      _updateJournalistList();
    });
  }

  void _updateJournalistList() {
    ref.child("journalists/").once().then((ds) {

      var tempList = [];
      setState(() {
        ds.value.forEach((k, v) {
          tempList.add(v);
        });
      });

      journalistList.clear();
      setState(() {
        journalistList = tempList;
      });
    }).catchError((e) {
      print("Error: " + e.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                'Add a journalist',
                style: Theme.of(context).textTheme.display1,
              ),
              margin: EdgeInsets.only(top: 15),
            ),
            Container(
              child: TextField(
                controller: nameEditingController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
            ),

            RaisedButton(
              child: Text("Add"),
              onPressed: () {
                print(nameEditingController.text.toString());
                String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
                ref.child("journalists/" + timeStamp).set(
                    {
                      "name": nameEditingController.text.toString(),
                      "value": 0,
                      "id": timeStamp,
                    }).then((res) {
                  print("Journalist is added ");
                }).catchError((e) {
                  print("Error: " + e.toString());
                });
                nameEditingController.clear();
              },
            ),
            RaisedButton(
              child: Text("Show Journalists"),
              onPressed: _updateJournalistList
            ),
            Expanded(
              child: ListView.builder(
                itemCount: journalistList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SeeJournalistsPage(title: 'Journalist Details', journalist: journalistList[index],)),
                      );
                    },
                    title: Container(
                      height: 50,
                      child: Center(
                          child: Row(
                        children: <Widget>[
//                        Image.network(journalistList[index]['name']),
                          Text('${journalistList[index]['name']}: ${journalistList[index]['value']} '),
                          //Text('Value: ${journalistList[index]['value']} '),
                        ],
                      )),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
