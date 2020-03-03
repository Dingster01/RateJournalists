import 'package:flutter/material.dart';

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
  SeeJournalistsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeeJournalistsPageState createState() => _SeeJournalistsPageState();
}

class _SeeJournalistsPageState extends State<SeeJournalistsPage> {
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Text("John Smith", style: TextStyle(fontSize: 20),),
            ),
            Expanded(
              flex: 10,
              child: Text("Editor from Boston Bugle", style: TextStyle(fontSize: 12),),
            ),
            Expanded(
              flex: 15,
              child: Text("How trustworthy is this journalist?", style: TextStyle(fontSize: 18),),
            ),
            Expanded(
              flex: 50,
              child: Text("50", style: TextStyle(fontSize: 50)),
            ),
            Expanded(
              flex: 20,
              child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child:
                        FloatingActionButton(
                          heroTag: "subtract",
                          onPressed: (){},
                          child: Icon(Icons.remove),
                        ),
                        margin: const EdgeInsets.only(left: 15.0),
                    ),
                    Container(
                      child:
                        FloatingActionButton(
                          heroTag: "add",
                          onPressed: (){},
                          child: Icon(Icons.add),
                        ),
                      //alignment: Alignment(1.0, 0.0),
                      margin: const EdgeInsets.only(left: 266.0, right: 15.0),
                    ),
                  ],

                ),
            ),
          ],
        ),
      ),

    );
  }
}
