import 'package:flutter/material.dart';
import 'addJournalist.dart';

//void main() => runApp(Journalists());

class Journalists extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JournalistsPage(title: 'Flutter Demo Enter Journalist'),
    );
  }
}

class JournalistsPage extends StatefulWidget {
  JournalistsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _JournalistsPageState createState() => _JournalistsPageState();
}

class _JournalistsPageState extends State<JournalistsPage> {
  final myController = TextEditingController();

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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 15),
                      color: Colors.white,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 0),
                            child: Text("50"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Text("John Smith"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 90),
                            child: FlatButton(onPressed: () {}, child: Icon(Icons.add)),
                          ),
                          FlatButton(
                              onPressed: () {}, child: Icon(Icons.remove)),
                        ],
                      )),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    color: Colors.white,
                    child: Center(child: Text('Entry B')),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    color: Colors.white,
                    child: Center(child: Text('Entry C')),
                  ),
                ],
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyNextPage(title: 'Add a journalist')),
                  );
                },
                child: Icon(Icons.add),
              ),
              alignment: Alignment(1.0, 1.0),
              margin: const EdgeInsets.only(bottom: 10.0, right: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
