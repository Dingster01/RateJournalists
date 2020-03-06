import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SeeJournalistsPage(title: 'See Journalist'),
    );
  }
}

class SeeJournalistsPage extends StatefulWidget {
  SeeJournalistsPage({Key key, this.title, this.journalist}) : super(key: key);

  final String title;
  final Map journalist;

  @override
  _SeeJournalistsPageState createState() => _SeeJournalistsPageState();
}

class _SeeJournalistsPageState extends State<SeeJournalistsPage> {
  final myController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.reference();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${widget.journalist['name']}'),
            Text('Value: ${widget.journalist['value']}'),
            Row(
              children: <Widget>[
                Container(
                  child: FloatingActionButton(
                    heroTag: "subtract",
                    onPressed: () {
                      setState(() {
                        widget.journalist['value'] -= 1;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                  alignment: Alignment(1.0, 1.0),
                  margin: const EdgeInsets.only(top: 150, left: 15.0),
                ),
                Container(
                  child: FloatingActionButton(
                    heroTag: "add",
                    onPressed: () {

                      ref.child("journalists/").once().then((ds) {
                        setState(() {
                          widget.journalist['value'] += 1;
                        });
                      }).catchError((e) {
                        print("Error: " + e.toString());
                      });

                    },
                    child: Icon(Icons.add),
                  ),
                  //alignment: Alignment(-1.0, 1.0),
                  margin: const EdgeInsets.only(top: 150, left: 265.0),
                )
              ],
            ),

          ],

        ),
      ),

    );
  }
}
