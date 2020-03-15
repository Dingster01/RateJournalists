import 'package:flutter/material.dart';
import 'addJournalist.dart';
import 'package:firebase_auth/firebase_auth.dart';


//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(title: 'Flutter Demo Sign Up'),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextField(
                        controller: emailEditingController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        controller: passwordEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),

                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 200),
              child: RaisedButton(
                child:
                Text("Sign Up", style: TextStyle(color: Colors.black),),
                onPressed: () {
                  print(emailEditingController.text.toString());
                  print(passwordEditingController.text.toString());

                  _auth.createUserWithEmailAndPassword(
                      email: emailEditingController.text.toString(), password: passwordEditingController.text.toString())
                  .then((value) {
                    print("Sign Up Successful " + value.user.uid);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              AddJournalistsPage(title: 'Add Journalists')),
                    );
                  }).catchError((e){
                    print("Sign Up Error: " + e.toString());
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
