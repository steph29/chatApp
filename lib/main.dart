import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/loginController.dart';
import 'controller/mainAppController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _handleAuth(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _handleAuth(){
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged ,
        builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          // On est auth
          return new MainAppcontroller();
        }
        else{
          // on n'est pas auth
          return new LoginController();
        }
        },
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: new Text("chatapp") ,
      ),
    );
  }
}
