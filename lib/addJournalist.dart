import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'journalists.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyNextPage(title: 'Flutter Demo Enter Journalist'),
    );
  }
}

class MyNextPage extends StatefulWidget {
  MyNextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNextPageState createState() => _MyNextPageState();
}

class _MyNextPageState extends State<MyNextPage> {
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
//              Expanded(
//                flex: 0,
//                child:
//                    Container(
//                      child: Text(
//                        'Add a journalist',
//                        style: Theme.of(context).textTheme.display1,
//                      ),
//                      margin: EdgeInsets.only(top: 15),
//                    ),
//              ),
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

//              Expanded(
//                flex: 20,
//                child: SingleChildScrollView(
//                  //margin: EdgeInsets.only(left: 20, right: 20),
//                  child: Column(children: <Widget>[
//                    Container(
//                      child: TextField(
//                        controller: nameEditingController,
//                        obscureText: false,
//                        decoration: InputDecoration(
//                          border: OutlineInputBorder(),
//                          labelText: 'Name',
//                        ),
//                      ),
//                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
//                    ),
//
//                  ],),
//                ),
//              ),
            RaisedButton(
              child: Text("Add"),
              onPressed: () {
                print(nameEditingController.text.toString());
                ref
                    .child("journalists/" +
                        new DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                  "name": nameEditingController.text.toString(),
                  "value": 0
                }).then((res) {
                  print("Journalist is added");
                }).catchError((e) {
                  print("Error: " + e.toString());
                });
                nameEditingController.clear();
              },
            ),
            RaisedButton(
              child: Text("Show Journalists"),
              onPressed: () {
                ref.child("journalists/").once().then((ds) {
                  journalistList.clear();

                  setState(() {
                    ds.value.forEach((k, v) {
                      journalistList.add(v);
                    });
                  });

                  print(journalistList);

                }).catchError((e) {
                  print("Error: " + e.toString());
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: journalistList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child:
                        Center(child: Text('Entry ${journalistList[index]}')),
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
