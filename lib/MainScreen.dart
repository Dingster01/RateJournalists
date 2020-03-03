import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'journalists.dart';
import 'package:firebase_auth/firebase_auth.dart';

//void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                    'Rate Journalists',
                    style: TextStyle(fontSize: 20.0),
                  )),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child:
                          TextField(
                            controller: emailEditingController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child:
                          TextField(
                            controller: passwordEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Login"),
                      disabledColor: Colors.grey,
                      onPressed: () {
                        _auth.signInWithEmailAndPassword(
                            email: emailEditingController.text.toString(), 
                            password: passwordEditingController.text.toString())
                        .then((value){
                          print("Sign In Successful " + value.user.uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JournalistsPage(title: 'Journalists')),
                          );
                        }).catchError((e){
                          print("Sign In Failed: " + e.toString());
                        });
                      },
                    ),
                    RaisedButton(
                      disabledColor: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpPage(title: 'Sign Up')),
                        );
                      },
                      child: Text(
                        "Sign Up",
                      ),
                    ),
//
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
